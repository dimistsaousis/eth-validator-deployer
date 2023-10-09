FROM prom/prometheus:latest

COPY ./prometheus.yml /etc/prometheus

USER root
RUN chown nobody:nobody /etc/prometheus/*.yml
USER nobody

ENTRYPOINT ["/bin/prometheus", \
            "--config.file=/etc/prometheus/prometheus.yml", \
            "--storage.tsdb.path", "/prometheus", \
            "--storage.tsdb.retention.time", "40d", \
            "--web.console.libraries", "/usr/share/prometheus/console_libraries", \
            "--web.console.templates", "/usr/share/prometheus/consoles"]
