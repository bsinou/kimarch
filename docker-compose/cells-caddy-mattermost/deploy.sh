#!/bin/bash 

host=${1:-"test.example.com"} 
port=${2:-"22"}
user=${3:-"root"}
runningUser=${4:-"robot"}


source ./.env

targetPath=${VAR_DIR:-"/var/kimarch"}
boxName=${BOX_NAME:-"team"}

echo "Deploying compose setup @ " $host:$targetPath/$boxName

# Command shortcuts
cp="ssh -p $port $user@$host"  
sp="scp -P $port"  

# Clean
$cp rm -rf $targetPath/$boxName/src
$cp mkdir -p $targetPath/$boxName/src/conf


# Deploy files
$sp ./.env $user@$host:$targetPath/$boxName/src/.env
$sp ./docker-compose.yml $user@$host:$targetPath/$boxName/src/
$sp ./reset.sh $user@$host:$targetPath/$boxName/src/
$sp ./reinstall.sh $user@$host:$targetPath/$boxName/src/
$sp ./conf/* $user@$host:$targetPath/$boxName/src/conf

# Force permissions
$cp chown -R $runningUser:$runningUser  $targetPath/$boxName

exit 0