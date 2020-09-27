FROM mass_base
ENV PATH=/dramms-1.5.1-source/build/bundle/bin:/opt/mass-1.1.1/bin:${PATH}
RUN apt-get update && apt-get install -y cmake-curses-gui build-essential zlib1g-dev && \
    curl -LO https://github.com/ouyangming/DRAMMS/raw/master/dramms-1.5.1-source.tar.gz && \
    tar -xzf dramms-1.5.1-source.tar.gz && rm -rf dramms-1.5.1-source.tar.gz && \
    cd dramms-1.5.1-source/build && cmake -D CMAKE_INSTALL_PREFIX:STRING=/opt/dramms-1.5.1 . && make && \
    curl -LO https://github.com/CBICA/MASS/archive/1.1.1.tar.gz && \
    tar -xzf 1.1.1.tar.gz && rm -rf 1.1.1.tar.gz && \
    cd MASS-1.1.1 && mkdir mass-1.1.1-build && cd mass-1.1.1-build && \
    cmake -D CMAKE_INSTALL_PREFIX:STRING=/opt/mass-1.1.1 -D SCHEDULER:STRING=NONE .. && \
    make && make install
ENTRYPOINT [ "mass" ]
