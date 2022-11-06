#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "$#" != 2 ]; then
  echo "Usage: $(basename "$0") VERSION OUTPUTDIR"
  exit 1
fi

VERSION="$1"
OUTPUTDIR="$2"

mkdir -p "$OUTPUTDIR/$VERSION"

TEMPDIR=$(mktemp -d)

trap "rm -rf $TEMPDIR" EXIT

git clone --branch "$VERSION" --depth 1 https://github.com/grafana/grafana.git "$TEMPDIR"
cd "$TEMPDIR"

cd pkg/coremodel/dashboard
thema lineage gen jsonschema > "$OUTPUTDIR/$VERSION/dashboard.json"
cd -

# Made an assumption here, generating jsonschema for these don't work.
#for FILE in $(find public -name models.cue); do
#    DIR=$(dirname "$FILE")
#    NAME=$(basename "$DIR")
#    cd "$DIR"
#    thema lineage gen jsonschema > "$OUTPUTDIR/$VERSION/$NAME.json"
#    cd -
#done
