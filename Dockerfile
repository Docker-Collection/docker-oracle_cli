FROM python:3.10.8-alpine@sha256:3bfac1caa31cc6c0e796b65ba936f320d1e549d80f5ac02c2e4f83a0f04af3aa as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.10.8-alpine@sha256:3bfac1caa31cc6c0e796b65ba936f320d1e549d80f5ac02c2e4f83a0f04af3aa

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]