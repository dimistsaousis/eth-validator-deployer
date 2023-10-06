FROM golang:1.20.1 AS builder
RUN git clone https://github.com/ledgerwatch/erigon.git /erigon
WORKDIR /erigon
RUN make erigon
FROM ubuntu:latest AS stage-1
COPY --from=builder /erigon/build/bin/erigon /usr/local/bin/erigon
ENTRYPOINT ["erigon", \
            "--datadir", "data", \
            "--prune", "htc", \
            "--chain", "goerli"]