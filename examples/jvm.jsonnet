local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local template = grafana.template;
local graphPanel = grafana.graphPanel;
local singlestat = grafana.singlestat;
local prometheus = grafana.prometheus;


grafana.dashboard.new(
  'JVM',
  refresh='1m',
  time_from='now-1h',
  tags=['java']
)
.addTemplate(
  grafana.template.datasource(
    'PROMETHEUS_DS',
    'prometheus',
    'Prometheus',
    hide='label',
  )
)
.addAnnotation(
  grafana.annotation.datasource(
    'Ansible',
    '-- Grafana --',
    tags=['ansible'],
    enable=false,
  )
)
.addAnnotation(
  grafana.annotation.datasource(
    'Support',
    '-- Grafana --',
    tags=['support'],
    enable=false,
  )
)
.addLink(
  grafana.link.dashboards(
    'System',
    ['node'],
  )
)
.addLink(
  grafana.link.dashboards(
    'Prometheus',
    ['prometheus'],
  )
)
.addLink(
  grafana.link.dashboards(
    'Apache',
    ['apache'],
  )
)
.addTemplate(
  template.new(
    'env',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current, env)',
    label='Environment',
    refresh='time',
  )
)
.addTemplate(
  template.new(
    'job',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current{env="$env"}, job)',
    label='Job',
    refresh='time',
  )
)
.addTemplate(
  template.new(
    'instance',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current{env="$env",job="$job"}, instance)',
    label='Instance',
    refresh='time',
  )
)
.addTemplate(
  template.new(
    'gc',
    '$PROMETHEUS_DS',
    'label_values(jvm_gc_collection_seconds_count{env="$env",job="$job",instance="$instance"}, gc)',
    label='Instance',
    refresh='time',
    multi=true,
    includeAll=true,
    current='all',
    hide='value',
  )
)
.addTemplate(
  template.new(
    'pool',
    '$PROMETHEUS_DS',
    'label_values(jvm_memory_pool_bytes_committed{env="$env",job="$job",instance="$instance"}, pool)',
    label='Instance',
    refresh='time',
    multi=true,
    includeAll=true,
    current='all',
    hide='value',
  )
)
.addRow(
  row.new(
    height='125px',
  )
  .addPanel(
    singlestat.new(
      'uptime',
      format='s',
      datasource='-- Mixed --',
      span=2,
      valueName='current',
    )
    .addTarget(
      prometheus.target(
        'time()-process_start_time_seconds{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
      )
    )
  )
  .addPanel(
    singlestat.new(
      'JVM vendor',
      format='s',
      datasource='-- Mixed --',
      span=2,
      valueName='name',
      valueFontSize='50%',
    )
    .addTarget(
      prometheus.target(
        'jvm_info{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='{{vendor}}'
      )
    )
  )
  .addPanel(
    singlestat.new(
      'JVM version',
      format='s',
      datasource='-- Mixed --',
      span=4,
      valueName='name',
      valueFontSize='50%',
    )
    .addTarget(
      prometheus.target(
        'jvm_info{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='{{version}}'
      )
    )
  )
  .addPanel(
    singlestat.new(
      'Classes loaded',
      format='short',
      datasource='-- Mixed --',
      span=2,
      valueName='current',
    )
    .addTarget(
      prometheus.target(
        'jvm_classes_loaded{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='{{version}}'
      )
    )
  )
)
.addRow(
  row.new(
    title='Memory',
    height='250px',
  )
  .addPanel(
    graphPanel.new(
      'JVM Memory Heap',
      span=6,
      format='bytes',
      fill=0,
      min=0,
      decimals=2,
      datasource='-- Mixed --',
      legend_values=true,
      legend_min=true,
      legend_max=true,
      legend_current=true,
      legend_total=false,
      legend_avg=true,
      legend_alignAsTable=true,
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_bytes_max{env="$env",job="$job",instance="$instance",area="heap"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='max'
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_bytes_used{env="$env",job="$job",instance="$instance",area="heap"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='used'
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_bytes_committed{env="$env",job="$job",instance="$instance",area="heap"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='committed'
      )
    )
  )
  .addPanel(
    graphPanel.new(
      'JVM Memory Non-Heap',
      span=6,
      format='bytes',
      fill=0,
      min=0,
      decimals=2,
      datasource='-- Mixed --',
      legend_values=true,
      legend_min=true,
      legend_max=true,
      legend_current=true,
      legend_total=false,
      legend_avg=true,
      legend_alignAsTable=true,
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_bytes_max{env="$env",job="$job",instance="$instance",area="nonheap"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='max'
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_bytes_used{env="$env",job="$job",instance="$instance",area="nonheap"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='used'
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_bytes_committed{env="$env",job="$job",instance="$instance",area="nonheap"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='committed'
      )
    )
  )
)
.addRow(
  row.new(
    title='Memory pools',
    height='250px',
  )
  .addPanel(
    graphPanel.new(
      'Memory $pool',
      repeat='pool',
      span=6,
      min_span=6,
      format='bytes',
      fill=0,
      min=0,
      decimals=2,
      datasource='-- Mixed --',
      legend_values=true,
      legend_min=true,
      legend_max=true,
      legend_current=true,
      legend_total=false,
      legend_avg=true,
      legend_alignAsTable=true,
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_pool_bytes_max{env="$env",job="$job",instance="$instance",pool="$pool"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='max',
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_pool_bytes_used{env="$env",job="$job",instance="$instance",pool="$pool"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='used',
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_memory_pool_bytes_committed{env="$env",job="$job",instance="$instance",pool="$pool"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='committed',
      )
    )
  )
)
.addRow(
  row.new(
    title='Garbage Collection: $gc',
    repeat='gc',
    height='250px',
  )
  .addPanel(
    graphPanel.new(
      'Number of garbage collection',
      span=6,
      min_span=6,
      format='short',
      fill=0,
      min=0,
      decimals=2,
      datasource='-- Mixed --',
      legend_values=true,
      legend_min=true,
      legend_max=true,
      legend_current=true,
      legend_total=false,
      legend_avg=true,
      legend_alignAsTable=true,
    )
    .addTarget(
      prometheus.target(
        'increase(jvm_gc_collection_seconds_count{env="$env",job="$job",instance="$instance",gc="$gc"}[5m])',
        datasource='$PROMETHEUS_DS',
        legendFormat='Garbage collections per 5m',
      )
    )
  )
  .addPanel(
    graphPanel.new(
      'Duration of garbage collection',
      span=6,
      min_span=6,
      format='s',
      fill=0,
      min=0,
      decimals=2,
      datasource='-- Mixed --',
      legend_values=true,
      legend_min=true,
      legend_max=true,
      legend_current=true,
      legend_total=false,
      legend_avg=true,
      legend_alignAsTable=true,
    )
    .addTarget(
      prometheus.target(
        'rate(jvm_gc_collection_seconds_sum{env="$env",job="$job",instance="$instance",gc="$gc"}[5m])/rate(jvm_gc_collection_seconds_count{env="$env",job="$job",instance="$instance",gc="$gc"}[5m])',
        datasource='$PROMETHEUS_DS',
        legendFormat='Avg of garbage Collection duration per 5m',
      )
    )
  )
)
.addRow(
  row.new(
    title='Threads',
    height='250px',
  )
  .addPanel(
    graphPanel.new(
      'Thread count',
      span=6,
      min_span=6,
      format='short',
      fill=0,
      min=0,
      decimals=2,
      datasource='-- Mixed --',
      legend_values=true,
      legend_min=true,
      legend_max=true,
      legend_current=true,
      legend_total=false,
      legend_avg=true,
      legend_alignAsTable=true,
    )
    .addTarget(
      prometheus.target(
        'jvm_threads_peak{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='Peak thread count',
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_threads_current{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='Current thread count',
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_threads_daemon{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='Daemon thread count',
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_threads_deadlocked{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='Cycles of JVM-threads that are in deadlock waiting to acquire object monitors or ownable synchronizers',
      )
    )
    .addTarget(
      prometheus.target(
        'jvm_threads_deadlocked_monitor{env="$env",job="$job",instance="$instance"}',
        datasource='$PROMETHEUS_DS',
        legendFormat='Cycles of JVM-threads that are in deadlock waiting to acquire object monitors',
      )
    )
  )
  .addPanel(
    graphPanel.new(
      'New threads',
      span=6,
      min_span=6,
      format='short',
      fill=0,
      min=0,
      decimals=2,
      datasource='-- Mixed --',
      legend_values=true,
      legend_min=true,
      legend_max=true,
      legend_current=true,
      legend_total=false,
      legend_avg=true,
      legend_alignAsTable=true,
    )
    .addTarget(
      prometheus.target(
        'rate(jvm_threads_started_total{env="$env",job="$job",instance="$instance"}[5m])',
        datasource='$PROMETHEUS_DS',
        legendFormat='Started threads rate',
      )
    )
  )
)
.addRequired('grafana', 'grafana', 'Grafana', '5.0.0')
.addRequired('panel', 'graph', 'Graph', '5.0.0')
.addRequired('datasource', 'prometheus', 'Prometheus', '5.0.0')
.addRequired('panel', 'singlestat', 'Singlestat', '5.0.0')
