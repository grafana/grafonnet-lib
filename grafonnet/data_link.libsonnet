{
  /**
   * Creates a [data link](https://grafana.com/docs/grafana/latest/linking/data-links/).
   *
   * @param title Human-readable label for the link.
   * @param url (default: `''`) URL of the link
   *
   * @name dataLink.new
   */
  new(
    title,
    url='',
    targetBlank=false,
  )::
    {
      title: title,
      url: url,
      targetBlank: targetBlank,
    },
}
