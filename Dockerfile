FROM python:3.11.1-alpine@sha256:d8b0703ce84fe5a52d485f212e9d852bcdb8606798064f5f21af57325a7cf73f as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.1-alpine@sha256:d8b0703ce84fe5a52d485f212e9d852bcdb8606798064f5f21af57325a7cf73f

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]