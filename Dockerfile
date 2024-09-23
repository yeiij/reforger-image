FROM steamcmd/steamcmd:latest

# Define the maintainer
LABEL maintainer="yeiij"
# Define build arguments for Steam credentials (build-specific)
ARG STEAM_USERNAME="anonymous"
ARG STEAM_PASSWORD
# Define the environment variables
ENV SERVER_BINARY="ArmaReforgerServer"
ENV SERVER_DIR="/server"
ENV APP_ID=1874900
# Define the ports that the server will use
EXPOSE 2001/udp
EXPOSE 17777/udp
EXPOSE 19999/udp

# commands that rarely change first
RUN apt-get update && \
    apt-get install -y --no-install-recommends libcurl4 libssl3 net-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    steamcmd +force_install_dir ${SERVER_DIR} +login ${STEAM_USERNAME} ${STEAM_PASSWORD} +app_update ${APP_ID} validate +quit && \
    chmod +x ${SERVER_DIR}/${SERVER_BINARY} && \
    mkdir -p ${SERVER_DIR}/custom

# Copy the custom server files
COPY ./config/config.json ${SERVER_DIR}/config.json
COPY ./config/run_server.sh ${SERVER_DIR}/run_server.sh
# Set correct permissions on the server files (frequently changed files should be handled later)
RUN chmod +x ${SERVER_DIR}/run_server.sh

# Move to working directory so all following commands run in /server
WORKDIR ${SERVER_DIR}
# Define the entry point and CMD
ENTRYPOINT ["./run_server.sh"]
CMD []