FROM ubuntu:19.04
MAINTAINER Liam Keegan "liam@keegan.ch"

# compile COPASI on ubuntu 19.04 with Qt5

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
    python-dev \
    swig \
    qt5-default \
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
    -G Ninja \
    -DCOPASI_DEPENDENCY_DIR=/var/src/copasi-dependencies/bin \
    -DSELECT_QT=Qt5 \
    -DENABLE_PYTHON=ON \
    -DPYTHON_EXECUTABLE=/usr/bin/python \
    -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so \
    -DBUILD_CATCH_TESTS=ON \
    -DBUILD_FRANKS_TESTSUITE=ON \
    -DBUILD_SBML_TESTSUITE=ON \
    -DBUILD_TESTS=ON \
    -DBUILD_SEMANTIC_TESTSUITE=ON \
    -DBUILD_STEADY_STATE_RUNNER=OFF \
    -DBUILD_STOCHASTIC_TESTSUITE=ON \
    -DBUILD_MCA_RUNNER=OFF \
    .. \
    && ninja install

# run tests
# TODO

# run COPASI
RUN CopasiSE -h