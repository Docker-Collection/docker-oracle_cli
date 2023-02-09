FROM python:3.11.2-alpine@sha256:deb0f6327a7c0314470c76b3f92dca287b7aa138baabbd0259e2b6690e6b2dd6 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.2-alpine@sha256:deb0f6327a7c0314470c76b3f92dca287b7aa138baabbd0259e2b6690e6b2dd6

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]