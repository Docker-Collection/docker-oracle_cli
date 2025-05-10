FROM python:3.13.3-alpine@sha256:452682e4648deafe431ad2f2391d726d7c52f0ff291be8bd4074b10379bb89ff as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.13.3-alpine@sha256:452682e4648deafe431ad2f2391d726d7c52f0ff291be8bd4074b10379bb89ff

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]