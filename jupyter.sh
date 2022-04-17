#!/bin/bash
DOCKER_NAME="docker-jupyter"
DOCKER_TAG="slw07g/docker-jupyter:latest"
JUPYTER_PORT=8888
JUPYTER_NOTEBOOKS_PATH=`pwd`/jupyter-notebooks
usage()
{
  cat << EOF
usage: bash ./kali.sh [-o <ovpn_file>] [-g <github_username>]
-n    | --notebooks_path         (optional)      Path to folder containing jupyter notebooks
-p    | --port                   (optional)      Local port to forward to jupyter notebook server in container
-h    | --help                            Brings up this menu
EOF
}

while [ -n "$1" ]; do
    case $1 in
        -p | --port )
            shift
	    JUPYTER_PORT=$1
        ;;
        -n | --notebooks_path )
            shift
            JUPYTER_NOTEBOOKS_PATH=$1
        ;;
        -h | --help )    usage
            exit
        ;;
        * )              usage
            exit 1
    esac
    shift
done

docker build . -t $DOCKER_TAG

# Add a persistent docker volume, kali-staging
DOCKER_OPTS=" -v ${JUPYTER_NOTEBOOKS_PATH}:/root/jupyter-notebooks:rw --publish=${JUPYTER_PORT}:8888"
docker run --name ${DOCKER_NAME}2 -it --sysctl net.ipv6.conf.all.disable_ipv6=0 --cap-add=NET_ADMIN  $DOCKER_OPTS  $DOCKER_TAG
