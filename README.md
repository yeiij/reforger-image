# arma-reforger-server

[![Build and Pucsh Docker Image to Dockerhub](https://github.com/yeiij/arma-reforger-server/actions/workflows/push-image.yml/badge.svg)](https://github.com/yeiij/arma-reforger-server/actions/workflows/push-image.yml)

## Run
By default this will run a Arma Reforger Server with no mods, scenario: Game Master Arland.
- Create a network
```commandline
docker network create arma-net
```
- Run with default values
```commandline
docker run -d --network arma-net -p 2001:2001/udp yeiij/arma-reforger-server:latest
```

- Run with args(Linux/bash)
```commandline
docker run -d --network arma-net -p 2001:2001/udp yeiij/arma-reforger-server:latest \
    -logLevel normal \
    -maxFPS 120 \
    -freezeCheck 300 \
    -logStats 10000
```
- Run with args(Windows/powershell)
```commandline
docker run -d --network arma-net -p 2001:2001/udp yeiij/arma-reforger-server:latest `
    -logLevel normal `
    -maxFPS 120 `
    -freezeCheck 300 `
    -logStats 10000
```
These are the default values, you can change them as you need.

You can mount your config.json file to the container in `/server/custom/config.json`.  
Add this command to the run command to mount your config file. **After run and before the image name.**
Linux  
```commandline
 -v /path/to/your/config.json:/server/custom/config.json 
```
Windows  
```commandline
 -v C:\path\to\your\config.json:/server/custom/config.json 
```