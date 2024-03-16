FROM thorax/erigon:v2.58.2
ARG USER=erigon
ARG UID=10001
ARG GID=10002

USER root
RUN apk --no-cache add shadow bash su-exec git jq && groupmod -g "${GID}" ${USER} && usermod -u "${UID}" -g "${GID}" ${USER}
RUN mkdir -p /var/lib/erigon/jwtsecret && chown -R ${USER}:${USER} /var/lib/erigon && chmod -R 700 /var/lib/erigon && chmod 777 /var/lib/erigon/jwtsecret
COPY --chown=${USER}:${USER} ./jwtsecret.sh /usr/local/bin/
RUN chmod -R 755 /usr/local/bin/*
RUN /usr/local/bin/jwtsecret.sh

COPY --chown=${USER}:${USER} ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ${USER}
ENV KEYSTORE=nonesuch

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]