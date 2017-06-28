#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Please enter a git commit message:"
  exit
fi

jekyll build && \
  git add . && \
  git commit -am "$1" && \
  git push origin source && \
  cd _site && \
  git add . && \
  git commit -am "$1" && \
  git push origin master && \
  cd .. && \
  echo "Successfully built and pushed to GitHub."