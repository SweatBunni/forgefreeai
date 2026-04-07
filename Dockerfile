# Use official Ubuntu base
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    zstd \
    && rm -rf /var/lib/apt/lists/*

# Set the port that Render will assign
ENV PORT=11434
EXPOSE $PORT

# Install Ollama CLI
RUN curl -fsSL https://ollama.com/install.sh | sh

# Pull the model (this may take a while)
RUN ollama pull qwen2.5-coder:14b

# Start Ollama server on Render's assigned port
CMD ["sh", "-c", "ollama serve --port $PORT"]
