FROM python:3.11.0-alpine@sha256:ec7ff85cfca09fc0d9b4bae53f0d0f2ee164c844ba509e641917432d82e9dae3 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.0-alpine@sha256:ec7ff85cfca09fc0d9b4bae53f0d0f2ee164c844ba509e641917432d82e9dae3

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]