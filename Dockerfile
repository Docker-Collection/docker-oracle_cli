FROM python:3.11.3-alpine@sha256:2f2dadb583247fa176faf0a22800ce7a8b7a83cfee734c00315c4d68a55f4b68 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.3-alpine@sha256:2f2dadb583247fa176faf0a22800ce7a8b7a83cfee734c00315c4d68a55f4b68

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]