#!/bin/bash
# In The Name Of God
# ========================================
# [] File Name : start.sh
#
# [] Creation Date : 03-07-2018
#
# [] Created By : Parham Alvani <parham.alvani@gmail.com>
# =======================================
start-loraserver() {
        docker-compose -f loraserver.io/docker-compose.yml $@
}

start-lanserver() {
        docker-compose -f lanserver/docker-compose.yml $@
}

start-mongodb() {
        docker-compose -f mongodb/docker-compose.yml $@
}

start-pm() {
        # please wait for requirements
        docker pull i1820/elrunner
        docker pull redis:alpine
        docker network create isrc

        docker-compose -f pm/docker-compose.yml $@
}

start-prometheus() {
        docker-compose -f prometheus/docker-compose.yml $@
}

start-portainer() {
        docker-compose -f portainer/docker-compose.yml $@
}

start-uprojects() {
        # el (project) containers
        docker ps -a --filter name="el_*" --format "{{.ID}}" | xargs docker start
        # rd (redis) containers
        docker ps -a --filter name="rd_*" --format "{{.ID}}" | xargs docker start
}

start-cleanup() {
        for name in $(curl -s "127.0.0.1:8080/api/project" | jq -r '.[].name'); do
	        echo $name
	        curl -X DELETE -o /dev/null -w "%{http_code}" -s "127.0.0.1:8080/api/project/$name"
        done
}

usage() {
        echo "usage: start.sh <service> [args]"
        echo "services:"

        echo "additional:"
        echo "prometheus        docker-compose prom/prometheus"
        echo "portainer         docker-compose portainer/portainer"
        echo "uprojects         starts the i1820 project/redis dockers"
        echo "cleanup           cleans the projects up"
        echo
        echo "required:"
        echo "mongodb    docker-compose mongodb"
        echo
        echo "i1820:"
        echo "pm         docker-compose i1820/pm"
        echo
        echo "protocols:"
        echo "lanserver         docker-compose i1820/lanserver"
        echo "loraserver        docker-compose brocaar/loraserver"
        echo
}

echo "Welcome to I1820 Dockerit"

if [[ $# -eq 0 ]]; then
        usage
        exit
fi

cmd=$1
shift
if [ $(type -t start-$cmd)"" = 'function' ]; then
        echo "Start $cmd"
        echo
        start=$(date +'%s')

        "start-$cmd" "$@"

        echo
        took=$(( $(date +'%s') - $start ))
        printf "Done. Took %ds.\n" $took
else
        echo "Unknown service: $cmd"
        usage
fi
