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
        titleSize: titleSize,
    },
    addPanel(panel):: {
        panels+: [panel],
    },
}
