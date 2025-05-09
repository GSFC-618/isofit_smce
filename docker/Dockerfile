FROM mambaorg/micromamba
#FROM --platform=linux/amd64 mambaorg/micromamba
#FROM --platform=$BUILDPLATFORM mambaorg/micromamba

USER root
RUN apt-get update &&\
    apt-get install --no-install-recommends -y \
      gfortran \
      make \
      unzip \
      nano \
      vim \
      wget \
      curl \
      git

RUN mkdir -p /isofit_data
RUN chown mambauser:mambauser /isofit_data
USER mambauser
#RUN mkdir -p /home/mambauser/.isofit
WORKDIR /home/mambauser

# Copy and install the ISOFIT environment
# note: we are now explicitly copying the isofit git repo into the image as ISOFIT
COPY --chown=mambauser:mambauser isofit/ ISOFIT/
RUN micromamba config prepend channels conda-forge &&\
    micromamba update  --all --yes &&\
    micromamba install --name base jupyterlab &&\
    micromamba create  --name isofit python=3.10 &&\
    micromamba install --name isofit --file ISOFIT/recipe/isofit.yml \
                                     --file ISOFIT/recipe/docker.yml &&\
    echo "micromamba activate isofit" >> ~/.bashrc

ENV PATH=/opt/conda/envs/isofit/bin:$PATH

# Install ISOFIT and extra files
# Should probably change this to explicitly using the git releases instead of via pip?
RUN python -m ipykernel install --user --name isofit &&\
    pip install -e ISOFIT
# note: here we are now skipping embedding the ISOFIT data into the image

# Create a symlink from the host isofit_data location to /home/mambauser
RUN cd /home/mambauser &&\
    ln -s /isofit_data/ .
    
# Jupyter needs this to access the terminal
ENV SHELL="/bin/bash"

# Ray Dashboard port
EXPOSE 8265

# Start the Jupyterlab server
EXPOSE 8888

# note: here we are now making sure to map to the new /isofit_data folder in the image root
#CMD ["jupyter-lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "--ServerApp.token=''", "--ServerApp.password=''", "/isofit_data/examples/isotuts/NEON/neon.ipynb"]

# NOTE: Updating the CMD arguments to start the user in /home/mambauser to allow for expanded access to the file system inside the container
CMD ["jupyter-lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "--ServerApp.token=''", "--ServerApp.password=''", "/home/mambauser"]

### EOF