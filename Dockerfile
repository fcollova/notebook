FROM ubuntu:14.04
MAINTAINER francesco.collova@gmail.com

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update --fix-missing && apt-get upgrade -y && apt-get autoremove -y

RUN apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN mkdir /workspace
WORKDIR /workspace

# Add Tini
ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Add Anaconda
ENV ANACONDA_VERSION "4.2.0"
ENV CONDA_PATH "/opt/conda"
ENV PATH "$CONDA_PATH/bin:$PATH"

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget bzip2

RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh -O anaconda.sh && \
    /bin/bash anaconda.sh -b -p $CONDA_PATH && \
    rm anaconda.sh

RUN conda update anaconda -y

RUN pip install tensorflow

RUN pip install keras

COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /

ENV TENSORFLOW_VERSION 0.12.1

# tensorboard
EXPOSE 6006

# jupyter
EXPOSE 8888
EXPOSE 8889

WORKDIR "/notebooks"

CMD ["/bin/bash"]