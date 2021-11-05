FROM python:3.6
RUN git clone https://github.com/MIC-DKFZ/HD-BET && cd HD-BET && pip install -e . && cd HD_BET && python -c "import utils; utils.maybe_download_parameters()"
ENTRYPOINT [ "hd-bet" ]
