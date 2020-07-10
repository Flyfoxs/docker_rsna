#!/bin/bash
cd "$(dirname "$0")"

cur_path="$(pwd)"
echo $cur_path

mkdir -p /tmp/docker

docker_name=share_cuda10
docker stop $docker_name
docker rm $docker_name

docker build -t $docker_name .
docker run  -dit \
               --gpus all \
               -v /share/data/lung/RSNA:/input \
               -v /home/felix/.jupyter:/root/.jupyter \
	       -v /home/docker_user:/app \
	      -v /tmp/docker:/tmp \
               --name $docker_name  -p 8885:8888 $docker_name
# -v /home/felix/pj/detectron2:/home/appuser/detectron2_repo \
