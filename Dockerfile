#
# Dockerfile for shadowsocks-libev
#

FROM alpine:edge
LABEL maintainer="xczh" \
      maintainer.email="xczh.me@foxmail.com" \
      description="shadowsocks-libev"

ARG SS_VER=
ARG SS_URL=https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_VER/shadowsocks-libev-$SS_VER.tar.gz

ENV PASSWORD=ss-libev
ENV METHOD=aes-256-gcm
ENV TIMEOUT=45
ENV DNS_ADDR=8.8.8.8
ENV ARGS=

RUN set -ex && \
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                build-base \
                                curl \
                                libev-dev \
                                c-ares-dev \
                                libtool \
                                linux-headers \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar \
                                udns-dev && \
    cd /tmp && \
    echo "Using shadowsocks-libev v${SS_VER}..." && \
    curl -sSL ${SS_URL} | tar xz --strip 1 && \
    ./configure --prefix=/usr --disable-documentation && \
    make install && \
    cd .. && \

    runDeps="$( \
        scanelf --needed --nobanner /usr/bin/ss-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
    )" && \
    apk add --no-cache --virtual .run-deps ${runDeps} && \
    apk del .build-deps && \
    rm -rf /tmp/*

USER nobody

EXPOSE 6011/tcp 6011/udp

CMD ss-server -s 0.0.0.0 \
              -p 6011 \
              -k ${PASSWORD} \
              -m ${METHOD} \
              -t ${TIMEOUT} \
              --reuse-port \
              --fast-open \
              -d ${DNS_ADDR} \
              -u \
              ${ARGS}
