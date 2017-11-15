{
    new(
        id=null,
        title="",
        span=12,
        mode="markdown",
        content="",
        transparent=null,
    )::
        {
            [if id != null then "id"]: id,
            [if transparent != null then "transparent"]: transparent,
            title: title,
            span: span,
            type: "text",
            mode: mode,
            content: content,
        },
}
