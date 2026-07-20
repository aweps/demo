#!/bin/bash
set -Eeuo pipefail
if [ "$(echo "${DEBUG:-}" | tr '[:upper:]' '[:lower:]')" = "true" ]; then set -x; fi

function exportVars()
{
	set +x
	source /dev/stdin <<<"$(grep -v '^#' $1 | grep -E '^[A-Za-z_][A-Za-z0-9_]*=' | sed -re "s/^([^=]+)=([^']+).*/\1='\2'/" | grep = | sed -re "s/^[^=]+=.*[^'=]$/\0'/" | sed -re "s/^[^=]+='$/\0'/" | sed -E -n 's/[^#]+/export &/ p')"

	if [ "$(echo "${DEBUG:-}" | tr '[:upper:]' '[:lower:]')" = "true" ]; then set -x; fi
}
exportVars ./.env

docker-compose up -d --build
