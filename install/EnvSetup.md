# Tip And Tricks to set up your env

## Debian

```sh

# Add Caddy2

# Add docker
apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/debian  $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce

# docker-compose
# check latest version at: https://github.com/docker/compose/releases
version=1.27.4
curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


# Create a dedicated user
adduser robot
usermod -aG docker robot

# Enable service
systemctl enable docker
```
