# Stage 1: Builder with steamcmd and downloading the server
FROM debian:bullseye-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for downloading the server
RUN apt-get update && \
    apt-get install -y \
    bash \
    ca-certificates \
    curl \
    lib32gcc-s1 \
    lib32stdc++6 \
    libcurl4 \
    tar \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/* && \
    useradd -m -d /home/steam steam && \
    mkdir -p /home/steam/steamcmd /home/steam/server && \
    chown -R steam:steam /home/steam

USER steam
WORKDIR /home/steam/steamcmd

# Download the Arma Reforger server (Linux version)
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    ./steamcmd.sh \
        +login anonymous \
        +force_install_dir /home/steam/server \
        +app_update 1874900 validate \
        +quit && \
    rm steamcmd_linux.tar.gz

# Stage 2: Final lighter image with Debian Slim
FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    lib32gcc-s1 \
    lib32stdc++6 \
    libcurl4 \
    && rm -rf /var/lib/apt/lists/* && \
    useradd -m -d /home/steam steam

USER steam
WORKDIR /home/steam/server

# Copy necessary files from the builder
COPY --from=builder /home/steam/server /home/steam/server

# Copy config.json
COPY --chown=steam:steam ./config/config.json /home/steam/server/config.json

# Expose necessary ports
EXPOSE 2001/udp
EXPOSE 17777/udp
EXPOSE 19999/udp

# Set the default command
CMD ["-logLevel", "normal", "-maxFPS", "120", "-config", "./config.json", "-profile", "./custom", "-freezeCheck", "300", "-logTime", "datetime", "-logStats", "10000", "-backendLog", "-noThrow", "-loadSessionSave", "-addonsDir", "./custom/addons", "-addonDownloadDir", "./custom", "-addonTempDir", "./custom/temp", "-logsDir", "./logs"]

ENTRYPOINT ["./ArmaReforgerServer"]
