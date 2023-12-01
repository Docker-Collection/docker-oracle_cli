FROM python:3.12.0-alpine@sha256:85eaef27f58a5fd6074f5353449156bc5651131d17018864c275d5c7b960ca9a as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.12.0-alpine@sha256:85eaef27f58a5fd6074f5353449156bc5651131d17018864c275d5c7b960ca9a

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]