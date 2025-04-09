# ────────────────────────────────────────────────────────────────
# Stage 1: Builder - Download the Arma Reforger Server via SteamCMD
# ────────────────────────────────────────────────────────────────
FROM steamcmd/steamcmd:latest AS builder

# Install required runtime dependencies for the server binary
RUN apt update && \
    apt install -y --no-install-recommends ca-certificates lib32gcc-s1 lib32stdc++6 libcurl4 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p \
      /server/custom/addons \
      /server/custom/logs \
      /server/custom/profile \
      /server/custom/temp

# Copy custom server configuration file
COPY ./config/config.json /server/config.json

# Download Arma Reforger Server using SteamCMD
RUN steamcmd +force_install_dir /server +login anonymous +app_update 1874900 validate +quit

# ────────────────────────────────────────────────────────────────
# Stage 2: Final image - Lightweight runtime image
# ────────────────────────────────────────────────────────────────
FROM debian:bullseye-slim

# Expose required UDP ports
EXPOSE 2001/udp
EXPOSE 17777/udp
EXPOSE 19999/udp

# Install only necessary libraries for running the server
RUN apt update && \
    apt install -y --no-install-recommends ca-certificates lib32gcc-s1 lib32stdc++6 libcurl4 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copy server files from the builder stage
COPY --from=builder /server /server

# Set working directory
WORKDIR /server

# Define server entrypoint
ENTRYPOINT ["./ArmaReforgerServer"]
CMD ["-addonsDir", "./custom/addons", "-addonDownloadDir", "./custom", "-addonTempDir", "./custom/temp", "-autoreload", "10", "-config", "./config.json", "-freezeCheck", "300", "-logsDir", "./custom/logs", "-logLevel", "normal", "-logStats", "10000", "-logTime", "datetime", "-maxFPS", "120", "-profile", "./custom", "-backendLog", "-loadSessionSave", "-noThrow"]
