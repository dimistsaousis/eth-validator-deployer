FROM sigp/lighthouse as builder

# **** VALIDATOR ****
ARG USER=lhvalidator
ARG UID=10000
# 1. Create user
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"


# Create data moun
RUN mkdir -p /var/lib/lighthouse/validators
RUN chown ${USER}:${USER} /var/lib/lighthouse/validators
RUN chmod 700 /var/lib/lighthouse/validators 
# Keymanager script
COPY keymanager.sh /keymanager.sh
RUN chmod +x /keymanager.sh
RUN chown ${USER}:${USER} /keymanager.sh

# Keys
RUN mkdir -p /keystore
RUN chown ${USER}:${USER} /keystore
RUN chmod 700 /keystore

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chown ${USER}:${USER} /usr/local/bin/entrypoint.sh


# For voluntary exit
ENV KEYSTORE=nonesuch

RUN set -eux; \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y gosu ca-certificates tzdata git; \
        rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
        gosu nobody true

USER lhvalidator
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

