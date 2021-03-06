# neuroR plus rstudio installation based on https://hub.docker.com/r/rocker/rstudio/dockerfile
FROM pennsive/neuror:3.6

ARG RSTUDIO_VERSION
ARG S6_VERSION
ARG PANDOC_TEMPLATES_VERSION
ENV S6_VERSION=${S6_VERSION:-v1.21.7.0}
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
ENV PANDOC_TEMPLATES_VERSION=${PANDOC_TEMPLATES_VERSION:-2.9}

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    file \
    git \
    libapparmor1 \
    libclang-dev \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    multiarch-support \
    psmisc \
    procps \
    python-setuptools \
    sudo \
    wget \
  && if [ -z "$RSTUDIO_VERSION" ]; \
    then RSTUDIO_URL="https://www.rstudio.org/download/latest/stable/server/bionic/rstudio-server-latest-amd64.deb"; \
    else RSTUDIO_URL="http://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb"; fi \
  && wget -q $RSTUDIO_URL \
  && dpkg -i rstudio-server-*-amd64.deb \
  && rm rstudio-server-*-amd64.deb \
  ## Symlink pandoc & standard pandoc templates for use system-wide
  && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin \
  && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin \
  && git clone --recursive --branch ${PANDOC_TEMPLATES_VERSION} https://github.com/jgm/pandoc-templates \
  && mkdir -p /opt/pandoc/templates \
  && cp -r pandoc-templates*/* /opt/pandoc/templates && rm -rf pandoc-templates* \
  && mkdir /root/.pandoc && ln -s /opt/pandoc/templates /root/.pandoc/templates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  ## RStudio wants an /etc/R, will populate from $R_HOME/etc
  && mkdir -p /etc/R \
  && mkdir -p /usr/local/lib/R/etc/ \
  ## Write config files in $R_HOME/etc
  && echo '\n\
    \n# Configure httr to perform out-of-band authentication if HTTR_LOCALHOST \
    \n# is not set since a redirect to localhost may not work depending upon \
    \n# where this Docker container is running. \
    \nif(is.na(Sys.getenv("HTTR_LOCALHOST", unset=NA))) { \
    \n  options(httr_oob_default = TRUE) \
    \n}' >> /usr/local/lib/R/etc/Rprofile.site \
  && echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron \
  ## Need to configure non-root user for RStudio
  && useradd rstudio \
  && echo "rstudio:rstudio" | chpasswd \
	&& mkdir /home/rstudio \
	&& chown rstudio:rstudio /home/rstudio \
	&& addgroup rstudio staff \
  ## Prevent rstudio from deciding to use /usr/bin/R if a user apt-get installs a package
  &&  echo 'rsession-which-r=/usr/local/bin/R' >> /etc/rstudio/rserver.conf \
  ## use more robust file locking to avoid errors when using shared volumes:
  && echo 'lock-type=advisory' >> /etc/rstudio/file-locks \
  ## configure git not to request password each time
  && git config --system credential.helper 'cache --timeout=3600' \
  && git config --system push.default simple \
  ## Set up S6 init system
  && wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz \
  && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
  && mkdir -p /etc/services.d/rstudio \
  && echo '#!/usr/bin/with-contenv bash \
          \n## load /etc/environment vars first: \
  		  \n for line in $( cat /etc/environment ) ; do export $line ; done \
          \n exec /usr/lib/rstudio-server/bin/rserver --server-daemonize 0' \
          > /etc/services.d/rstudio/run \
  && echo '#!/bin/bash \
          \n rstudio-server stop' \
          > /etc/services.d/rstudio/finish \
  && mkdir -p /home/rstudio/.rstudio/monitored/user-settings \
  && echo 'alwaysSaveHistory="0" \
          \nloadRData="0" \
          \nsaveAction="0"' \
          > /home/rstudio/.rstudio/monitored/user-settings/user-settings && \
  mkdir -p /home/rstudio/mydata && \
  echo "ANTsR" > /home/rstudio/.Rpackagedisplay && \
  echo "ANTsRCore" >> /home/rstudio/.Rpackagedisplay && \
  echo "ITKR" >> /home/rstudio/.Rpackagedisplay && \
  echo "setwd('/home/rstudio/mydata')" > /home/rstudio/.Rprofile && \
  echo "Sys.setenv(ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS = system('nproc', intern=TRUE) )" >> /home/rstudio/.Rprofile && \
  echo "message(paste('CPU cores/threads available:', system('nproc', intern=TRUE), '\\\n'))" >> /home/rstudio/.Rprofile && \
  echo "tmp = utils::capture.output( sessioninfo::package_info( utils::read.table('/home/rstudio/.Rpackagedisplay', as.is=TRUE)\$V1, dependencies = FALSE) )" >> /home/rstudio/.Rprofile && \
  echo "for (line in tmp) message(line)" >> /home/rstudio/.Rprofile && \
  echo "rm(list=c('line','tmp'))" >> /home/rstudio/.Rprofile && \
  echo "suppressPackageStartupMessages(library(ANTsR))" >> /home/rstudio/.Rprofile && \
  chown -R rstudio:rstudio /home/rstudio/ && \
  ln -snf /usr/bin/R /usr/local/bin/R

COPY ./rocker-scripts/userconf.sh /etc/cont-init.d/userconf

## running with "-e ADD=shiny" adds shiny server
COPY ./rocker-scripts/add_shiny.sh /etc/cont-init.d/add
COPY ./rocker-scripts/disable_auth_rserver.conf /etc/rstudio/disable_auth_rserver.conf
COPY ./rocker-scripts/pam-helper.sh /usr/lib/rstudio-server/bin/pam-helper

EXPOSE 8787

CMD /init
