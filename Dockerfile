FROM python:3.11.2-alpine@sha256:1a5c14626ca7911ae16465aa338ed3f5c1bc0212a3eb16263d0d476bf3d0132d as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.2-alpine@sha256:1a5c14626ca7911ae16465aa338ed3f5c1bc0212a3eb16263d0d476bf3d0132d

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]