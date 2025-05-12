# FROM --platform=$BUILDPLATFORM mambaorg/mamba

# USER root

FROM quay.io/jupyter/minimal-notebook:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive
USER root

RUN apt-get update &&\
    apt-get install --no-install-recommends -y \
      gfortran \
      make \
      nano \
      vim 

RUN mkdir -p /isofit_data
# RUN chown mambauser:mambauser /isofit_data
# USER mambauser
# WORKDIR /home/mambauser
WORKDIR /opt

# Copy and install the ISOFIT environment
# note: we are now explicitly copying the isofit git repo into the image as ISOFIT
# COPY --chown=mambauser:mambauser isofit/ ISOFIT/

COPY isofit/ ISOFIT/

# RUN mamba config prepend channels conda-forge
RUN mamba update --all --yes
# RUN mamba install --name base jupyterlab
RUN mamba create --name isofit python=3.10
RUN mamba install --name isofit --file ISOFIT/recipe/isofit.yml
RUN mamba install --name isofit --file ISOFIT/recipe/docker.yml
# RUN echo "mamba activate isofit" >> ~/.bashrc


# ENV PATH=/opt/conda/envs/isofit/bin:$PATH

# Install ISOFIT and extra files
# RUN python -m ipykernel install --user --name isofit &&\
#     pip install -e ISOFIT

RUN python -m ipykernel install --name isofit --sys-prefix &&\
    pip install -e ISOFIT

# note: here we are now skipping embedding the ISOFIT data into the image

# Jupyter needs this to access the terminal
# ENV SHELL="/bin/bash"

# Ray Dashboard port
EXPOSE 8265

RUN apt-get update &&\
    apt-get install --no-install-recommends -y \
      libnss-wrapper

RUN groupadd -g 500 admins

WORKDIR "/home/${NB_USER}"

#======================== Fix permissions for home/jovyan ============
RUN fix-permissions "/home/${NB_USER}"

# == Add custom entrypoint script for setting up individual uids======
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["jupyterhub-singleuser"]


# Start the Jupyterlab server
# EXPOSE 8888

# note: here we are now making sure to map to the new /isofit_data folder in the image root
# CMD ["jupyter-lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "--ServerApp.token=''", "--ServerApp.password=''", "/isofit_data/examples/isotuts/NEON/neon.ipynb"]

### EOF