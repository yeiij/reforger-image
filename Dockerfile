FROM steamcmd/steamcmd:latest

# Install dependencies, install the server, and set correct permissions
RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
    libc6 \
    libgcc-s1 \
    libstdc++6 && \
    steamcmd +force_install_dir /server +login anonymous +app_update 1874900 +quit && \
    chmod +x /server/ArmaReforgerServer && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add run server script and set permissions
COPY ./config/run_server.sh /server/run_server.sh
RUN chmod +x /server/run_server.sh

# Add custom directory and set working directory
RUN mkdir -p /server/custom
# Copy config file
COPY ./config/config.json /server/custom/config.json

# Move to working directory so all following commands run in /server
WORKDIR /server

# Expose necessary ports
EXPOSE 2001/udp

# Define the entry point and CMD
ENTRYPOINT ["./run_server.sh"]
CMD []