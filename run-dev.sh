#!/usr/bin/env bash

set -o errexit

cd "$(dirname "${BASH_SOURCE[0]}")"

# Run `export FASTPL_RUN_DEV_BUILD_DOCKER_IMAGE=false` in your shell to gain a little time
if [ "$FASTPL_RUN_DEV_BUILD_DOCKER_IMAGE" != false ]
then
  docker build dev-container --tag fastpl-dev
fi

docker run \
  --rm --tty --interactive --user $(id -u):$(id -g) \
  --volume "$PWD:/project" --workdir /project \
  fastpl-dev $@
