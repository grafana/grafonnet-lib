{
    new(
        title="Dashboard Row",
        id=null,
        height="250px",
        collapse=false,
        repeat=null,
        showTitle=false,
        titleSize="h6"
    ):: {
        collapse: collapse,
        height: height,
        [if id != null then "id"]: id,
        panels: [],
        repeat: null,
        repeatIteration: null,
        repeatRowId: null,
        showTitle: showTitle,
        title: title,
        titleSize: titleSize,
    },
    addPanel(panel):: {
        panels+: [panel],
    },
}
