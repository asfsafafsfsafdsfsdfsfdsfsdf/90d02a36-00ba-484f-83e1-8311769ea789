FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ttyd \
    bash \
    curl \
    wget \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/local/bin/pawns-cli https://pawns-app.s3.eu-central-1.amazonaws.com/cli/latest/linux_x86_64/pawns-cli
RUN chmod +x /usr/local/bin/pawns-cli

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENV PORT=443

CMD ["/run.sh"]
