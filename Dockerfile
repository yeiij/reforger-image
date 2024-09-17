FROM steamcmd/steamcmd:latest

# Install dependencies that rarely change first
RUN apt-get update && \
    apt-get install -y --no-install-recommends libc6 libgcc-s1 libstdc++6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* \

# Install the Arma Reforger server (this command might be slow)
RUN steamcmd +force_install_dir /server +login anonymous +app_update 1874900 validate +quit

# Set correct permissions on the server files (frequently changed files should be handled later)
RUN chmod +x /server/ArmaReforgerServer

# Add run server script and set permissions
COPY ./config/run_server.sh /server/run_server.sh
RUN chmod +x /server/run_server.sh

# Add custom directory and copy config files
RUN mkdir -p /server/custom
COPY ./config/config.json /server/custom/config.json

# Move to working directory so all following commands run in /server
WORKDIR /server

# Expose necessary ports
EXPOSE 2001/udp

# Define the entry point and CMD
ENTRYPOINT ["./run_server.sh"]
CMD []