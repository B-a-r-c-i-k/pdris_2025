FROM ubuntu:20.04

RUN apt update && apt install -y openssh-server
RUN apt-get update && apt-get install -y sudo
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd -m -s /bin/bash userxd
RUN usermod -aG sudo userxd 
RUN echo "userxd:root" | chpasswd

EXPOSE 22

ENTRYPOINT service ssh start && bash