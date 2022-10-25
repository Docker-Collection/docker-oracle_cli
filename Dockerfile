FROM python:3.11.0-alpine@sha256:2a068b9442f61f4480306d44e3b166bfe3343761e9bd57c38f66302ebf28fd9e as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.0-alpine@sha256:2a068b9442f61f4480306d44e3b166bfe3343761e9bd57c38f66302ebf28fd9e

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]