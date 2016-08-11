FROM centos

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Version="1.0"

RUN yum -y install ansible && yum -y clean all

EXPOSE 22
