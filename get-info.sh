#!/bin/bash

for inst in `aws ec2 describe-instances  | grep 'InstanceId' | awk '{print $2 }' | sed 's/[\",]//g' `; do
	aws ec2 describe-instances --filter Name="instance-id",Values="${inst}" > ${inst}.json

	echo '||--------------------------------EC2 info---------------------------------------------||'
	echo "Name: $(cat ${inst}.json | jq -c '.Reservations[0].Instances[0].Tags[] | select(.Key =="Name").Value')"
	echo "ID: $(cat ${inst}.json | jq -c '.Reservations[0].Instances[0].InstanceId')"
	echo "Instancte Size: $(cat ${inst}.json | jq -c '.Reservations[0].Instances[0].InstanceType ')"
	echo "VPC: $(cat ${inst}.json | jq -c '.Reservations[0].Instances[0].VpcId ')"
	echo "Private IP: $(cat ${inst}.json | jq -c '.Reservations[0].Instances[0].PrivateIpAddress')"
	rm ${inst}.json
done
