FROM python:3.9-slim-buster

LABEL maintainer="pavel.saman@inveo.cz"
LABEL description="Docker pytest API tests"
LABEL version="1.1"

# install necessary packages
RUN apt-get update \
    && apt-get -y install

WORKDIR /tests

# install requirements for the tests
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# create a folder for test results, copy tests
RUN mkdir Results
COPY . .

# create a non-privileged user
RUN groupadd -r pytest \
    && useradd --no-log-init -r -g pytest pytest \
    && chown -R pytest:pytest /tests
USER pytest:pytest

# run tests with pytest
CMD ["pytest"]
