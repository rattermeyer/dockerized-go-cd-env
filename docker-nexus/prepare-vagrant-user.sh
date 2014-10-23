#!/bin/bash
set -e

export VAGRANT_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"

echo "Preparing vagrant user..."

LOG=/tmp/prep-vagrant.log

# Create vagrant user
if $(grep -q 'vagrant' /etc/shadow); then
  echo 'Skipping vagrant user creation'
elif $(grep -q 'ubuntu' /etc/shadow); then
  echo 'vagrant user does not exist, renaming ubuntu user...'
  mv /home/{ubuntu,vagrant}
  usermod -l vagrant -d /home/vagrant ubuntu &>> ${LOG}
  groupmod -n vagrant ubuntu &>> ${LOG}
  echo -n 'vagrant:vagrant' | chpasswd
  echo 'Renamed ubuntu user to vagrant and changed password.'
else
  echo 'Creating vagrant user...'
  useradd --create-home -s /bin/bash vagrant &>> ${LOG}
  adduser vagrant sudo &>> ${LOG}
  echo -n 'vagrant:vagrant' | chpasswd
fi

# Configure SSH access
if [ -d /home/vagrant/.ssh ]; then
  echo 'Skipping vagrant SSH credentials configuration'
else
  echo 'SSH key has not been set'
  mkdir -p /home/vagrant/.ssh
  echo $VAGRANT_KEY > /home/vagrant/.ssh/authorized_keys
  chown -R vagrant: /home/vagrant/.ssh
  echo 'SSH credentials configured for the vagrant user.'
fi

# Enable passwordless sudo for the vagrant user
if [ -f /etc/sudoers.d/vagrant ]; then
  echo 'Skipping sudoers file creation.'
else
  echo 'Sudoers file was not found'
  echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant
  chmod 0440 /etc/sudoers.d/vagrant
  echo 'Sudoers file created.'
fi
