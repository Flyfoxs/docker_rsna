#!/bin/bash
cd "$(dirname "$0")"

cur_path="$(pwd)"
echo $cur_path

mkdir -p /tmp/docker

docker_name=rsna
docker stop $docker_name
docker rm $docker_name

docker build -t $docker_name .
docker run  -it \
               --gpus all \
               -v /share/data/lung/RSNA:/input \
               -v /home/felix/.jupyter:/root/.jupyter \
	       -v /home/felix/pj/docker_rsna:/app \
		-v /tmp/docker:/tmp \
               --name $docker_name  -p 9988:8888 $docker_name
# -v /home/felix/pj/detectron2:/home/appuser/detectron2_repo \
