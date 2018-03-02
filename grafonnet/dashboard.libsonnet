local timepickerlib = import 'timepicker.libsonnet';

{
    new(
        title,
        editable=false,
        style='dark',
        tags=[],
        time_from='now-6h',
        time_to='now',
        timezone='browser',
        refresh='',
        timepicker=timepickerlib.new(),
        hideControls=false,
        uid='',
    ):: {
        local it = self,
        _annotations:: [],
        [if uid != '' then 'uid']: uid,
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
        time: {
            from: time_from,
            to: time_to,
        },
        timezone: timezone,
        timepicker: timepicker,
        title: title,
        version: 0,
        addAnnotation(annotation):: self {
            _annotations+:: [annotation],
        },
        addTemplate(t):: self {
            templates+: [t],
        },
        templates:: [],
        annotations: { list: it._annotations },
        templating: { list: it.templates },
        _nextPanel:: 2,
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
        addPanels(newpanels)::
            self {
                // automatically number panels in added rows.
                // https://github.com/kausalco/public/blob/master/klumps/grafana.libsonnet
                local n = std.foldl(function(numOfPanels, p)
                    (if 'panels' in p
                     then
                         numOfPanels + 1 + std.length(p.panels)
                     else
                         numOfPanels + 1), newpanels, 0),
                local nextPanel = super._nextPanel,
                local _panels = std.makeArray(
                    std.length(newpanels), function(i)
                        newpanels[i] {
                            id: nextPanel + (
                                if i == 0 then
                                    0
                                else
                                    if 'panels' in _panels[i - 1] then
                                        (_panels[i - 1].id - nextPanel) + 1 + std.length(_panels[i - 1].panels)
                                    else
                                        (_panels[i - 1].id - nextPanel) + 1

                            ),
                            [if 'panels' in newpanels[i] then 'panels']: std.makeArray(
                                std.length(newpanels[i].panels), function(j)
                                    newpanels[i].panels[j] {
                                        id: 1 + j +
                                            nextPanel + (
                                            if i == 0 then
                                                0
                                            else
                                                if 'panels' in _panels[i - 1] then
                                                    (_panels[i - 1].id - nextPanel) + 1 + std.length(_panels[i - 1].panels)
                                                else
                                                    (_panels[i - 1].id - nextPanel) + 1

                                        ),
                                    }
                            ),
                        }
                ),

                _nextPanel: nextPanel + n,
                panels+::: _panels,
            },
        addPanel(panel, gridPos):: self + self.addPanels([panel { gridPos: gridPos }]),
        addRows(rows):: std.foldl(function(d, row) d.addRow(row), rows, self),
        addLink(link):: self {
            links+: [link],
        },
    },
}
