{
    new(
        title,
        id=null,
        format="none",
        interval=null,
        datasource=null,
        span=12,
        decimals=null,
        valueName="avg",
        valueFontSize="80%",
        mappingType=1,
        valueMaps=[
            {
                value: "null",
                op: "=",
                text: "N/A",
            },
        ],
        rangeMaps=[
            {
                from: "null",
                to: "null",
                text: "N/A",
            },
        ],
        transparent=null,
    )::
        {
            [if id != null then "id"]: id,
            [if transparent != null then "transparent"]: transparent,
            title: title,
            span: span,
            type: "singlestat",
            datasource: datasource,
            targets: [
            ],
            links: [],
            [if decimals != null then "decimals"]: decimals,
            maxDataPoints: 100,
            interval: interval,
            cacheTimeout: null,
            format: format,
            prefix: "",
            postfix: "",
            nullText: null,
            valueMaps: valueMaps,
            mappingTypes: [
                {
                    name: "value to text",
                    value: 1,
                },
                {
                    name: "range to text",
                    value: 2,
                },
            ],
            rangeMaps: rangeMaps,
            mappingType:
                if mappingType == "value"
                then
                    1
                else if mappingType == "range"
                then
                    2
                else
                    mappingType,
            nullPointMode: "connected",
            valueName: valueName,
            prefixFontSize: "50%",
            valueFontSize: valueFontSize,
            postfixFontSize: "50%",
            thresholds: "",
            colorBackground: false,
            colorValue: false,
            colors: [
                "#299c46",
                "rgba(237, 129, 40, 0.89)",
                "#d44a3a",
            ],
            sparkline: {
                show: false,
                full: false,
                lineColor: "rgb(31, 120, 193)",
                fillColor: "rgba(31, 118, 189, 0.18)",
            },
            gauge: {
                show: false,
                minValue: 0,
                maxValue: 100,
                thresholdMarkers: true,
                thresholdLabels: false,
            },
            tableColumn: "",
        },
    addTarget(target):: {
        targets+: [target],
    },
}
