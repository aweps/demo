FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    hugo \
 && rm -rf /var/lib/apt/lists/*

RUN cd /srv && hugo new site hugo && \
    cd hugo && \
    git clone https://github.com/panr/hugo-theme-terminal.git themes/terminal

COPY config.toml /srv/hugo/config.toml
COPY hello.md /srv/hugo/content/posts/hello.md

WORKDIR /srv/hugo
ENTRYPOINT ["sh", "-c", "/usr/bin/hugo server --bind=0.0.0.0 --baseURL=$APP_BASEURL --appendPort=false --disableFastRender"]
