FROM steamcmd/steamcmd:latest

# Install the server
RUN steamcmd +force_install_dir /server +login anonymous +app_update 1874900 +quit