FROM ubuntu

RUN apt-get update && apt-get install -y \
    hugo \
 && rm -rf /var/lib/apt/lists/*

RUN hugo new site my-project && \
    cd my-project && \
    git init && \
    git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke && \
    echo 'theme = "ananke"' >> config.toml

COPY hello.md my-project/content/posts/hello.md

WORKDIR my-project
ENTRYPOINT ["/usr/bin/hugo","server", "--bind", "0.0.0.0"]
