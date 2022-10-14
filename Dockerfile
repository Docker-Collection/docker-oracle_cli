FROM python:3.10-slim-buster@sha256:de7ade35986baafd658c9b1a952128841b6ae64a06c3c7e065c1d9ea5f5f4fc4 as Builder

COPY requirements.txt .

# RUN apk add --no-cache cmake

# RUN echo PATH=/usr/local/bin/cmake:$(which cmake) >> ~/.bashrc && \
#     echo PATH=/usr/include/boost:$(whereis boost) >> ~/.bashrc

RUN pip install --no-cache-dir --user -r requirements.txt

FROM python:3.10-slim-buster@sha256:de7ade35986baafd658c9b1a952128841b6ae64a06c3c7e065c1d9ea5f5f4fc4

COPY --from=Builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

RUN yes | oci setup autocomplete

ENTRYPOINT [ "oci" ]