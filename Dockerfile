FROM python:3.11.1-alpine@sha256:625383c19a9a14824e6b89b5bbadc5138d5c2ad5adcc67d8ee4e3527cf35ffe0 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.1-alpine@sha256:625383c19a9a14824e6b89b5bbadc5138d5c2ad5adcc67d8ee4e3527cf35ffe0

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]