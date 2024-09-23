# arma-reforger-server

[![Build and Pucsh Docker Image to Dockerhub](https://github.com/yeiij/arma-reforger-server/actions/workflows/push-image.yml/badge.svg)](https://github.com/yeiij/arma-reforger-server/actions/workflows/push-image.yml)

## Run
By default this will run a Arma Reforger Server with no mods, scenario: Game Master Arland.
- Create a network
```commandline
docker network create armaReforger
```
- Run with default values
```commandline
docker run --network armaReforger --name armaReforgerServer -p 2001:2001/udp -p 17777:17777/udp -p 19999:19999/udp -d yeiij/arma-reforger-server:latest
```
You can mount your config.json file to the container.
```commandline
docker run -v ./config.json:/server/config.json ... 
```

- Run with args
```commandline
docker run ... \
    -maxFPS 120 \
    -logStats 10000
```

## Connect
You can connect to the server: **127.0.0.1:2001** or search: **JRDX**