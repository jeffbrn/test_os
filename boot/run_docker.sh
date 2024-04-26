#!/bin/bash

function setup_env() {
	echo USER=$(id -u -n) > .env
	echo USR_UID=$(id -u) >> .env
	echo USR_GID=$(id -g) >> .env
}

pushd .dev-docker

setup_env

docker compose up -d

echo "*** Running the dev container ***"
docker exec -it -u ${USER} boot-os-dev /bin/bash
popd

# NOTES:
# * To rebuild add --build to compose up
# * to cleanup: dockercompose down --rmi all --remove-orphans
