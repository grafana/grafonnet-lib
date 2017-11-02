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
        refresh="off",
        timepicker=timepickerlib.new(),
    ):: {
        annotations: {
            list: [],
        },
        editable: editable,
        gnetId: null,
        graphTooltip: 0,
        hideControls: false,
        id: null,
        links: [],
        refresh: refresh,
        rows: [],
        schemaVersion: 14,
        style: "dark",
        tags: [],
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
    addTemplate(template):: {
        local t = self.templates,
        templates+:: [template],
        templating: { list: t },
    },
}
