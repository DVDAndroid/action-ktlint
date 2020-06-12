#!/bin/sh

export ANDROID=
export RELATIVE=

if [ "$INPUT_FAIL_ON_ERROR" = true ] ; then
  set -o pipefail
fi

if [ "$INPUT_ANDROID" = true ] ; then
  export ANDROID=--android
fi

if [ "$INPUT_RELATIVE" = true ] ; then
  export RELATIVE=--relative
fi

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

ktlint --reporter=checkstyle $ANDROID $RELATIVE \
  | reviewdog -f=checkstyle -name="ktlint" -reporter="${INPUT_REPORTER}" -level="${INPUT_LEVEL}"
