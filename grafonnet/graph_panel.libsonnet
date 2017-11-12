{
    /**
     * Returns a new graph panel that can be added in a row.
     * It requires the graph panel plugin in grafana, which is built-in.
     *
     * @param title The title of the graph panel.
     * @param span Width of the panel
     * @param datasource Datasource
     * @param id ID of the panel. If null, not added to the json output.
     * @param fill Fill, integer from 0 to 10
     * @param linewidth Line Width, integer from 0 to 10
     * @param decimals Override automatic decimal precision for legend and tooltip. If null, not added to the json output.
     * @param min_span Min span
     * @param format Unit of the Y axes
     * @param min Min of the Y axes
     * @param max Max of the Y axes
     * @param lines Display lines, boolean
     * @param points Display points, boolean
     * @param bars Display bars, boolean
     * @param dashes Display line as dashes
     * @param stack Stack values
     * @param repeat Variable used to repeat the graph panel
     * @param legend_show Show legend
     * @param legend_values Show values in legend
     * @param legend_min Show min in legend
     * @param legend_max Show max in legend
     * @param legend_current Show current in legend
     * @param legend_total Show total in legend
     * @param legend_avg Show average in legend
     * @param legend_alignAsTable Show legend as table
     * @param legend_rightSide Show legend to the right
     * @return A json that represents a graph panel
     */
    new(
        title,
        span=12,
        id=null,
        fill=1,
        linewidth=1,
        decimals=null,
        min_span=null,
        format="short",
        min=null,
        max=null,
        lines=true,
        datasource=null,
        points=false,
        bars=false,
        dashes=false,
        stack=false,
        repeat=null,
        legend_show=true,
        legend_values=false,
        legend_min=false,
        legend_max=false,
        legend_current=false,
        legend_total=false,
        legend_avg=false,
        legend_alignAsTable=false,
        legend_rightSide=false,
    ):: {
        [if id != null then "id"]: id,
        title: title,
        span: span,
        [if min_span != null then "minSpan"]: min_span,
        [if decimals != null then "decimals"]: decimals,
        type: "graph",
        datasource: datasource,
        targets: [
        ],
        renderer: "flot",
        yaxes: [
            $.yaxe(format, min, max),
            $.yaxe(format, min, max),
        ],
        xaxis: {
            show: true,
            mode: "time",
            name: null,
            values: [],
            buckets: null,
        },
        lines: lines,
        fill: fill,
        linewidth: linewidth,
        dashes: dashes,
        dashLength: 10,
        spaceLength: 10,
        points: points,
        pointradius: 5,
        bars: bars,
        stack: stack,
        percentage: false,
        legend: {
            show: legend_show,
            values: legend_values,
            min: legend_min,
            max: legend_max,
            current: legend_current,
            total: legend_total,
            alignAsTable: legend_alignAsTable,
            rightSide: legend_rightSide,
            avg: legend_avg,
        },
        nullPointMode: "null",
        steppedLine: false,
        tooltip: {
            value_type: "individual",
            shared: true,
            sort: 0,
        },
        timeFrom: null,
        timeShift: null,
        aliasColors: {},
        repeat: repeat,
        seriesOverrides: [],
        thresholds: [],
    },
    yaxe(
        format="short",
        min=null,
        max=null,
        label=null,
        show=true,
        logBase=1
    ):: {
        label: label,
        show: show,
        logBase: logBase,
        min: min,
        max: max,
        format: format,
    },
    addTarget(target):: {
        targets+: [target],
    },
}