# Use official Ubuntu base
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=11434
EXPOSE $PORT

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    zstd \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama CLI
RUN curl -fsSL https://ollama.com/install.sh | sh

# Start Ollama server and pull the model dynamically
CMD sh -c "ollama serve --port $PORT & \
           sleep 5 && \
           ollama pull qwen2.5-coder:14b && \
           wait"
