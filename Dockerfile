FROM python:3.11.1-alpine@sha256:af8fef83397b3886ed93d2c81bf3b4e70d39c0789c1c6feb1ecb86ca9bc42a0a as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.1-alpine@sha256:af8fef83397b3886ed93d2c81bf3b4e70d39c0789c1c6feb1ecb86ca9bc42a0a

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]