{
    new(
        title,
        id=null,
        format="none",
        interval=null,
        datasource=null,
        span=12,
        valueName="avg",
    )::
        {
            [if id != null then "id"]: id,
            title: title,
            span: span,
            type: "singlestat",
            datasource: datasource,
            targets: [
            ],
            links: [],
            maxDataPoints: 100,
            interval: interval,
            cacheTimeout: null,
            format: format,
            prefix: "",
            postfix: "",
            nullText: null,
            valueMaps: [
                {
                    value: "null",
                    op: "=",
                    text: "N/A",
                },
            ],
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
            rangeMaps: [
                {
                    from: "null",
                    to: "null",
                    text: "N/A",
                },
            ],
            mappingType: 1,
            nullPointMode: "connected",
            valueName: valueName,
            prefixFontSize: "50%",
            valueFontSize: "80%",
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
