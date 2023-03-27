FROM nvidia/cudagl:10.0-devel-ubuntu16.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        git \
        vim \
        build-essential \
        libeigen3-dev \
        libopencv-dev \
        libglew-dev \
        libglfw3-dev \
        python-dev \
        python-numpy \
        python-pip \
        python-wheel \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libxvidcore-dev \
        libx264-dev \
        libatlas-base-dev \
        gfortran \
        cmake \
        wget

# Install Nvidia cudnn library
ARG nvidia_cudnn_version=7.6.5.32-1+cuda10.0
ENV NVIDIA_CUDNN_VERSION=${nvidia_cudnn_version}
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn7=${NVIDIA_CUDNN_VERSION} \
    libcudnn7-dev=${NVIDIA_CUDNN_VERSION} \
    && apt-mark hold libcudnn7 \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch C++ API
RUN apt-get update && apt-get install -y python-yaml
RUN pip install typing
RUN git clone -b v1.0.1 --recursive https://github.com/pytorch/pytorch.git
RUN cd pytorch && \
    git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    python ../tools/build_libtorch.py

# Upgrade Cmake:
RUN apt remove --purge cmake -y
RUN apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/Kitware/CMake/releases/download/v3.24.1/cmake-3.24.1-Linux-x86_64.sh \
    -q -O /tmp/cmake-install.sh \
    && chmod u+x /tmp/cmake-install.sh \
    && mkdir /opt/cmake-3.24.1 \
    && /tmp/cmake-install.sh --skip-license --prefix=/opt/cmake-3.24.1 \
    && rm /tmp/cmake-install.sh \
    && ln -s /opt/cmake-3.24.1/bin/* /usr/local/bin

# Install Pangolin
RUN git clone https://github.com/stevenlovegrove/Pangolin && \
    cd Pangolin && git checkout v0.6 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++11 .. && \
    make -j$(nproc) && make install

# Install OpenCV 3.2
RUN apt-get update && apt-get install -y unzip
RUN echo "Cloning OpenCV and build ..."
RUN git clone https://github.com/opencv/opencv.git && cd opencv && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j"$(nproc)" && \
    make install && \
    rm -rf /opencv

# Install canberra-gtk-module
RUN apt-get update && \
    apt-get install -y libcanberra-gtk-module

# Change pytorch become an user accessible:
RUN chmod -R 777 /pytorch/torch/lib/

# Set environment variables
ENV GTK_MODULES=canberra-gtk-module
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH=/usr/local/lib/python3.6/site-packages:$PYTHONPATH

WORKDIR /root
