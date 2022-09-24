#!/bin/bash
DOCKER_NAME="docker-jupyter"
DOCKER_TAG="slw07g/docker-jupyter:latest"
JUPYTER_PORT=8888
JUPYTER_NOTEBOOKS_PATH="$(pwd)/jupyter_notebooks"
usage()
{
  cat << EOF
usage: bash ./jupyter.sh [-o <ovpn_file>] [-g <github_username>]
-n    | --notebooks_path         (optional)      Path to folder containing jupyter notebooks
-p    | --port                   (optional)      Local port to forward to jupyter notebook server in container
-h    | --help                                   Brings up this menu
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

if [[ ! -d $JUPYTER_NOTEBOOKS_PATH ]]; then mkdir -p $JUPYTER_NOTEBOOKS_PATH; fi
JUPYTER_NOTEBOOKS_PATH=`readlink -f $JUPYTER_NOTEBOOKS_PATH`
if [[ -L ./notebooks_symlink ]]; then rm -f ./notebooks_symlink; fi
if [[ ! -f notebooks_symlink ]]; then ln -s $JUPYTER_NOTEBOOKS_PATH notebooks_symlink; fi

# Add a persistent docker volume, kali-staging
DOCKER_OPTS="--mount type=bind,source=${JUPYTER_NOTEBOOKS_PATH},target=/root/jupyter-notebooks --publish=$JUPYTER_PORT:8888"
cmd="docker run --rm --name ${DOCKER_NAME}2 -it --sysctl net.ipv6.conf.all.disable_ipv6=0 --cap-add=NET_ADMIN  $DOCKER_OPTS  $DOCKER_TAG"
echo $cmd
$cmd
