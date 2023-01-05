FROM debian:buster

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  wget \
  unzip \
  tcsh \
  libjpeg-dev \
  libglu1-mesa-dev \
  libgsm1-dev \
  libxmu-dev \
  libxt-dev \
  libxaw7-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libglw1-mesa \
  libglu1-mesa \
  libxmu6 \
  libxmu-headers \
  libxmuu1 \
  mesa-utils \
  mesa-common-dev \
  freeglut3-dev \
  libgl1-mesa-glx \
  libgl1-mesa-dev \
  libglapi-mesa \
  libosmesa6-dev \
  libglew-dev \
  libpng-dev \
  libfreetype6-dev \
  python \
  python-numpy \
  python-setuptools \
  python-matplotlib \
  python-pip \
  && rm -rf /var/lib/apt/lists/*

# Download and extract FreeSurfer
RUN wget -q https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.3.2/freesurfer-linux-centos7_x86_64-7.3.2.tar.gz \
  && tar xvzf freesurfer-linux-centos7_x86_64-7.3.2.tar.gz -C /opt \
  && rm freesurfer-linux-centos7_x86_64-7.3.2.tar.gz

# Set up environment variables
ENV FS_LICENSE=/opt/freesurfer/license.txt
ENV FREESURFER_HOME=/opt/freesurfer
ENV SUBJECTS_DIR=$FREESURFER_HOME/subjects
ENV PATH=$FREESURFER_HOME/bin:$PATH

# Run FreeSurfer setup script
#RUN $FREESURFER_HOME/setup.sh

# Set the default command to run when starting the container
CMD ["bash"]

