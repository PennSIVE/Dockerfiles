FROM pennsive/neuror:4.0
RUN apt-get update && apt-get install -y gdebi-core systemd && \
    wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb && \
    gdebi --non-interactive rstudio-server-1.3.1093-amd64.deb && rm -rf rstudio-server-1.3.1093-amd64.deb && \
    chmod -R 777 /var/lib/rstudio-server/secure-cookie-key && \
    env >> /usr/local/lib/R/etc/Renviron 
ENV PORT=8787
CMD /usr/lib/rstudio-server/bin/rserver --server-daemonize 0 --auth-none 1 --auth-minimum-user-id 0 --secure-cookie-key-file /var/lib/rstudio-server/secure-cookie-key --www-port ${PORT}
