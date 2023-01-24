FROM python:3.11.1-alpine@sha256:ca1298a74c3495b6bc539044352301fa371f6e10b0e085f93d2a4ef3e4c3fa6c as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.1-alpine@sha256:ca1298a74c3495b6bc539044352301fa371f6e10b0e085f93d2a4ef3e4c3fa6c

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]