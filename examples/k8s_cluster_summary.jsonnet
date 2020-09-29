// Example created to model, "K8s Cluster Summary", community dashboard:
//
// https://grafana.com/grafana/dashboards/8685

local grafana = import 'grafonnet/grafana.libsonnet';

local singlestatHeight = 100;
local singlestatGuageHeight = 150;

grafana.dashboard.new(
  'K8s Cluster Summary',
  description='Summary metrics about containers running on Kubernetes nodes and mainline kubernetes statistics',
  tags=['kubernetes'],
  time_from='now-1h',
)

// Templates

.addTemplate(
  grafana.template.datasource(
    'datasource',
    'prometheus',
    '',
  )
)

// Number of Nodes

.addRow(
  grafana.row.new(
    title='Node',
  )
  .addPanel(
    grafana.singlestat.new(
      'Number of Nodes',
      datasource='$datasource',
      height=singlestatHeight,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_info)',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Nodes Out of Disk',
      colorBackground=true,
      datasource='$datasource',
      height=singlestatHeight,
      thresholds='1',
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_status_condition{condition="OutOfDisk", status="true"})',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Nodes Unavailable',
      colorBackground=true,
      datasource='$datasource',
      height=singlestatHeight,
      thresholds='1',
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_spec_unschedulable)',
      )
    )
  )
  .addPanel(
    grafana.tablePanel.new(
      'Node Info',
      datasource='$datasource',
      span=12,
      styles=[

        { alias: 'Instance', pattern: 'instance' },
        { alias: 'Instance Type', pattern: 'beta_kubernetes_io_instance_type' },
        { alias: 'Node Pool', pattern: 'cloud_google_com_gke_nodepool' },
        { alias: 'Region', pattern: 'failure_domain_beta_kubernetes_io_region' },
        { alias: 'Zone', pattern: 'failure_domain_beta_kubernetes_io_zone' },
        {
          alias: 'Status',
          pattern: 'Value',
          colorMode: 'cell',
          colors: ['rgba(245, 54, 54, 0.9)', 'rgba(237, 129, 40, 0.89)', 'rgba(50, 172, 45, 0.97)'],
          thresholds: ['0', '1'],
          type: 'string',
          unit: 'short',
          valueMaps: [{ text: 'OK', value: '1' }, { text: 'Down', value: '0' }],
        },

        // Hide these columns
        { pattern: 'Time', type: 'hidden' },
        { pattern: '__name__', type: 'hidden' },
        { pattern: 'beta_kubernetes_io_arch', type: 'hidden' },
        { pattern: 'beta_kubernetes_io_fluentd_ds_ready', type: 'hidden' },
        { pattern: 'beta_kubernetes_io_os', type: 'hidden' },
        { pattern: 'cloud_google_com_gke_os_distribution', type: 'hidden' },
        { pattern: 'job', type: 'hidden' },
        { pattern: 'kubernetes_io_hostname', type: 'hidden' },
        { pattern: 'service', type: 'hidden' },
      ],
    )
    .addTarget(
      grafana.prometheus.target(
        'up{job="kubernetes-nodes"}',
        format='table',
        intervalFactor=1,
        instant=true,
        legendFormat='{{ beta_kubernetes_io_arch }}',
      )
    )
  )
)

// Cluster Health

.addRow(
  grafana.row.new(
    collapse=true,
    title='Cluster Health',
  )

  // Cluster Health Singlestat

  .addPanel(
    grafana.singlestat.new(
      'Cluster Pod Usage',
      datasource='$datasource',
      format='percent',
      gaugeShow=true,
      height=singlestatGuageHeight,
      span=3,
      thresholds='80,90',
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_info) / sum(kube_node_status_allocatable_pods) * 100',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Cluster CPU Usage',
      datasource='$datasource',
      format='percent',
      gaugeShow=true,
      height=singlestatGuageHeight,
      span=3,
      thresholds='80,90',
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_resource_requests_cpu_cores) / sum(kube_node_status_allocatable_cpu_cores) * 100',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Cluster Memory Usage',
      datasource='$datasource',
      format='percent',
      gaugeShow=true,
      height=singlestatGuageHeight,
      span=3,
      thresholds='80,90',
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_resource_requests_memory_bytes) / sum(kube_node_status_allocatable_memory_bytes) * 100',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Cluster Disk Usage',
      datasource='$datasource',
      format='percentunit',
      gaugeShow=true,
      height=singlestatGuageHeight,
      span=3,
      thresholds='80,90',
    )
    .addTarget(
      grafana.prometheus.target(
        '(sum (node_filesystem_size_bytes) - sum (node_filesystem_free_bytes)) / sum (node_filesystem_size_bytes)',
      )
    )
  )

  // Cluster Health Graphs

  .addPanel(
    grafana.graphPanel.new(
      'Cluster Pod Capacity',
      datasource='$datasource',
      span=3,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_status_allocatable_pods)',
        legendFormat='allocatable'
      )
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_status_capacity_pods)',
        legendFormat='capacity'
      )
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_info)',
        legendFormat='requested'
      )
    )
  )
  .addPanel(
    grafana.graphPanel.new(
      'Cluster CPU Capacity',
      datasource='$datasource',
      span=3,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_status_capacity_cpu_cores)',
        legendFormat='allocatable'
      )
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_status_allocatable_cpu_cores)',
        legendFormat='capacity'
      )
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_resource_requests_cpu_cores)',
        legendFormat='requested'
      )
    )
  )
  .addPanel(
    grafana.graphPanel.new(
      'Cluster Mem Capacity',
      datasource='$datasource',
      span=3,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_status_allocatable_memory_bytes)',
        legendFormat='allocatable'
      )
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_node_status_capacity_memory_bytes)',
        legendFormat='capacity'
      )
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_resource_requests_memory_bytes)',
        legendFormat='requested'
      )
    )
  )
  .addPanel(
    grafana.graphPanel.new(
      'Cluster Disk Capacity',
      datasource='$datasource',
      span=3,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(node_filesystem_size_bytes) - sum(node_filesystem_free_bytes)',
        legendFormat='usage'
      )
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(node_filesystem_size_bytes)',
        legendFormat='limit'
      )
    )
  )
)

// Deployments

.addRow(
  grafana.row.new(
    collapse=true,
    title='Deployments',
  )
  .addPanel(
    grafana.singlestat.new(
      'Deployment Replicas',
      datasource='$datasource',
      span=3,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_deployment_status_replicas)',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Deployment Replicas - Updated',
      datasource='$datasource',
      span=3,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_deployment_status_replicas_updated)',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Deployment Replicas - Unavailable',
      datasource='$datasource',
      span=3,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_deployment_status_replicas_unavailable)',
      )
    )
  )
  .addPanel(
    grafana.tablePanel.new(
      'Deployment Replicas - Up To Date',
      datasource='$datasource',
      span=3,
      styles=[
        { pattern: 'Time', type: 'hidden' },
      ],
    )
    .addTarget(
      grafana.prometheus.target(
        'kube_deployment_status_replicas',
        intervalFactor=1,
        instant=true,
        legendFormat='{{ deployment }}',
      )
    )
  )
)

// Pods

.addRow(
  grafana.row.new(
    collapse=true,
    title='Node',
  )
  .addPanel(
    grafana.singlestat.new(
      'Pods Running',
      datasource='$datasource',
      height=singlestatHeight,
      span=6,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_status_phase{phase="Running"})',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Pods Pending',
      datasource='$datasource',
      height=singlestatHeight,
      span=6,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_status_phase{phase="Pending"})',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Pods Failed',
      datasource='$datasource',
      height=singlestatHeight,
      span=4,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_status_phase{phase="Failed"})',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Pods Succeeded',
      datasource='$datasource',
      height=singlestatHeight,
      span=4,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_status_phase{phase="Succeeded"})',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Pods Unknown',
      datasource='$datasource',
      height=singlestatHeight,
      span=4,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_status_phase{phase="Unknown"})',
      )
    )
  )
)

// Containers

.addRow(
  grafana.row.new(
    collapse=true,
    title='Containers',
  )
  .addPanel(
    grafana.singlestat.new(
      'Containers Running',
      datasource='$datasource',
      height=singlestatHeight,
      span=3,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_status_running)',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Containers Waiting',
      datasource='$datasource',
      height=singlestatHeight,
      span=3,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_status_waiting)',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Containers Terminating',
      datasource='$datasource',
      height=singlestatHeight,
      span=3,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_status_terminated)',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Containers Restarts (Last 30 Minutes)',
      datasource='$datasource',
      height=singlestatHeight,
      span=3,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(delta(kube_pod_container_status_restarts_total{namespace!="kube-system"}[30m]))',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'CPU Cores Requested by Containers',
      datasource='$datasource',
      height=singlestatHeight,
      span=6,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_resource_requests_cpu_cores)',
      )
    )
  )
  .addPanel(
    grafana.singlestat.new(
      'Memory Requested By Containers',
      datasource='$datasource',
      format='decbytes',
      height=singlestatHeight,
      span=6,
      sparklineShow=true,
    )
    .addTarget(
      grafana.prometheus.target(
        'sum(kube_pod_container_resource_requests_memory_bytes)',
      )
    )
  )
  .addPanel(
    grafana.tablePanel.new(
      'Container Failed to Start',
      datasource='$datasource',
      span=12,
      styles=[

        {
          alias: 'Status',
          pattern: 'Value',
          colorMode: 'cell',
          colors: ['rgba(50, 172, 45, 0.97)', 'rgba(237, 129, 40, 0.89)', 'rgba(245, 54, 54, 0.9)'],
          thresholds: ['0', '1'],
          type: 'string',
          unit: 'short',
          valueMaps: [{ text: 'Error', value: '1' }],
        },

        // Hide these columns
        { pattern: 'Time', type: 'hidden' },
        { pattern: '__name__', type: 'hidden' },
        { pattern: 'app', type: 'hidden' },
        { pattern: 'chart', type: 'hidden' },
        { pattern: 'component', type: 'hidden' },
        { pattern: 'heritage', type: 'hidden' },
        { pattern: 'instance', type: 'hidden' },
        { pattern: 'job', type: 'hidden' },
        { pattern: 'kubernetes_name', type: 'hidden' },
        { pattern: 'kubernetes_namespace', type: 'hidden' },
        { pattern: 'release', type: 'hidden' },
      ],
    )
    .addTarget(
      grafana.prometheus.target(
        'kube_pod_container_status_waiting_reason{reason!="ContainerCreating"} > 0',
        format='table',
        intervalFactor=1,
        instant=true,
      )
    )
  )
)
