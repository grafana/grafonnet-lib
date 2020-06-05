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
docker run --rm -p 3000:3000 grafana/grafana
```
