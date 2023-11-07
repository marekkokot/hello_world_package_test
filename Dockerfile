FROM ubuntu:23.10

# TODO: change repo path

# to run this use "sudo docker build -t hello_world_package_test:0.0.2 ."
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
