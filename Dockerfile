FROM ubuntu:23.10

# TODO: change repo path

# --no-cache may be needed to force docker not using cacheing things, especially if I build version 1 and then I quite quickly want to use version 2
# to run this use "sudo docker build --no-cache -t hello_world_package_test:0.0.2 ."
# to retag: "docker tag hello_world_package_test:0.0.2 ghcr.io/marekkokot/hello_world_package_test:0.0.2" #this actually add new tag?
# to add also latest tag: "docker tag ghcr.io/marekkokot/hello_world_package_test:0.0.2 ghcr.io/marekkokot/hello_world_package_test:latest"
# to push the image: "docker push ghcr.io/marekkokot/hello_world_package_test:0.0.2"
# not if I just use docker push ghcr.io/marekkokot/hello_world_package_test it will publish the latest and if I push like in line above I have both tags to the same version, which seems cool
# to login if push does not work:
# 		CR_PAT=github token
# 		"echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin"
# run example:
LABEL version="0.0.2"
LABEL org.opencontainers.image.source=https://github.com/marekkokot/hello_world_package_test
LABEL org.opencontainers.image.description="Test package hello world"
LABEL org.opencontainers.image.licenses=GPL3

# Declare the build arguments

WORKDIR /home/ubuntu
RUN apt-get update -y \
    && apt-get install -y g++ git \
    && git clone https://github.com/marekkokot/hello_world_package_test \
    && cd hello_world_package_test \
    && g++ main.cpp \
    && apt-get remove -y make git g++ \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
