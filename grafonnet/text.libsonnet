{
    new(
        title='',
        span=12,
        mode='markdown',
        content='',
        transparent=null,
    )::
        {
            [if transparent != null then 'transparent']: transparent,
            title: title,
            span: span,
            type: 'text',
            mode: mode,
            content: content,
        },
}
