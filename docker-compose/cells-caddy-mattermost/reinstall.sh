#!/bin/bash 

# Retrieve variable
source .env
boxname=$BOX_NAME
cmd="docker-compose -p ${boxname} "

$cmd down --remove-orphan --volumes
$cmd pull 
$cmd up certs
$cmd up -d reverse prometheus mysql mysql2 cadvisor
sleep 10
$cmd up -d cells mattermost


# Log current binary version in logs folder to ease debug
#sleep 2
#$cmd exec cells cells version | $cmd exec -T cells tee /var/cells/logs/version.info
