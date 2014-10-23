#!/bin/sh
chown -R nexus:nexus /srv/sonatype-work
exec /sbin/setuser nexus /srv/nexus/bin/jsw/linux-x86-64/wrapper "/srv/nexus/bin/jsw/conf/wrapper.conf" wrapper.syslog.ident=nexus wrapper.pidfile="/srv/nexus/bin/jsw/linux-x86-64/nexus.pid" wrapper.daemonize=FALSE

