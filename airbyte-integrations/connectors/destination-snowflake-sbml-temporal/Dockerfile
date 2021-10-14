ARG REGION=eu-west-1
ARG ENVIRONMENT=dev
ARG ACCOUNT_ID=129462528407
ARG IMAGE_TAG=latest

FROM ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/sb-ruby-centos-24x-master-0605542-0-${ENVIRONMENT}-base-${REGION}:latest as base_python_38
# Install Python dependencies
RUN yum -y update && \
    yum -y install \
        bzip2-devel \
        epel-release \
        ffmpeg \
        ffmpeg-devel \
        gcc \
        libffi-devel \
        libsndfile \
        openssl-devel \
        sqlite-devel \
        tar \
        wget \
        xz \
        xz-devel \
        zlib-devel && \
    yum clean all

ARG PYTHON_VERSION="3.8.11"
ENV PYTHONUNBUFFERED=1
WORKDIR /airbyte/integration_code

# Install Python
RUN cd /opt && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar xzf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && ./configure --enable-optimizations && make altinstall && \
    rm -rf /opt/Python-${PYTHON_VERSION}

# Make Python 3.X the default
RUN ln -fs /usr/local/bin/python3.8 /usr/bin/python3 && \
    ln -fs /usr/local/bin/pip3.8 /usr/bin/pip3

# Install Poetry
RUN pip3 install poetry && \
    poetry config virtualenvs.in-project true

## App Docker
FROM base_python_38 as base

# build and load all requirements
FROM base as builder
WORKDIR /airbyte/integration_code


COPY setup.py ./

# install necessary packages to a temporary folder
RUN pip3 install -vvv --prefix=/install .

# build a clean environment
FROM base


# copy all loaded and built libraries to a pure basic image
COPY --from=builder /install /usr/local
# add default timezone settings
COPY --from=builder /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN echo "Etc/UTC" > /etc/timezone

# copy payload code only
COPY main.py ./
COPY config.json ./
COPY catalog.json ./
COPY .secrets.json ./
COPY messagesX.jsonl ./

COPY destination_snowflake_sbml_temporal ./destination_snowflake_sbml_temporal

ENV AIRBYTE_ENTRYPOINT "/usr/local/bin/python3.8 /airbyte/integration_code/main.py"
ENV CREDENTIALS_FILE "/airbyte/integration_code/.secrets.json"
ENTRYPOINT ["/usr/local/bin/python3.8", "/airbyte/integration_code/main.py"]

LABEL io.airbyte.version=0.1.0
LABEL io.airbyte.name=airbyte/destination-snowflake-sbml-temporal
