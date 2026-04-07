FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=11434

# Install deps
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    zstd \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

EXPOSE 11434

# Proper startup script
CMD sh -c "\
  export OLLAMA_HOST=0.0.0.0:$PORT; \
  ollama serve & \
  echo 'Waiting for Ollama...'; \
  until curl -s http://127.0.0.1:$PORT > /dev/null; do sleep 2; done; \
  echo 'Ollama is up! Pulling model...'; \
  ollama pull qwen2.5-coder:1.5b; \
  wait"
