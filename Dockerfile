# syntax=docker/dockerfile:1
FROM python:3.11-slim
# Build-time variables
ARG OPENAI_BASE_URL
ARG OPENAI_API_KEY
ARG DEFAULT_MODEL

RUN apt-get update \
 && apt-get install -y --no-install-recommends git \
    gcc \
    python3-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/OpenInterpreter/open-interpreter.git . \
 && git checkout 21babb186f13e263a72cf525d15d79788edf4644

RUN pip install --upgrade pip \
 && pip install "open-interpreter[os]"

ENV OPENAI_BASE_URL="${OPENAI_BASE_URL}"
ENV OPENAI_API_KEY="${OPENAI_API_KEY}"
ENV DEFAULT_MODEL="${DEFAULT_MODEL}"

ENTRYPOINT ["interpreter"]
CMD ["--help"]
