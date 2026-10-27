FROM python:3.15.2-alpine@sha256:1656b7eaf309cadf99069ea9de335c7f67a8355789cfc6f1835a05818996f081 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.15.2-alpine@sha256:1656b7eaf309cadf99069ea9de335c7f67a8355789cfc6f1835a05818996f081

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]