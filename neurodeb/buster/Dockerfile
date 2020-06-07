FROM neurodebian:buster-non-free
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
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