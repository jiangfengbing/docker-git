FROM debian:buster-20200224-slim
MAINTAINER Jiang Fengbing "jiangfengbing@cmcm.com"

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 19.03.5
ENV TZ Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  && sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list \
  && sed -i 's|security.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list \
  && apt update && apt install -y ca-certificates wget curl dnsutils traceroute \
     telnet openssl libssl-dev \
     git git-lfs \
  && rm -rf /var/lib/apt/lists/* \
  && wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
  && tar --extract \
  		 --file docker.tgz \
  		 --strip-components 1 \
  		 --directory /usr/local/bin/ \
  && rm docker.tgz

