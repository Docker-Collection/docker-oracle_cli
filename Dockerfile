FROM python:3.10.8-alpine@sha256:03504748146cea12539306ef7eea0983e282a335bdf565e6becc1bec8535b00f as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.10.8-alpine@sha256:03504748146cea12539306ef7eea0983e282a335bdf565e6becc1bec8535b00f

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]