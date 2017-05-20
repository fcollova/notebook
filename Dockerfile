#Dockerfile CPU Python 2.7
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


# Add Anaconda Python 2.7
ENV ANACONDA_VERSION "4.3.1"
ENV CONDA_PATH "/opt/conda"
ENV PATH "$CONDA_PATH/bin:$PATH"

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget bzip2

RUN wget --quiet https://repo.continuum.io/archive/Anaconda2-$ANACONDA_VERSION-Linux-x86_64.sh -O anaconda.sh && \
    /bin/bash anaconda.sh -b -p $CONDA_PATH && \
    rm anaconda.sh

RUN conda update anaconda -y

# F.C. to be proved ENV TENSORFLOW_VERSION 1.0.0
# F.C. RUN pip install tensorflow==$TENSORFLOW_VERSION 
RUN pip install tensorflow

RUN pip install keras

RUN conda install pytorch torchvision -c soumith -y

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
