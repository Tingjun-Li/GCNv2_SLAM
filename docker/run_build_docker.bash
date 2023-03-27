container_name=$1

xhost +local:
docker run -it --net=host --gpus=all \
  --user=$(id -u) \
  -e DISPLAY=$DISPLAY \
  -e QT_GRAPHICSSYSTEM=native \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
  -e XAUTHORITY \
  -e USER=pytorch_docker \
  --workdir=/home/$USER/ \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --privileged \
  -e DISPLAY=$DISPLAY \
  -v /usr/lib/nvidia:/usr/lib/nvidia \
  -v /usr/lib32/nvidia:/usr/lib32/nvidia \
  -v "/etc/passwd:/etc/passwd:rw" \
  -e "TERM=xterm-256color" \
  -v "/home/$USER/docker_folder:/home/$USER/" \
  --device=/dev/dri:/dev/dri \
  --name=${container_name} \
  --security-opt seccomp=unconfined \
  --runtime=nvidia \
  -e NVIDIA_VISIBLE_DEVICES=all \
  tingjunl/pytorch_1.0.1_gcnv2_slam:latest
