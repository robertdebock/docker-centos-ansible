FROM centos

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Version="1.0"


RUN yum -y install openssh openssh-server openssh-clients && \
    yum -y install epel-release && \
    yum -y install ansible && \
    yum -y clean all

CMD test -f /etc/ssh/ssh_host_ecdsa_key || /usr/bin/ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -C '' -N ''&&  \
    test -f /etc/ssh/ssh_host_rsa_key || /usr/bin/ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''&&  \
    test -f /etc/ssh/ssh_host_ed25519_key || /usr/bin/ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -C '' -N ''&&  \
    test -f /root/.ssh/id_dsa || /usr/bin/ssh-keygen -t dsa -f /root/.ssh/id_dsa -N '' && \
    test -f /root/.ssh/id_dsa.pub || ssh-keygen -y -t dsa -f ~/.ssh/id_dsa > ~/.ssh/id_dsa.pub && \
    test -f /root/.ssh/authorized_keys || /usr/bin/cp /root/.ssh/id_dsa.pub /root/.ssh/authorized_keys && \
    /usr/bin/cat /root/.ssh/id_dsa && \
    /usr/bin/echo "" && \
    /usr/bin/echo "Please save the printed private DSA key and login using:" && \
    /usr/bin/echo "\"ssh -i \${savedkey} root@\${ipaddress}\"" && \
    /usr/sbin/sshd -D

EXPOSE 22
