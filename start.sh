#!/bin/bash
# In The Name Of God
# ========================================
# [] File Name : start.sh
#
# [] Creation Date : 03-07-2018
#
# [] Created By : Parham Alvani <parham.alvani@gmail.com>
# =======================================
start-vernemq() {
        # deprecated
        docker-compose -f vernemq/docker-compose.yml $@
}

start-vmq-admin() {
        # deprecated
        docker-compose -f vernemq/docker-compose.yml exec vernemq vmq-admin $@
}

start-loraserver() {
        docker-compose -f loraserver.io/docker-compose.yml $@
}

start-lanserver() {
        docker-compose -f lanserver/docker-compose.yml $@
}

start-mongodb() {
        docker-compose -f mongodb/docker-compose.yml $@
}

start-link() {
        docker-compose -f link/docker-compose.yml $@
}

start-pm() {
        docker network create -d bridge --subnet 192.168.72.0/24 --gateway 192.168.72.1 i1820
	local confirm
	if [[ $1 == "up" ]]; then
		read -p "do you want to download pm required dockers? [Y/n] " -n 1 confirm; echo
        	if [[ $confirm == "Y" ]]; then
        		docker pull i1820/elrunner
			docker pull redis:alpine
        	fi
	fi

        docker-compose -f pm/docker-compose.yml $@
}

start-prometheus() {
        docker-compose -f prometheus/docker-compose.yml $@
}

start-grafana() {
        docker-compose -f grafana/docker-compose.yml $@
}

start-portainer() {
        docker-compose -f portainer/docker-compose.yml $@
}

start-upstart() {
        # el (project) containers
        docker ps -a --filter name="el_*" --format "{{.ID}}" | xargs docker start
        # rd (redis) containers
        docker ps -a --filter name="rd_*" --format "{{.ID}}" | xargs docker start
}

start-upremove() {
        # el (project) containers
        docker ps -a --filter name="el_*" --format "{{.ID}}" | xargs docker rm -f
        # rd (redis) containers
        docker ps -a --filter name="rd_*" --format "{{.ID}}" | xargs docker rm -f
}

usage() {
        echo "usage: start.sh <service> [args]"
        echo "services:"

        echo "additional:"
        echo "grafana           docker-compose grafana/grafana"
        echo "prometheus        docker-compose prom/prometheus"
        echo "portainer         docker-compose portainer/portainer"
        echo "upstart           starts the i1820 project/redis dockers"
        echo "upremove          removes the i1820 project/redis dockers"
        # echo "vmq-admin         vernemq live administration"
        echo
        echo "required:"
        echo "mongodb    docker-compose mongodb"
        # echo "vernemq    docker-compose erlio/docker-vernemq"
        echo
        echo "i1820:"
        echo "pm         docker-compose i1820/pm"
        echo "link       docker-compose i1820/link"
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
        took=$(( $(date +'%s') - start ))
        printf "Done. Took %ds.\n" $took
else
        echo "Unknown service: $cmd"
        usage
fi
