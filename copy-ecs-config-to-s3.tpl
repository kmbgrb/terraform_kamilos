#!/bin/bash

yum install -y aws-cli
aws s3 cp s3://kmbgrb/ecs.config /etc/ecs/ecs.config
