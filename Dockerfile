FROM python:3.14.4-alpine@sha256:ccea73754fbcefbef8c2a2a64d902b95ffdde498b3ff8a644fe905a6efecfd41 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.14.4-alpine@sha256:ccea73754fbcefbef8c2a2a64d902b95ffdde498b3ff8a644fe905a6efecfd41

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]