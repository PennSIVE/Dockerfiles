FROM rabits/qt:5.4-desktop
USER root
WORKDIR /opt
RUN curl -LO https://sourceforge.net/projects/itk-snap/files/itk-snap/3.8.0/itksnap-3.8.0-20190612-Linux-x86_64.tar.gz && \
    tar -xvzf itksnap-3.8.0-20190612-Linux-x86_64.tar.gz && \
    rm -rf itksnap-3.8.0-20190612-Linux-x86_64.tar.gz
RUN apt-get update && apt-get install -y xorg libx11-dev libglu1-mesa-dev libfreetype6-dev
USER user
WORKDIR $HOME
ENV PATH=$PATH:/opt/itksnap-3.8.0-20190612-Linux-gcc64/bin
CMD itksnap