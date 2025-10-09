FROM python:3.14.0-alpine@sha256:829edcc737417f9084a154511bde03a50b7996f3746e4c8a6b30a99a9a10648c as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.14.0-alpine@sha256:829edcc737417f9084a154511bde03a50b7996f3746e4c8a6b30a99a9a10648c

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]