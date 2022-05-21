# syntax=docker/dockerfile:1.3
FROM osgeo/gdal:ubuntu-small-3.3.2

RUN apt-get update --fix-missing && apt install -y \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Supresses warnings about our self signed PyPi server certificate
ENV PYTHONWARNINGS="ignore:Unverified HTTPS request"

# set work directory early so remaining paths can be relative
WORKDIR /src

# Adding requirements file to current directory
# just this file first to cache the pip install step when code changes
COPY requirements.txt .
COPY requirements-test.txt .

# install dependencies
RUN pip3 install \
    -r requirements.txt \
    --trusted-host infra-pypicloud.prod.pachama.com \
    --index-url https://infra-pypicloud.prod.pachama.com/simple/
RUN pip3 install \
    -r requirements-test.txt \
    --trusted-host infra-pypicloud.prod.pachama.com \
    --index-url https://infra-pypicloud.prod.pachama.com/simple/

# copy code itself from context to image
COPY . .

ENTRYPOINT [ "docker/devbox.entrypoint.sh" ]

# Create dev user to use instead of root user
ARG USERNAME=pachama
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
