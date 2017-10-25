#!/bin/sh

x=0

for i in `find . -name '*.jsonnet' -or -name '*.libsonnet'`
do
    t="Formating $i..."
    if jsonnet fmt --test -n 4 $i;
    then
        echo $t OK
    else
        echo $t NOK
        x=1
    fi
done

for i in tests/*/*.jsonnet
do
    json=$(dirname $i)/$( basename $i .jsonnet ).json
    t="Compiling $i..."
    if jsonnet  -J . $i > $json
    then
        echo $t OK
    else
        echo $t NOK
        x=1
        continue
    fi

    t="Checking $i..."
    if diff $json $json.expected
    then
        echo $t OK
    else
        echo $t NOK
        x=1
    fi
done
exit $x
