#!/bin/bash 

source ./env

boxName="${BOX_NAME}"
imgName="${CELLS_DOCKER_IMAGE}"

user="${HOST_SSH_USER}"
host="${HOST_SSH_FQDN}"
port="${HOST_SSH_PORT}"
publicDomain="${HOST_SSH_FQDN}"

runningUser=${HOST_RUNNING_USER}
targetPath=${HOST_INSTALL_DIR}

echo "Deploying $imgName as $boxName in ($host)" 


# Command shortcuts
cp="ssh -p $port $user@$host"  
sp="scp -P $port"  

# Clean and prepare tree
$cp rm -rf $targetPath/$boxName
$cp mkdir -p $targetPath/$boxName/conf

echo ""
echo "... Generated .env file:" 

# Generate custom .env file
tee ./env-tmp << EOF

HOST_INSTALL_DIR=${HOST_INSTALL_DIR}
BOX_NAME=${BOX_NAME}
CELLS_DOCKER_IMAGE=${CELLS_DOCKER_IMAGE}
PUBLIC_FQDN=${PUBLIC_FQDN}

SYSADMIN_USER=${SYSADMIN_USER}
SYSADMIN_PASSWORD=${SYSADMIN_PASSWORD}
SYSADMIN_MAIL=${SYSADMIN_MAIL}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_PYDIO_USER_LOGIN=${MYSQL_PYDIO_USER_LOGIN}
MYSQL_PYDIO_USER_PASSWORD=${MYSQL_PYDIO_USER_PASSWORD}
CELLS_ADMIN_PASSWORD=${CELLS_ADMIN_PASSWORD}

EOF

echo "... End of generated .env file" 
echo "" 

# Deploy files
echo "... Deploying configuration files to $user@$host:$targetPath/$boxName"
echo "" 
$sp ./env-tmp $user@$host:$targetPath/$boxName/.env
$sp ./docker-compose.yml $user@$host:$targetPath/$boxName
$sp ./conf/* $user@$host:$targetPath/$boxName/conf

# Force permissions
$cp chown -R $runningUser:$runningUser $targetPath/$boxName

exit 0
