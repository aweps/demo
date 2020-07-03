FROM ubuntu

RUN apt-get update && apt-get install -y \
    hugo \
 && rm -rf /var/lib/apt/lists/*

RUN cd ~/ && hugo new site hugo && \
    cd hugo && \
    git init && \
    git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke && \
    echo 'theme = "ananke"' >> config.toml

COPY hello.md /root/hugo/content/posts/hello.md

WORKDIR /root/hugo
ENTRYPOINT ["/usr/bin/hugo","server", "--bind", "0.0.0.0"]
