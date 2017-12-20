{
    new(
        title="Dashboard Row",
        id=null,
        height="250px",
        collapse=false,
        repeat=null,
        showTitle=null,
        titleSize="h6"
    ):: {
        collapse: collapse,
        collapsed: collapse,
        height: height,
        [if id != null then "id"]: id,
        panels: [],
        repeat: repeat,
        repeatIteration: null,
        repeatRowId: null,
        showTitle:
            if showTitle != null then
                showTitle
            else
                title != "Dashboard Row",
        title: title,
        type: "row",
        titleSize: titleSize,
    },
    addPanels(panels):: {
        panels+: panels,
    },
    addPanel(panel, gridPos={}):: {
        panels+: [panel { gridPos: gridPos }],
    },
}
