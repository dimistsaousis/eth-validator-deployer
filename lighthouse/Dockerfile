FROM sigp/lighthouse as builder


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
RUN mkdir -p /var/lib/lighthouse/beacon/ee-secret
# ownerhsip change
RUN chown -R ${USER}:${USER} /var/lib/lighthouse/beacon
# read, write, and execute (rwx) for the owner only
RUN chmod -R 700 /var/lib/lighthouse/beacon
# read, write, and execute (rwx) for everyone
RUN chmod 777 /var/lib/lighthouse/beacon/ee-secret

# Copy the entrypoint and change the ownerhsip:
COPY --chown=${USER}:${USER} ./consensus-entry.sh /usr/local/bin/
RUN chmod -R 755 /usr/local/bin/*


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
# ownerhsip change
RUN chown ${USER}:${USER} /var/lib/lighthouse/validators
# read, write, and execute (rwx) for the owner only
RUN chmod 700 /var/lib/lighthouse/validators

RUN set -eux; \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y gosu ca-certificates tzdata git; \
        rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
        gosu nobody true

RUN set -eux; \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y gosu ca-certificates tzdata git; \
        rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
        gosu nobody true

# Copy validator scripts and change the ownerhsip
COPY --chown=${USER}:${USER} ./validator-exit.sh /usr/local/bin/
COPY --chown=${USER}:${USER} ./validator-entry.sh /usr/local/bin/
RUN chmod -R 755 /usr/local/bin/*

# For voluntary exit
ENV KEYSTORE=nonesuch

USER lhconsensus

ENTRYPOINT ["lighthouse"]