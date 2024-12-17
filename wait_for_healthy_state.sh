#!/usr/bin/env bash

docker compose up -d && \
while true; do
    if [ "$(docker compose ps --services --filter "health=starting" | wc -l)" -eq 0 ] && \
       [ "$(docker compose ps --services --filter "health=unhealthy" | wc -l)" -eq 0 ]; then
        echo "All containers are ready!"
        break
    fi
    clear
    echo "Waiting for containers to be healthy..."
    docker compose ps --format "table {{.Name}}\t{{.Status}}\t{{.Health}}"
    sleep 2
done
