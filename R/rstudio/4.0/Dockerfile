FROM pennsive/neuror:4.0
RUN apt-get update && apt-get install -y gdebi-core systemd && \
    wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb && \
    gdebi --non-interactive rstudio-server-1.3.1093-amd64.deb && rm -rf rstudio-server-1.3.1093-amd64.deb
EXPOSE 8787
CMD rstudio-server start
