# Instructions, see: https://github.com/levibostian/Dockerfiles

# This base image is updated debian 10 and is what adds systemd
# https://github.com/geerlingguy/docker-debian10-ansible
FROM geerlingguy/docker-debian10-ansible:latest 

# Below is to install and enable root login with SSH
# Help from: https://github.com/krlmlr/debian-ssh
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server sudo
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
RUN mkdir -p /var/run/sshd &&\ 
  sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config &&\
  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config &&\
  true

# expose port for connecting to ssh
EXPOSE 22 
# the CMD is a combination of systemd and SSH functionality. Run a script for SSH and then run systemd
CMD ["/run.sh", "&&", "/lib/systemd/systemd"]