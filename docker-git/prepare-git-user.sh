#!/bin/bash
set -e

export CI_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC55YzI8t2nnLSCwGMu11oRiogCUDM84OJqfjQjSnbnjIsIXoglOlA8xMxz+YIx1XfCsKbHl84G9WDZSQdzMnzIc25JQd4KFnXUukdQgFEV/HxKTckWGT2sGhPYf8UposlrSZBGD1afjUepGrIypy+/cq9BWBgnwrfVtZK9iX31JJlF1kBzoglGHEtAyFVhj6VBaUYFzFyICyBep6Zk3kXjePVyAiKxznnuxjyRj9DFWZKhKMDuka/XWaWDQuOczVUSnrQlJh5o7CLOKwcZOzD3GFZ1Cc/ME5sn3HM/jLaF1lCNIKCDnEpRF4o+seUSU+1WOSFAMo447NQ8Pg6rXDA3 dev@dev"

echo "Preparing git user..."

# Configure SSH access
if [ -d /home/git/.ssh ]; then
  echo 'Skipping git SSH credentials configuration'
else
  echo 'SSH key has not been set'
  echo -n 'git:git' | chpasswd
  mkdir -p /home/git/.ssh
  echo $CI_KEY > /home/git/.ssh/authorized_keys
  chown -R git:git /home/git/.ssh
  echo 'SSH credentials configured for the git user.'
fi

