FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"
ENV REFRESHED_AT 2015-02-17

RUN apt-get -qq update 

# Install Puppet 
RUN apt-get install -y puppet
# download nexus
RUN curl https://sonatype-download.global.ssl.fastly.net/nexus/oss/nexus-2.11.1-01-bundle.tar.gz | tar -C /srv -xz 
VOLUME  ["/opt/sonatype-work", "/opt/nexus/conf"]
# Prepare Nexus (esp. add candidates repository)
ADD sonatype-work.tar.gz /srv/
EXPOSE 8081 
ENTRYPOINT ["/srv/nexus-2.11.1-01/bin/jsw/linux-x86-64/wrapper","/srv/nexus-2.11.1-01/bin/jsw/conf/wrapper.conf","wrapper.syslog.ident=nexus"]
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

