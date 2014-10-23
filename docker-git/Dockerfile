FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

# update und install
RUN apt-get update
RUN apt-get install -y git
# Prepare for Vagrant
ADD ./prepare-vagrant-user.sh /tmp/
RUN chmod u+x /tmp/prepare-vagrant-user.sh
RUN /tmp/prepare-vagrant-user.sh 
# Clone Sample Project
RUN useradd -m git
RUN git clone --bare https://github.com/rattermeyer/todolist-demo.git /home/git/todolist-demo.git && chown -R git:git /home/git/todolist-demo.git
ADD post-commit /home/git/todolist-demo.git/hooks/
ADD ./prepare-git-user.sh /tmp/prepare-git-user.sh
RUN /tmp/prepare-git-user.sh
# enable link access via ssh (git) and to Nexus
EXPOSE 22
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

