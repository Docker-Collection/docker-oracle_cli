FROM python:3.9-slim-buster as Builder

COPY requirements.txt .

# RUN apk add --no-cache cmake

# RUN echo PATH=/usr/local/bin/cmake:$(which cmake) >> ~/.bashrc && \
#     echo PATH=/usr/include/boost:$(whereis boost) >> ~/.bashrc

RUN pip install --no-cache-dir --user -r requirements.txt

FROM python:3.9-slim-buster

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]