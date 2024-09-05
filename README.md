# arma-reforger-server

[![Build and Pucsh Docker Image to Dockerhub](https://github.com/yeiij/arma-reforger-server/actions/workflows/push-image.yml/badge.svg)](https://github.com/yeiij/arma-reforger-server/actions/workflows/push-image.yml)

## Run
By default this will run a Arma Reforger Server with no mods, scenario: Game Master Arland.
- Create a network
```commandline
docker network create reforger
```
- Run with default values
```commandline
docker run -d --network reforger -p 2001:2001/udp yeiij/arma-reforger-server:latest
```
You can mount your config.json file to the container.
```commandline
docker run -v ./config.json:/server/custom/config.json ... 
```

- Run with args
```commandline
docker run ... \
    -maxFPS 120 \
    -logStats 10000
```

## Connect
You can connect to the server: **127.0.0.1:2001**