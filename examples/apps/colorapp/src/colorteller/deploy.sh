#!/usr/bin/env bash
# vim:syn=sh:ts=4:sw=4:et:ai

set -ex

if [ ! -z "$AWS_PROFILE" ]; then
    PROFILE_OPT="--profile ${AWS_PROFILE}"
fi

if [ -z $COLOR_TELLER_IMAGE ]; then
    echo "COLOR_TELLER_IMAGE environment variable is not set"
    exit 1
fi

# build
docker build -t $COLOR_TELLER_IMAGE .

# push
$(aws ecr ${PROFILE_OPT} get-login --no-include-email)
docker push $COLOR_TELLER_IMAGE
