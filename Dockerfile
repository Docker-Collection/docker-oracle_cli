FROM python:3.12.4-alpine@sha256:ab8bec34de4202398fc8c28229ae6510cee874ae35c579090f1f8a9197deec29 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.12.4-alpine@sha256:ab8bec34de4202398fc8c28229ae6510cee874ae35c579090f1f8a9197deec29

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]