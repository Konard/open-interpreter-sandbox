#!/usr/bin/env bash
set -euo pipefail

# Load environment variables from .env file if it exists
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

IMAGE_NAME=openinterpreter-test

docker build -t "$IMAGE_NAME" .

docker run --rm -it \
  -e OPENAI_BASE_URL="${OPENAI_BASE_URL:-}" \
  -e OPENAI_API_KEY="${OPENAI_API_KEY:-}" \
  -e DEFAULT_MODEL="${DEFAULT_MODEL:-}" \
  "$IMAGE_NAME" \
  --api_base "$OPENAI_BASE_URL" \
  --api_key "$OPENAI_API_KEY" \
  --model "$DEFAULT_MODEL"