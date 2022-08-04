#!/bin/bash

BASEPATH="Documentation/"
LOCAL_REPO_PATH="$PWD"
CHECKOUT_PATH="${PWD}/checkout"
OUTPUT_PATH="${CHECKOUT_PATH}/docs"

echo "Path: ${LOCAL_REPO_PATH}"

if test -d "${CHECKOUT_PATH}"; then
  cd checkout
else
  mkdir checkout
  cd checkout
fi
if test -d Lighter; then
  cd Lighter && git pull && cd ..
else
  git clone git@github.com:55DB091A-8471-447B-8F50-5DFF4C1B14AC/Lighter.git
fi

rm Lighter/Package*.swift
cp ../Package.swift Lighter/
cd Lighter

swift package \
  --allow-writing-to-directory "${LOCAL_REPO_PATH}" \
  generate-documentation \
  --target Lighter \
  --disable-indexing \
  --transform-for-static-hosting \
  --hosting-base-path "${BASEPATH}" \
  --output-path "${LOCAL_REPO_PATH}"
