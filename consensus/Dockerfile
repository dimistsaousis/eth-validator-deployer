FROM sigp/lighthouse

# **** CONSENSUS ****
ARG USER=lhconsensus
ARG UID=10002
# 1. Create user
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"

# Data mount with permissions:
RUN mkdir -p /var/lib/lighthouse/beacon/jwtsecret
RUN chown -R ${USER}:${USER} /var/lib/lighthouse/beacon
RUN chown -R ${USER}:${USER} /var/lib/lighthouse
RUN chmod -R 700 /var/lib/lighthouse/beacon
RUN chmod 777 /var/lib/lighthouse/beacon/jwtsecret

COPY entrypoint.sh /usr/local/bin/
RUN chown -R ${USER}:${USER} /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh


# For voluntary exit
ENV KEYSTORE=nonesuch
USER lhconsensus

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

