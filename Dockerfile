FROM python:3.13.1-alpine@sha256:5dad625efcbc6fad19c10b7b2bfefa1c7a8129c8f8343106b639c27dd9e7db2c as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.13.1-alpine@sha256:5dad625efcbc6fad19c10b7b2bfefa1c7a8129c8f8343106b639c27dd9e7db2c

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]