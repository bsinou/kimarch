#!/bin/bash 

# Retrieve parameters
source .env
boxname=$BOX_NAME
targetPath=${VAR_DIR:-"/var/cells"}/$boxname
binaryPath=$1

cmd="docker-compose -p ${boxname} "
$cmd stop cells

# Remove old container
$cmd rm -f cells

# Reset Cells DB 
$cmd exec mysql mysql -upydio -pcells -e "DROP DATABASE cells; CREATE DATABASE cells;"

# Reset Cells working dir by removing named volume
docker volume rm -f ${BOX_NAME}_cells_working_dir
echo "After cleaning working dir at: [$targetPath/run]"
docker volume ls 

# Reset Cells binary if one has been provided
if [ -f ${binaryPath} ]; then
    rm -rf /var/cells/${boxname}/bin
    mkdir /var/cells/${boxname}/bin
    cp ${binaryPath} /var/cells/${boxname}/bin/cells
    chmod u+x /var/cells/${boxname}/bin/cells
fi


$cmd pull cells
# Superstition ? 
sleep 2

# Relaunch the container
$cmd up -d cells
#$cmd up -d --force-recreate cells

# Wait for a while and log current binary version in logs folder to ease debug
sleep 20
$cmd exec cells cells version | $cmd exec -T cells tee /var/cells/logs/version.info
