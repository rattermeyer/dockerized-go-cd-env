FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

# Install Puppet 
RUN apt-get install -y puppet
# download nexus
RUN curl http://download.sonatype.com/nexus/oss/nexus-2.9.2-01-bundle.tar.gz | tar -C /srv -xz 
VOLUME  ["/opt/sonatype-work", "/opt/nexus/conf"]
# Prepare Nexus (esp. add candidates repository)
ADD sonatype-work.tar.gz /srv/
EXPOSE 8081 
ENTRYPOINT ["/srv/nexus-2.9.2-01/bin/jsw/linux-x86-64/wrapper","/srv/nexus-2.9.2-01/bin/jsw/conf/wrapper.conf","wrapper.syslog.ident=nexus"]
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

