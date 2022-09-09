#!/bin/bash

# Unofficial Bash Strict Mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -xeuo pipefail
IFS=$'\n\t'

target_account_id="350978175498"

response=$(
  aws sts assume-role                                                  \
    --role-arn "arn:aws:iam::$target_account_id:role/Test-Git-ECS-Role" \
    --role-session-name test-demo-gitActions
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
  --bucket git-action-bucket-350978175498-c-5                      \
  --region us-east-1                                          \
  #--create-bucket-configuration LocationConstraint=us-east-1

aws s3api list-buckets
