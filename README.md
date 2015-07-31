# GO CD Dockerized

This environment provides a docker-compose based CD Setup based on

- Thoughtworks GO CD server
- Thoughtworks GO CD agent
- Git Server (simple SSH)
- Nexus
- Sonarqube

# Setup

It requires a docker host setup as provided by
[vagrant-docker-host](https://github.com/rattermeyer/vagrant-docker-host)
or
[ansible-docker-host](https://github.com/rattermeyer/ansible-docker-host)

So you should be able to clone the vagrant repo and start with vagrant up.
Probably check memory constraints before running vagrant up. The
dockerized setup requires more memory


