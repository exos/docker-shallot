# shallot (onion generator) docker image
FROM debian:jessie AS builder
LABEL Description="Shallot docker image by exos (builder)" Vendor="exos@kaktheplanet.xyz" Version="0.0.3"
LABEL maintainer="exos@kaktheplanet.xyz"

WORKDIR /src

RUN apt-get update -y && apt-get install -y wget gcc make libssl-dev

RUN wget https://github.com/katmagic/Shallot/archive/shallot-${VERSION:-0.0.3}.tar.gz \
    && tar -xf shallot-${VERSION:-0.0.3}.tar.gz \
    && cd Shallot-shallot-${VERSION:-0.0.3} \
    && ./configure && make

RUN echo "#!/bin/bash\nwhile [ 1 ]; do sh -c \"/bin/shallot -t \$THREADS -f \$OUTPUT \$EXTRA_PARAMS \$PATTERN\"; done" > /src/entrypoint.sh && chmod +x /src/entrypoint.sh

FROM debian:jessie
LABEL Description="Shallot docker image by exos" Vendor="exos@kaktheplanet.xyz" Version="0.0.3"
LABEL maintainer="exos@kaktheplanet.xyz"

	
RUN apt-get update && apt-get install -y libssl1.0.0 && rm -rf /var/cache/apt/*

VOLUME /data

COPY --from=builder /src/Shallot-shallot-${VERSION:-0.0.3}/shallot /bin
COPY --from=builder /src/entrypoint.sh /

ENV THREADS="\$(grep processor /proc/cpuinfo| wc -l )"
ENV OUTPUT="/data/\$(date +%s.%N)"
ENV PATTERN="^test"
ENV EXTRA_PARAMS=""

ENTRYPOINT /entrypoint.sh
