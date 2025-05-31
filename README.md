## Redis 6 Cluster Container

### Requirements
* Podman
* Access to the Docker container repository (debian base) 

### Build Process
Running `./build.sh` will build the container image `localhost/redis6` and start a container named `redis6c`

### Running

**Starting the container:**
```bash
$ podman start redis6c
```

**Stopping the container:**
```bash
$ podman stop redis6c
```

**Running redis-cli on teh cluster:**
```bash
$ podman exec -it redis6c bash redis-cli.sh
```
