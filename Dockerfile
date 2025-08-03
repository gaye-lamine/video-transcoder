FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  ffmpeg \
  python3-pip \
  awscli \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /input /output
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
