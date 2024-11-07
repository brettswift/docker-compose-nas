#!/usr/bin/env bash

# run with the secrets file and then take all args

docker compose --env-file .env --env-file .env.secrets "$@"
