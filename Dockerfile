FROM python:3.11.0-alpine@sha256:08b03b140633664ed4a55630de38f847d19059318c2473a5bff592d8a0b051d5 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.0-alpine@sha256:08b03b140633664ed4a55630de38f847d19059318c2473a5bff592d8a0b051d5

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]