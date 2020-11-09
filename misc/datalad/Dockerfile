FROM neurodebian:buster-non-free
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git-annex-standalone datalad datalad-container
ENTRYPOINT [ "datalad" ]
