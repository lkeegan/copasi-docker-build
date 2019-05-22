# copasi-docker-build [![Build Status](https://travis-ci.org/lkeegan/copasi-docker-build.svg?branch=master)](https://travis-ci.org/lkeegan/copasi-docker-build)
This repo contains two items:

  - `dockerfile`
    - this generates an Ubuntu 19.04 image with all the compilation dependencies of COPASI pre-installed
    - this image can be downloaded and ran interactively using `docker run -it lkeegan/copasi-docker-build`
    
  - `.travis.yaml`
    - this runs the docker image on travis
    - it clones and compiles COPASI using this image
    - then runs the tests

Docker build that compiles COPASI from source on Ubuntu 19.04 with Qt5

Serves as a reference set of commands that can be used to compile COPASI, based on the instructions from https://github.com/copasi/COPASI and https://github.com/copasi/copasi-dependencies.

Also available as a pre-built image on [docker hub](https://hub.docker.com/r/lkeegan/copasi-docker-build) or via `docker pull lkeegan/copasi-docker-build`
