FROM ubuntu:19.04
MAINTAINER Liam Keegan "liam@keegan.ch"

# compile COPASI on ubuntu 19.04 with Qt5

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    g++ \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    qt5-default \
    libqt5svg5-dev \
    uuid-dev

# clone & compile COPASI dependencies
RUN git clone https://github.com/lkeegan/copasi-dependencies /var/src/copasi-dependencies \
    && cd /var/src/copasi-dependencies \
    && ./createLinux-qt5.sh \
    && ls /var/src/copasi-dependencies/bin/lib

# clone & compile COPASI
RUN git clone https://github.com/lkeegan/COPASI /var/src/COPASI \
    && mkdir /var/src/COPASI/build \
    && cd /var/src/COPASI/build \
    && cmake \
    -DCOPASI_DEPENDENCY_DIR=/var/src/copasi-dependencies/bin \
    -DSELECT_QT=Qt5 \
    -DQT_USE_TEXTBROWSER=OFF \
    .. \
    && make \
    && make install

# run tests
# TODO

# run COPASI
RUN ./CopasiSE --version