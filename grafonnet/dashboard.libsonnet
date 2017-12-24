local timepickerlib = import "timepicker.libsonnet";

{
    new(
        title,
        editable=false,
        style="dark",
        tags=[],
        time_from="now-6h",
        time_to="now",
        timezone="browser",
        refresh="",
        timepicker=timepickerlib.new(),
        hideControls=false,
    ):: {
        _annotations:: [],
        annotations: {
            list: [],
        },
        editable: editable,
        gnetId: null,
        graphTooltip: 0,
        hideControls: hideControls,
        id: null,
        links: [],
        panels:: [],
        refresh: refresh,
        rows: [],
        schemaVersion: 14,
        style: style,
        tags: tags,
        templating: {
            list: [],
        },
        time: {
            from: time_from,
            to: time_to,
        },
        timezone: timezone,
        timepicker: timepicker,
        title: title,
        version: 0,
        addAnnotation(annotation):: self {
            local t = self._annotations,
            _annotations+:: [annotation],
            annotations: { list: t },
        },
        addTemplate(template):: self {
            local t = self.templates,
            templates+:: [template],
            templating: { list: t },
        },
        _nextPanel:: 0,
        addRow(row)::
            self {
                // automatically number panels in added rows.
                // https://github.com/kausalco/public/blob/master/klumps/grafana.libsonnet
                local n = std.length(row.panels),
                local nextPanel = super._nextPanel,
                local panels = std.makeArray(n, function(i)
                    row.panels[i] { id: nextPanel + i }),

                _nextPanel: nextPanel + n,
                rows+: [row { panels: panels }],
            },
        addPanels(panels)::
            self {
                // automatically number panels in added rows.
                // https://github.com/kausalco/public/blob/master/klumps/grafana.libsonnet
                local n = std.length(panels),
                local nextPanel = super._nextPanel,
                local _panels = std.makeArray(n, function(i)
                    panels[i] { id: nextPanel + i }),

                _nextPanel: nextPanel + n,
                panels+::: _panels,
            },
        addPanel(panel, gridPos):: self + self.addPanels([panel { gridPos: gridPos }]),
        addRows(rows):: self {
            rows+: rows,
        },
        addLink(link):: self {
            links+: [link],
        },
    },
}
