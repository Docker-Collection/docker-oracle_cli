FROM python:3.10-slim-buster@sha256:9727fe7eede2069dc15287e17eadd709a43094a4062a8cbd74d4504a8270d1f8 as Builder

COPY requirements.txt .

# RUN apk add --no-cache cmake

# RUN echo PATH=/usr/local/bin/cmake:$(which cmake) >> ~/.bashrc && \
#     echo PATH=/usr/include/boost:$(whereis boost) >> ~/.bashrc

RUN pip install --no-cache-dir --user -r requirements.txt

FROM python:3.10-slim-buster@sha256:9727fe7eede2069dc15287e17eadd709a43094a4062a8cbd74d4504a8270d1f8

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]