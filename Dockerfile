FROM python:3.15.1-alpine@sha256:e85751f6fe48ddb0619557d606ad93685134347a821b85fd9cd9dfa61addb970 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.15.1-alpine@sha256:e85751f6fe48ddb0619557d606ad93685134347a821b85fd9cd9dfa61addb970

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]