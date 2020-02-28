FROM debian:latest

RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get install -y ansible && \
    useradd -ms /bin/bash docker && \
    echo "root:Docker!" | chpasswd

USER docker
WORKDIR /home/docker
COPY . /home/docker/linux_install

