FROM neurodebian:trusty-non-free
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ants \
    fsl-complete \
    curl \
    git \
    zlib1g-dev \
    libxml2 \
    libxml2-dev \
    libssl-dev \
    libcurl4-gnutls-dev \
    libssh2-1-dev \
    libgit2-dev \
    libv8-dev \
    dirmngr
ENV PATH=$PATH:/usr/lib/fsl/5.0 FSLDIR=/usr/share/fsl/5.0 