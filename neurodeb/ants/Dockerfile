FROM debian:buster

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    g++ \
    git \
    libgomp1 \
    libtool \
    make \
    pkg-config \
    rsync \
    tar \
    unzip \
    wget \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Download and extract CMake
RUN mkdir -p /opt/cmake && cd /opt/cmake \
    && wget -q https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1-linux-x86_64.tar.gz \
    && tar xzf cmake-3.25.1-linux-x86_64.tar.gz && rm cmake-3.25.1-linux-x86_64.tar.gz

# Add CMake to the path
ENV PATH="/opt/cmake/cmake-3.25.1-linux-x86_64/bin:${PATH}"

# Download and build ANTs
RUN mkdir -p /opt/ants && cd /opt/ants \
    && wget -q https://github.com/ANTsX/ANTs/archive/refs/tags/v2.4.2.tar.gz \
    && tar xzf v2.4.2.tar.gz && rm v2.4.2.tar.gz
#    && cd ANTs-2.4.2 && mkdir build && cd build \
#    && cmake .. \
#    && make

CMD ["/bin/bash"]
