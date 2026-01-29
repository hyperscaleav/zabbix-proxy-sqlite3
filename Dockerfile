ARG ZABBIX_VERSION
FROM zabbix/zabbix-proxy-sqlite3:${ZABBIX_VERSION}
USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install -y \
    iputils-ping \
    iputils-tracepath \
    traceroute \
    fping \
    dnsutils \
    curl \
    wget \
    nano \
    nmap \
    netcat-openbsd \
    mtr \
    iproute2 \
    tcpdump \
    snmp \
    snmp-mibs-downloader \
    jq \
    jo \
    expect
RUN curl -o speedtest.tgz https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-x86_64.tgz && tar -xvf speedtest.tgz && mv speedtest /usr/local/bin/speedtest && rm speedtest.tgz
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
COPY --chown=1997 --chmod=0711 ./scripts/* /usr/lib/zabbix/externalscripts/
USER 1997