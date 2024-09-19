FROM steamcmd/steamcmd:latest

# Define the maintainer
LABEL maintainer="yeiij"
# Define build arguments for Steam credentials (build-specific)
ARG STEAM_USERNAME="anonymous"
ARG STEAM_PASSWORD
# Define the environment variables
ENV SYS_USER="aru"
ENV SYS_GROUP="arg"
ENV SERVER_DIR=/home/${SYS_USER}/server
ENV APP_ID=1874900
# Define the ports that the server will use
EXPOSE 2001/udp

# commands that rarely change first
RUN apt-get update && \
    apt-get install -y --no-install-recommends libc6 libgcc-s1 libstdc++6 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r ${SYS_GROUP} && useradd -m -r -g ${SYS_GROUP} ${SYS_USER} && \
    steamcmd +force_install_dir ${SERVER_DIR} +login ${STEAM_USERNAME} ${STEAM_PASSWORD} +app_update ${APP_ID} validate +quit && \
    mkdir -p ${SERVER_DIR}/custom

# Copy the custom server files
COPY ./config/run_server.sh ${SERVER_DIR}/run_server.sh
COPY ./config/config.json ${SERVER_DIR}/custom/config.json
# Change ownership of the server directory to the non-root user
RUN chown -R ${SYS_USER}:${SYS_GROUP} ${SERVER_DIR}
# Switch to the new user
USER ${SYS_USER}
# Set correct permissions on the server files (frequently changed files should be handled later)
RUN chmod +x ${SERVER_DIR}/ArmaReforgerServer && \
    chmod +x ${SERVER_DIR}/run_server.sh

# Move to working directory so all following commands run in /server
WORKDIR ${SERVER_DIR}
# Define the entry point and CMD
ENTRYPOINT ["./run_server.sh"]
CMD []