#!/usr/bin/env bash

printf '%s' "$*" | \
  piper-tts -m "$HOME/.local/share/piper/voices/de/de_DE-thorsten-high.onnx" \
    --length-scale 0.8 -f - | \
  mpv --no-terminal -