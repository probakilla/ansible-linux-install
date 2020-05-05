FROM debian:latest

RUN apt-get update && \
    apt-get install -y sudo ansible nano build-essential curl vim && \
    echo "root:docker" | chpasswd && \
    useradd -rm -d /home/docker -s /bin/bash \
        -p "$(openssl passwd docker)" docker && \
    usermod -aG sudo docker

USER docker
WORKDIR /home/docker/linux_install
COPY . /home/docker/linux_install

