#!/bin/bash

RESOURCE_GROUP=$1


if [ -z "$(which az)" ]
then
    echo "CLI v2 'az' command not found, falling back to v1 'azure'"
    azure group create $1 "westeurope"
    azure group deployment create -f mainTemplate.json -e mainTemplateParameters.json $RESOURCE_GROUP dse

else
    echo "CLI v2 'az' command found"
    az group create --name $RESOURCE_GROUP --location "westeurope"
    az group deployment create \
     --resource-group $RESOURCE_GROUP \
     --template-file mainTemplate.json \
     --parameters @mainTemplateParameters.json \
     --verbose
fi
