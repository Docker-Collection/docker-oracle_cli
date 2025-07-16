FROM python:3.13.5-alpine@sha256:e08874637f2704667426cb3b8d14581b9cb12dd2c237c8419f65446669443921 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.13.5-alpine@sha256:e08874637f2704667426cb3b8d14581b9cb12dd2c237c8419f65446669443921

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]