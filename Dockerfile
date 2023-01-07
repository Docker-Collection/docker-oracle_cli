FROM python:3.11.1-alpine@sha256:6e40024db07347315abef316b3d0e28161bdff6ae5ccdc9680c56914ba544f1a as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.1-alpine@sha256:6e40024db07347315abef316b3d0e28161bdff6ae5ccdc9680c56914ba544f1a

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]