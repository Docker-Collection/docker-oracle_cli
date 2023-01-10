FROM python:3.11.1-alpine@sha256:2e23d6cd236ffccc88db47e7520f67cfb5cd9dd62b8d534d3249834930cc226e as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.1-alpine@sha256:2e23d6cd236ffccc88db47e7520f67cfb5cd9dd62b8d534d3249834930cc226e

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]