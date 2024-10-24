#!/bin/bash
DIFF=$(git diff --cached)
PROMPT="You are an AI assistant trained to generate Git commit messages.\nGiven the following code diff, please provide a concise and informative commit message. ONLY OUTPUT THE COMMIT MESSAGE. NOTHING ELSE.\nDIFF:\n$DIFF"
echo "$PROMPT" | ollama run llama3.2
