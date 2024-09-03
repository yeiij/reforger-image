FROM steamcmd/steamcmd:latest

# Install the server
RUN steamcmd +force_install_dir /server +login anonymous +app_update 1874900 +quit

# Add execution permissions to the binary
RUN chmod +x /server/ArmaReforgerServer

# Check binary dependencies
# RUN ldd /server/ArmaReforgerServer

# Update and install necessary dependencies
RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
    libc6 \
    libgcc-s1 \
    libstdc++6 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Change the working directory
WORKDIR /server
