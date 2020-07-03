### Run commands:-

1. To build local container:

docker build -t hello-world .

2. To run local container:

docker run --rm -it -p 8000:1313 hello-world

3. Browse at http://<MACHINE_IP>:8000

4. If using CI, run container from shared registry & then browse:

docker run --rm -it -p 8000:1313 <registry>/<repo>
