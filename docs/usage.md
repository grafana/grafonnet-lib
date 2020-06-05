# Usage

## The Simplest Approach

Your current directory would look something like this:

```
▸ tree -L 1 .
.
├── dashboard.jsonnet
└── grafonnet-lib

1 directory, 1 file
```

You've cloned Grafonnet and you've create a file called, `dashboard.jsonnet`.
That file might look something like this:

```
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new('Empty Dashboard')
```

From here, you can run the following command to generate your dashboard:

```
jsonnet -J grafonnet-lib dashboard.jsonnet
```

<details>
<summary>show output</summary>

```
{
   "__inputs": [ ],
   "__requires": [ ],
   "annotations": {
      "list": [ ]
   },
   "editable": false,
   "gnetId": null,
   "graphTooltip": 0,
   "hideControls": false,
   "id": null,
   "links": [ ],
   "refresh": "",
   "rows": [ ],
   "schemaVersion": 14,
   "style": "dark",
   "tags": [ ],
   "templating": {
      "list": [ ]
   },
   "time": {
      "from": "now-6h",
      "to": "now"
   },
   "timepicker": {
      "refresh_intervals": [
         "5s",
         "10s",
         "30s",
         "1m",
         "5m",
         "15m",
         "30m",
         "1h",
         "2h",
         "1d"
      ],
      "time_options": [
         "5m",
         "15m",
         "1h",
         "6h",
         "12h",
         "24h",
         "2d",
         "7d",
         "30d"
      ]
   },
   "timezone": "browser",
   "title": "Empty Dashboard",
   "version": 0
}

```

</details>

Next you need to actually create the dashboard on Grafana. One option is to
paste the dashboard JSON on the Grafana UI.

A less tedious approach would be to use Grafana's [dashboard
API](https://grafana.com/docs/grafana/latest/http_api/dashboard/). For example,
you could create and execute this script in our example directory:

```
#!/usr/bin/env bash

JSONNET_PATH=grafonnet-lib \
  jsonnet dashboard.jsonnet > dashboard.json

payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"

curl -X POST $BASIC_AUTH \
  -H 'Content-Type: application/json' \
  -d "${payload}" \
  "http://admin:admin@localhost:3000/api/dashboards/db"
```

The above URL assumes you're running a Grafana instance locally. You can do that
by running a Grafana container on your local Docker engine:

```
docker run --rm -d -p 3000:3000 grafana/grafana
```

## Grizzly

Another way you could manage your Grafonnet code is by using
[Grizzly](https://github.com/malcolmholmes/grizzly). Grizzly is a command line
tool for managing Grafana dashboards as code written in Jsonnet.

In this section, we'll assume you've used
[jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler) to install
Grafonnet. In which case your current directory would look like this:

```
▸ tree -L 2 .
.
├── dashboards.jsonnet
├── jsonnetfile.json
├── jsonnetfile.lock.json
└── vendor
    ├── github.com
    └── grafonnet -> github.com/grafana/grafonnet-lib/grafonnet

3 directories, 3 files
```

`dashboards.jsonnet` (now plural) will look slightly different than before:

```
local grafana = import 'grafonnet/grafana.libsonnet';

{
  grafanaDashboards:: {
    empty_dashboard: grafana.dashboard.new('Empty Dashboard'),
  },
}
```

First you need to set the `GRAFANA_URL` environment variable:

```
export GRAFANA_URL=http://admin:admin@localhost:3000
```

Next create the dashboard with on your Grafana instance with:

```
grr apply dashboards.jsonnet
```

Check [Grizzly's GitHub page](https://github.com/malcolmholmes/grizzly) for
other commands and documentation.
