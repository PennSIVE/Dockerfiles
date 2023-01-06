FROM debian:buster

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  python \
  && rm -rf /var/lib/apt/lists/*

# Download and run the FSL installer script
RUN curl -L https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py -o fslinstaller.py \
  && echo '/usr/local/fsl' | python fslinstaller.py

# Set up environment variables
ENV FSLDIR=/usr/local/fsl
ENV PATH=$FSLDIR/bin:$PATH
ENV FSLOUTPUTTYPE=NIFTI_GZ

# Set the default command to run when starting the container
CMD ["bash"]

