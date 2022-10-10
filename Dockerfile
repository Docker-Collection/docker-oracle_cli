FROM python:3.10-slim-buster@sha256:06d5be98525006c16db0dfdcc7f8d4925107ddad582d634a8a86cc667def06f8 as Builder

COPY requirements.txt .

# RUN apk add --no-cache cmake

# RUN echo PATH=/usr/local/bin/cmake:$(which cmake) >> ~/.bashrc && \
#     echo PATH=/usr/include/boost:$(whereis boost) >> ~/.bashrc

RUN pip install --no-cache-dir --user -r requirements.txt

FROM python:3.10-slim-buster@sha256:06d5be98525006c16db0dfdcc7f8d4925107ddad582d634a8a86cc667def06f8

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]