FROM python:3.11.0-alpine@sha256:ef8ab2f0859e5c68ae08df5ce9748c030b1c5989d728e34a0ef36a5a746a676c as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.0-alpine@sha256:ef8ab2f0859e5c68ae08df5ce9748c030b1c5989d728e34a0ef36a5a746a676c

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]