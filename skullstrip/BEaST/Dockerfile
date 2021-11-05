FROM pennsive/neurodocker:buster
# ref https://rpubs.com/conge/beast_intro
WORKDIR /root
RUN mkdir Atlas && cd Atlas && \
    wget http://www.bic.mni.mcgill.ca/~vfonov/icbm/2009/mni_icbm152_nlin_sym_09c_minc2.zip && \
    unzip mni_icbm152_nlin_sym_09c_minc2.zip