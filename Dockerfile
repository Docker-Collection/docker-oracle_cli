FROM python:3.11.0-alpine@sha256:8badad0cd582053ff139be25a021b63af112229a6c38770239c555da57f0c924 as Builder

COPY requirements.txt .

RUN apk add --update alpine-sdk build-base gcc musl-dev libffi-dev openssl-dev cargo && \
    pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11.0-alpine@sha256:8badad0cd582053ff139be25a021b63af112229a6c38770239c555da57f0c924

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]