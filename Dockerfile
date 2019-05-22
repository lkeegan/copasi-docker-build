FROM ubuntu:19.04
MAINTAINER Liam Keegan "liam@keegan.ch"

# Ubuntu 19.04 image with COPASI compilation dependencies pre-installed

# install apt dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    git \
    g++ \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libqt5datavisualization5-dev \
    libqt5svg5-dev \
    ninja-build \
    openjdk-8-jdk \
    python-dev \
    swig \
    qt5-default \
    uuid-dev

# clone & compile COPASI dependencies
RUN git clone https://github.com/copasi/copasi-dependencies /var/src/copasi-dependencies \
    && cd /var/src/copasi-dependencies \
    && ./createLinux-qt5.sh \
    && ls /var/src/copasi-dependencies/bin/lib

# clone sbml-test-suite data for SBML semantic tests
RUN git clone https://github.com/sbmlteam/sbml-test-suite /var/src/sbml-test-suite