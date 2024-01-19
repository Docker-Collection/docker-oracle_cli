FROM python:3.12.1-alpine@sha256:1d1a3d9593c14e3b43a51c53213e23bfcd51f43b12595ffa0872cc64bd6626fd as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.12.1-alpine@sha256:1d1a3d9593c14e3b43a51c53213e23bfcd51f43b12595ffa0872cc64bd6626fd

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]