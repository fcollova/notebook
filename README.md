
# Tensorflow notebook

This repository is a Docker generetion of a Jupyter notebook environment containing:
Tensorflow, Keras and Pytorch



<a name="installation-preliminaries"></a>
# Installation Preliminaries

<!-- MarkdownTOC autolink=true autoanchor=true bracket=round -->

- [Quickstart Guide](#quickstart-guide)
    - [pip Install](#pip-install)
    - [Docker Installation](#docker-installation)
- [What is Notebook?](#what-is-notebook)
- [Docker Toolbox](#docker-toolbox)
- [Jupyter Notebook](#jupyter-notebook)
    - [OSX/Linux](#osxlinux)
    - [Windows/Docker Containers](#windowsdocker-containers)
- [Navigating to Notebook](#navigating-to-notebook)


<!-- /MarkdownTOC -->

We will be using Jupyter Notebook.  This will be necessary for submitting the homeworks and interacting with the guided session notebooks I will provide for each assignment.  Follow along this guide and we'll see how to obtain all of the necessary libraries that we'll be using.  By the end of this, you'll have installed Jupyter Notebook, NumPy, SciPy, and Matplotlib.  While many of these libraries aren't necessary for performing the Deep Learning which we'll get to in later lectures, they are incredibly useful for manipulating data on your computer, preparing data for learning, and exploring results.

<a name="quickstart-guide"></a>
## Quickstart Guide

Important! Please skip this section and read the rest of this readme if you are unfamiliar w/ Jupyter Notebook or installing Python libraries.  This section is only for advanced users who want to get started quickly.

There are two ways to get started.  You can use a native pip installation or use Docker.  There is a quickstart guide for both methods below.  If you have trouble with these, then please skip to the more in depth guides below these sections.

<a name="pip-install"></a>
### pip Install

For those of you that are proficient w/ Python programming, you'll need Python 3.4+ and the latest TensorFlow which you can install via pip, e.g.:

```bash
$ pip install tensorflow
```

or w/ CUDA as:

```bash
$ pip install tensorflow-gpu
```

<a name="docker-installation"></a>
### Docker Installation

If you want a controlled environment w/ all dependencies installed for you, and are proficient w/ Docker and Jupyter, you can get started w/ this repo like so:

```bash
$ cd
$ git clone https://github.com/fcollova/notebook.git
$ cd notebook
$ docker build -t notebook .
$ docker run -it -p 8888:8888 -p 6006:6006 -v /$(pwd)/notebooks:/notebooks --name tf notebook /bin/bash
```
<a name="docker-installation-GPU"></a>
### Docker installation with a GPU

Ceck Nvidia driver are correctly installed and install nvidia-modprobe

```bash
$ sudo apt install nvidia-modprobe
```
If you want the **GPU** version use the Dockerfile **Dockerfile_GPU**

Remember to run the container you need nvidia-docker you can install from https://github.com/NVIDIA/nvidia-docker

```bash
$ cd
$ git clone https://github.com/fcollova/notebook.git
$ cd notebook
$ docker build -t notebook-gpu .
$ nvidia-docker run -it -p 8888:8888 -p 6006:6006 -v /$(pwd)/notebooks:/notebooks --name tf-gpu notebook-gpu /bin/bash
```




Note that you can skip the build step and download from docker hub instead like so:

```bash
$ docker run -it -p 8888:8888 -p 6006:6006 -v /$(pwd)/notebooks:/notebooks --name tf fcollova/notebook /bin/bash
```

```bash
root@39c4441bcde8:/notebooks# ls

```

Which you can use to launch jupyter like so:

```bash
root@39c4441bcde8:/notebooks# jupyter notebook
[I 01:45:27.712 NotebookApp] [nb_conda_kernels] enabled, 2 kernels found
[I 01:45:27.715 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret
[W 01:45:27.729 NotebookApp] WARNING: The notebook server is listening on all IP addresses and not using encryption. This is not recommended.
[I 01:45:27.799 NotebookApp] [nb_anacondacloud] enabled
[I 01:45:27.802 NotebookApp] [nb_conda] enabled
[I 01:45:27.856 NotebookApp] ✓ nbpresent HTML export ENABLED
[W 01:45:27.856 NotebookApp] ✗ nbpresent PDF export DISABLED: No module named 'nbbrowserpdf'
[I 01:45:27.858 NotebookApp] Serving notebooks from local directory: /notebooks
[I 01:45:27.858 NotebookApp] 0 active kernels
[I 01:45:27.858 NotebookApp] The Jupyter Notebook is running at: http://[all ip addresses on your system]:8888/?token=dd68eeffd8f227dd789327c981d16b24631866e909bd6469
[I 01:45:27.858 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
```

Jupyter should then be running if you navigate Google Chrome (suggested!) to "http://localhost:8888".  If you navigate to the session-1.ipynb file, you will see the homework, or to "lecture-1.ipynb", to find the lecture transcripts.  The same goes for every other session.

If you need to relaunch the docker image again, you can write:

```bash
$ cd
$ cd notebooks
$ docker start -i tf
```

If you had any trouble w/ this setup then please go through the rest of this document which provides much more in depth details.


<a name="what-is-notebook"></a>
## What is Notebook?

Jupyter Notebook, previously called "iPython Notebook" prior to version 4.0, is a way of interacting with Python code using a web browser.  It is a very useful instructional tool that we will be using for all of our homework assignments.  Notebooks have the file extensions "ipynb" which are abbreviations of "iPython Notebook".  Some websites such as [nbviewer.ipython.org](http://nbviewer.ipython.org) or [www.github.com](http://www.github.com) can view `.ipynb` files directly as rendered HTML.  However, these are not *interactive* versions of the notebook, meaning, they are not running the python kernel which evaluates/interacts with the code.  So the notebook is just a static version of the code contained inside of it.

In order to interact with notebook and start coding, you will need to launch Terminal (for Mac and Linux users).  For Windows users, or for anyone having any problems with the Linux/Mac instructions, please follow the next section on [Docker Toolbox](#docker-toolbox) very closely!  If you are not a Windows user, please first try skipping over the next section and use the installation instructions in [Jupyter Notebook](#jupyter-notebook) before trying Docker as this solution will be much faster than running Docker.


<a name="jupyter-notebook"></a>
## Jupyter Notebook

<a name="osxlinux"></a>
### OSX/Linux

Note: Windows/Docker users should scroll past this section to ["Windows/Docker"](#windows-docker-containers).  For OSX/Linux users, the easiest way to ensure you have Python 3.4 or higher and Jupter Notebook is to install Anaconda for Python 3.5 located here:

[OSX](https://docs.continuum.io/anaconda/install#anaconda-for-os-x-command-line-install) or [Linux](https://docs.continuum.io/anaconda/install#linux-install)

Make sure you restart your Terminal after you install Anaconda as there are some PATH variables that have to be set.

Then run the following:

```shell
$ curl https://bootstrap.pypa.io/ez_setup.py -o - | python
```

If you already have conda, but only have Python 2, you can very easily [add a new environment w/ Python 3](http://conda.pydata.org/docs/py2or3.html#create-a-python-3-5-environment) and switch back and forth as needed.  Or if you do not have Anaconda, but have a system based install, I'd really recommend either using Anaconda or [pyenv](https://github.com/yyuu/pyenv) to help you manage both python installations.

With Anaconda installed, you will have python and the package "ipython[notebook]", along with a ton of other very useful packages such as numpy, matplotlib, scikit-learn, scikit-image, and many others.

With everything installed, restart your Terminal application (on OSX, you can use Spotlight to find the Terminal application), and then navigate to the directory containing the "ipynb", or "iPython Notebook" file, by "cd'ing" (pronounced, see-dee-ing), into that directory.  This involves typing the command: "cd some_directory".  Once inside the directory of the notebook file, you will then type: "jupyter notebook".  If this command does not work, it means you do not have notebook installed!  Try installed anaconda as above, restart your Terminal application, or manually install notebook like so (ignore the "$" signs which just denote that this is a Terminal command that you should type out exactly and then hit ENTER!):

```shell
$ pip3 install ipython[notebook]
$ jupyter notebook
```

If you run into issues that say something such as:

```
[W 20:37:40.543 NotebookApp] Kernel not found: None
```

Then please try first running:

```shell
$ ipython3 kernel install
```

