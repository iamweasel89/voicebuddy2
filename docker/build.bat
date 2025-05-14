@echo off
docker build -t vosk-arm -f Dockerfile.armv7 .
docker run --rm vosk-arm
