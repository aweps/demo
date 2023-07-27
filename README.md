### Run commands:-

1. To build local container:

```
docker build -t demo .
```
2. To run local container:

```
docker run --rm -it -p 8000:1313 demo
```
3. Browse at http://<MACHINE_IP>:8000

4. If using CI (drone/circleci/github), run container from shared registry & then browse:

```
docker pull registry.hub.docker.com/dockerdig/hello-world:<ci_used>
docker run --rm -it -p 8000:1313 registry.hub.docker.com/dockerdig/hello-world:<ci_used>
```
