#!/bin/bash 

# Retrieve variable
source .env
boxname=$BOX_NAME

cmd="docker-compose -p ${boxname} "
$cmd stop cells mysql
$cmd rm -f cells mysql
docker volume rm -f ${BOX_NAME}_cells_working_dir ${BOX_NAME}_mysql_data
$cmd up -d mysql
$cmd pull cells
sleep 5
$cmd up -d --force-recreate cells

