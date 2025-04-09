# reforger-image

[![Build and Pucsh Docker Image to Dockerhub](https://github.com/yeiij/reforger-image/actions/workflows/push-image.yml/badge.svg)](https://github.com/yeiij/reforger-image/actions/workflows/push-image.yml)

## Run
By default this will run a Arma Reforger Server with no mods, scenario: Game Master Arland.

- Run with default values
```commandline
docker run --name armaReforgerServer -p 2001:2001/udp -d yeiij/arma-reforger-server:latest
```
You can mount your config.json file to the container.
```commandline
docker run ... -v ./config.json:./config.json ... 
```

## Connect
You can connect to the server: **127.0.0.1:2001** or search: **JRDX**