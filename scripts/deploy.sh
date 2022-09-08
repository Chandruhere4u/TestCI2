#!/bin/bash

# Unofficial Bash Strict Mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -xeuo pipefail
IFS=$'\n\t'

target_account_id="584189967726"

response=$(
  aws sts assume-role                                                  \
    --role-arn "arn:aws:iam::$target_account_id:role/DemoAllAccess" \
    --role-session-name deployment-automation
)

echo "$response" | jq '.'

AWS_ACCESS_KEY_ID=$(
  echo "$response"                  \
    | jq --raw-output '.Credentials.AccessKeyId' 
)
export AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY=$(
  echo "$response"                      \
    | jq --raw-output '.Credentials.SecretAccessKey'
)
export AWS_SECRET_ACCESS_KEY

AWS_SESSION_TOKEN=$(
  echo "$response"                   \
    | jq --raw-output '.Credentials.SessionToken'
)
export AWS_SESSION_TOKEN

aws s3api create-bucket                                       \
  --bucket demo-bucket-for-netsuite-demo                      \
  --region us-west-2                                          \
  --create-bucket-configuration LocationConstraint=us-west-2

aws s3api list-buckets
