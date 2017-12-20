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
    },
    addAnnotation(annotation):: {
        local t = self._annotations,
        _annotations+:: [annotation],
        annotations: { list: t },
    },
    addTemplate(template):: {
        local t = self.templates,
        templates+:: [template],
        templating: { list: t },
    },
    addRow(row):: {
        rows+: [row],
    },
    addPanels(panels)::
        {
            panels+::: panels,
        },
    addPanel(panel, gridPos)::
        {
            panels+::: [panel { gridPos: gridPos }],
        },
    addRows(rows):: {
        rows+: rows,
    },
    addLink(link):: {
        links+: [link],
    },
}
