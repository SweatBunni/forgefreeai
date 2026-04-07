FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=11434

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    zstd \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Expose port
EXPOSE 11434

# Start Ollama + pull model
CMD sh -c "\
  OLLAMA_HOST=0.0.0.0:$PORT ollama serve & \
  sleep 5 && \
  ollama pull qwen2.5-coder:14b && \
  wait"
