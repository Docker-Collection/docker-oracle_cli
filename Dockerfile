FROM python:3.11.4-alpine@sha256:bd16cc548687f25bf7cbc29c3d284c290cf63899b281f0f3a52fc697b48884c7 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.4-alpine@sha256:bd16cc548687f25bf7cbc29c3d284c290cf63899b281f0f3a52fc697b48884c7

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]