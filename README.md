# demo

## Run Commands

### Local Development

1. **Build the local container:**
   ```bash
   docker build -t demo .
   ```

2. **Run the local container:**
   ```bash
   docker run --rm -it -p 8000:1313 demo
   ```

3. **Access the application:**
   Browse at `http://<MACHINE_IP>:8000`

### CI/CD (Drone/CircleCI/GitHub)

1. **Pull the container from the shared registry:**
   ```bash
   docker pull registry.hub.docker.com/dockerdig/hello-world:<ci_used>
   ```

2. **Run the container:**
   ```bash
   docker run --rm -it -p 8000:1313 registry.hub.docker.com/dockerdig/hello-world:<ci_used>
   ```
