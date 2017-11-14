local grafana = import "grafonnet/grafana.libsonnet";
local dashboard = grafana.dashboard;
local row = grafana.row;
local template = grafana.template;
local graphPanel = grafana.graphPanel;
local singlestat = grafana.singlestat;
local prometheus = grafana.prometheus;


grafana.dashboard.new(
    "JVM",
    refresh="1m",
    time_from="now-1h",
    tags=["java"]
)
+ grafana.dashboard.addTemplate(
    grafana.template.datasource(
        "PROMETHEUS_DS",
        "prometheus",
        "Prometheus",
        hide="label",
    )
)
+ grafana.dashboard.addAnnotation(
    grafana.annotation.datasource(
        "Ansible",
        "-- Grafana --",
        tags=["ansible"],
        enable=false,
    )
)
+ grafana.dashboard.addAnnotation(
    grafana.annotation.datasource(
        "Support",
        "-- Grafana --",
        tags=["support"],
        enable=false,
    )
)
+ grafana.dashboard.addLink(
    grafana.link.dashboards(
        "System",
        ["node"],
    )
)
+ grafana.dashboard.addLink(
    grafana.link.dashboards(
        "Prometheus",
        ["prometheus"],
    )
)
+ grafana.dashboard.addLink(
    grafana.link.dashboards(
        "Apache",
        ["apache"],
    )
)
+ dashboard.addTemplate(
    template.new(
        "env",
        "$PROMETHEUS_DS",
        "label_values(jvm_threads_current, env)",
        label="Environment",
        refresh="time",
    )
)
+ dashboard.addTemplate(
    template.new(
        "job",
        "$PROMETHEUS_DS",
        "label_values(jvm_threads_current{env=\"$env\"}, job)",
        label="Job",
        refresh="time",
    )
)
+ dashboard.addTemplate(
    template.new(
        "instance",
        "$PROMETHEUS_DS",
        "label_values(jvm_threads_current{env=\"$env\",job=\"$job\"}, instance)",
        label="Instance",
        refresh="time",
    )
)
+ dashboard.addTemplate(
    template.new(
        "gc",
        "$PROMETHEUS_DS",
        "label_values(jvm_gc_collection_seconds_count{env=\"$env\",job=\"$job\",instance=\"$instance\"}, gc)",
        label="Instance",
        refresh="time",
        multi=true,
        includeAll=true,
        current="all",
        hide="value",
    )
)
+ dashboard.addTemplate(
    template.new(
        "pool",
        "$PROMETHEUS_DS",
        "label_values(jvm_memory_pool_bytes_committed{env=\"$env\",job=\"$job\",instance=\"$instance\"}, pool)",
        label="Instance",
        refresh="time",
        multi=true,
        includeAll=true,
        current="all",
        hide="value",
    )
)
+ dashboard.addRow(
    row.new(
        id=8,
        height="125px",
    )
    + row.addPanel(
        singlestat.new(
            "uptime",
            format="s",
            datasource="-- Mixed --",
            id=30,
            span=2,
            valueName="current",
        )
        + singlestat.addTarget(
            prometheus.target(
                "time()-process_start_time_seconds{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
            )
        )
    )
    + row.addPanel(
        singlestat.new(
            "JVM vendor",
            format="s",
            datasource="-- Mixed --",
            id=31,
            span=2,
            valueName="name",
            valueFontSize="50%",
        )
        + singlestat.addTarget(
            prometheus.target(
                "jvm_info{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="{{vendor}}"
            )
        )
    )
    + row.addPanel(
        singlestat.new(
            "JVM version",
            format="s",
            id=32,
            datasource="-- Mixed --",
            span=4,
            valueName="name",
            valueFontSize="50%",
        )
        + singlestat.addTarget(
            prometheus.target(
                "jvm_info{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="{{version}}"
            )
        )
    )
    + row.addPanel(
        singlestat.new(
            "Classes loaded",
            format="short",
            id=34,
            datasource="-- Mixed --",
            span=2,
            valueName="current",
        )
        + singlestat.addTarget(
            prometheus.target(
                "jvm_classes_loaded{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="{{version}}"
            )
        )
    )
)
+ dashboard.addRow(
    row.new(
        title="Memory",
        id=1,
    )
    + row.addPanel(
        graphPanel.new(
            "JVM Memory Heap",
            id=2,
            span=6,
            format="bytes",
            fill=0,
            min=0,
            decimals=2,
            datasource="-- Mixed --",
            legend_values=true,
            legend_min=true,
            legend_max=true,
            legend_current=true,
            legend_total=false,
            legend_avg=true,
            legend_alignAsTable=true,
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_bytes_max{env=\"$env\",job=\"$job\",instance=\"$instance\",area=\"heap\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="max"
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_bytes_used{env=\"$env\",job=\"$job\",instance=\"$instance\",area=\"heap\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="used"
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_bytes_committed{env=\"$env\",job=\"$job\",instance=\"$instance\",area=\"heap\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="committed"
            )
        )
    )
    + row.addPanel(
        graphPanel.new(
            "JVM Memory Non-Heap",
            id=3,
            span=6,
            format="bytes",
            fill=0,
            min=0,
            decimals=2,
            datasource="-- Mixed --",
            legend_values=true,
            legend_min=true,
            legend_max=true,
            legend_current=true,
            legend_total=false,
            legend_avg=true,
            legend_alignAsTable=true,
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_bytes_max{env=\"$env\",job=\"$job\",instance=\"$instance\",area=\"nonheap\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="max"
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_bytes_used{env=\"$env\",job=\"$job\",instance=\"$instance\",area=\"nonheap\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="used"
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_bytes_committed{env=\"$env\",job=\"$job\",instance=\"$instance\",area=\"nonheap\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="committed"
            )
        )
    )
)
+ dashboard.addRow(
    row.new(
        title="Memory pools",
        id=2,
    )
    + row.addPanel(
        graphPanel.new(
            "Memory $pool",
            repeat="pool",
            id=25,
            span=6,
            min_span=6,
            format="bytes",
            fill=0,
            min=0,
            decimals=2,
            datasource="-- Mixed --",
            legend_values=true,
            legend_min=true,
            legend_max=true,
            legend_current=true,
            legend_total=false,
            legend_avg=true,
            legend_alignAsTable=true,
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_pool_bytes_max{env=\"$env\",job=\"$job\",instance=\"$instance\",pool=\"$pool\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="max",
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_pool_bytes_used{env=\"$env\",job=\"$job\",instance=\"$instance\",pool=\"$pool\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="used",
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_memory_pool_bytes_committed{env=\"$env\",job=\"$job\",instance=\"$instance\",pool=\"$pool\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="committed",
            )
        )
    )
)
+ dashboard.addRow(
    row.new(
        title="Garbage Collection: $gc",
        repeat="gc",
        id=2,
    )
    + row.addPanel(
        graphPanel.new(
            "Number of garbage collection",
            id=15,
            span=6,
            min_span=6,
            format="short",
            fill=0,
            min=0,
            decimals=2,
            datasource="-- Mixed --",
            legend_values=true,
            legend_min=true,
            legend_max=true,
            legend_current=true,
            legend_total=false,
            legend_avg=true,
            legend_alignAsTable=true,
        )
        + graphPanel.addTarget(
            prometheus.target(
                "increase(jvm_gc_collection_seconds_count{env=\"$env\",job=\"$job\",instance=\"$instance\",gc=\"$gc\"}[5m])",
                datasource="$PROMETHEUS_DS",
                legendFormat="Garbage collections per 5m",
            )
        )
    )
    + row.addPanel(
        graphPanel.new(
            "Duration of garbage collection",
            id=16,
            span=6,
            min_span=6,
            format="s",
            fill=0,
            min=0,
            decimals=2,
            datasource="-- Mixed --",
            legend_values=true,
            legend_min=true,
            legend_max=true,
            legend_current=true,
            legend_total=false,
            legend_avg=true,
            legend_alignAsTable=true,
        )
        + graphPanel.addTarget(
            prometheus.target(
                "rate(jvm_gc_collection_seconds_sum{env=\"$env\",job=\"$job\",instance=\"$instance\",gc=\"$gc\"}[5m])/rate(jvm_gc_collection_seconds_count{env=\"$env\",job=\"$job\",instance=\"$instance\",gc=\"$gc\"}[5m])",
                datasource="$PROMETHEUS_DS",
                legendFormat="Avg of garbage Collection duration per 5m",
            )
        )
    )
)
+ dashboard.addRow(
    row.new(
        title="Threads",
        id=5,
    )
    + row.addPanel(
        graphPanel.new(
            "Thread count",
            id=5,
            span=6,
            min_span=6,
            format="short",
            fill=0,
            min=0,
            decimals=2,
            datasource="-- Mixed --",
            legend_values=true,
            legend_min=true,
            legend_max=true,
            legend_current=true,
            legend_total=false,
            legend_avg=true,
            legend_alignAsTable=true,
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_threads_peak{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="Peak thread count",
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_threads_current{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="Current thread count",
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_threads_daemon{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="Daemon thread count",
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_threads_deadlocked{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="Cycles of JVM-threads that are in deadlock waiting to acquire object monitors or ownable synchronizers",
            )
        )
        + graphPanel.addTarget(
            prometheus.target(
                "jvm_threads_deadlocked_monitor{env=\"$env\",job=\"$job\",instance=\"$instance\"}",
                datasource="$PROMETHEUS_DS",
                legendFormat="Cycles of JVM-threads that are in deadlock waiting to acquire object monitors",
            )
        )
    )
    + row.addPanel(
        graphPanel.new(
            "New threads",
            id=6,
            span=6,
            min_span=6,
            format="short",
            fill=0,
            min=0,
            decimals=2,
            datasource="-- Mixed --",
            legend_values=true,
            legend_min=true,
            legend_max=true,
            legend_current=true,
            legend_total=false,
            legend_avg=true,
            legend_alignAsTable=true,
        )
        + graphPanel.addTarget(
            prometheus.target(
                "rate(jvm_threads_started_total{env=\"$env\",job=\"$job\",instance=\"$instance\"}[5m])",
                datasource="$PROMETHEUS_DS",
                legendFormat="Started threads rate",
            )
        )
    )
)
