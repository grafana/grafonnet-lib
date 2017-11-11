local grafana = import "grafonnet/grafana.libsonnet";
local links = grafana.links;

{
    basic: links.dashboards("node", ["nodes", "system"]),
    advance: links.dashboards(
        "adv",
        ["advanced"],
        asDropdown=false,
        includeVars=true,
        keepTime=true,
    ),
}
