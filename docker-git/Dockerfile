FROM ubuntu:14.04.2
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"
ENV REFRESHED_AT 2015-07-28

#ENV http_proxy http://squid:3128
#ENV https_proxy http://squid:3128
#RUN echo "Acquire::http::Proxy \"http://apt-cacher:3142\";" > /etc/apt/apt.conf.d/01proxy

# Consul
ENV SERVICE_NAME git

# update und install
RUN apt-get -qq update && apt-get install -qqy git openssh-server
# Make sure the sshd folder exists
RUN mkdir /var/run/sshd
# Clone Sample Project
RUN useradd -m git
RUN git clone --bare https://github.com/patmueller/todolist-demo.git /home/git/todolist-demo.git && chown -R git:git /home/git/todolist-demo.git
ADD post-commit /home/git/todolist-demo.git/hooks/
ADD ./prepare-git-user.sh /tmp/prepare-git-user.sh
RUN chmod u+x /tmp/prepare-git-user.sh
RUN /tmp/prepare-git-user.sh
# enable link access via ssh (git) and to git server
EXPOSE 22
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/usr/sbin/sshd", "-D"]
