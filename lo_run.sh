#!/bin/bash
set -Eeuo pipefail
if [ "$(echo "${DEBUG:-}" | tr '[:upper:]' '[:lower:]')" = "true" ]; then set -x; fi

function exportVars()
{
	set +x
	# Same quoting transform as before, applied line-by-line so a value that
	# defeats it fails HERE, naming the source file and line -- not later as an
	# opaque '/dev/stdin: line N' abort. Values are never echoed: these files
	# carry secrets.
	local _src=$1 _lineno=0 _line _xline _out=""
	while IFS= read -r _line || [ -n "$_line" ]; do
		_lineno=$((_lineno + 1))
		case "$_line" in '#'*) continue ;; esac
		# || _xline="": under the caller's set -e/pipefail an empty or
		# non-KEY=value line exits this pipeline 1 (grep finds no '='), which
		# would kill the shell before the continue below ever runs
		# (2026-07-19 live-baker find; every .env.common leads with a blank line).
		_xline=$(printf '%s\n' "$_line" | sed -re "s/^([^=]+)=([^']+).*/\1='\2'/" | grep = | sed -re "s/^[^=]+=.*[^'=]$/\0'/" | sed -re "s/^[^=]+='$/\0'/" | sed -E -n 's/[^#]+/export &/ p') || _xline=""
		[ -n "$_xline" ] || continue
		if ! printf '%s\n' "$_xline" | grep -Eq '^export [A-Za-z_][A-Za-z0-9_]*='; then
			echo "exportVars: $_src line $_lineno: does not reduce to a single KEY=value export (value withheld)" >&2
			exit 1
		fi
		_out="${_out}${_xline}
"
	done < "$_src"
	source /dev/stdin <<<"$_out"

	if [ "$(echo "${DEBUG:-}" | tr '[:upper:]' '[:lower:]')" = "true" ]; then set -x; fi
}
exportVars ./.env

docker-compose up -d --build
