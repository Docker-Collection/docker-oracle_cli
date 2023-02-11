FROM python:3.11.2-alpine@sha256:dbc4bbe3e3c6c1e29e0241f06e068b83d93cb524e93e9ce368a129566483e043 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.2-alpine@sha256:dbc4bbe3e3c6c1e29e0241f06e068b83d93cb524e93e9ce368a129566483e043

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]