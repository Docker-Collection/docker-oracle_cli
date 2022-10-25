FROM python:3.10.8-alpine@sha256:85a0c5586db9c0b4777f202dbecba059ff82f129ba09c7b27df1d88797b7ad93 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.10.8-alpine@sha256:85a0c5586db9c0b4777f202dbecba059ff82f129ba09c7b27df1d88797b7ad93

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]