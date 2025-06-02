local g = import 'lib/g.libsonnet';

local row = g.panel.row;

local panels = import 'lib/panels.libsonnet';
local variables = import 'lib/variables.libsonnet';
local queries = import 'lib/queries.libsonnet';
local server_stats_queries = import 'lib/server_stats_queries.libsonnet';
local envoy_cluster_upstream_queries = import 'lib/envoy_cluster_upstream_queries.libsonnet';
local listener_stats_queries = import 'lib/listener_stats_queries.libsonnet';
local listener_manager_queries = import 'lib/listener_manager_queries.libsonnet';
local lds_stats_queries = import 'lib/lds_stats_queries.libsonnet';

// Create base dashboard first
local baseDashboard = g.dashboard.new('Istio Envoy Clusters')
+ g.dashboard.withDescription(|||
  Dashboard showing Istio Envoy Clusters
|||)
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.withVariables([
  // Fixed datasource variable for external sharing
  {
    name: 'datasource',
    type: 'datasource',
    query: 'prometheus',
    current: {
      selected: false,
      text: 'Prometheus',
      value: 'Prometheus'
    },
    hide: 0,
    includeAll: false,
    multi: false,
    options: [],
    refresh: 1,
    regex: '',
    skipUrlSync: false,
    label: 'Data Source'
  },
  {
    name: 'clusterNameLabel',
    type: 'custom',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: 'cluster_name',
    query: 'cluster_name',
    hide: 2,
    options: [
      {
        selected: true,
        text: 'cluster_name',
        value: 'cluster_name'
      }
    ],
    current: {
      selected: false,
      text: 'cluster_name',
      value: 'cluster_name'
    },
    regex: '',
    skipUrlSync: false,
    multi: false,
    includeAll: false,
    allValue: '.*',
    refresh: 1,
    sort: 0
  },
  {
    name: 'Namespace',
    type: 'query',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: 'label_values(envoy_cluster_upstream_rq_total,namespace)',
    query: 'label_values(envoy_cluster_upstream_rq_total,namespace)',
    hide: 0,
    options: [],
    regex: '',
    skipUrlSync: false,
    multi: false,
    includeAll: false,
    allValue: '.*',
    refresh: 1,
    sort: 0
  },
  {
    name: 'app',
    type: 'query',
    allowCustomValue: true,
    datasource: {
      type: 'prometheus',
      uid: '$datasource'
    },
    definition: 'query_result(sum({namespace="$Namespace",__name__="envoy_server_version"}) by (pod))',
    query: {
      qryType: 3,
      query: 'query_result(sum({namespace="$Namespace",__name__="envoy_server_version"}) by (pod))',
      refId: 'PrometheusVariableQueryEditor-VariableQuery'
    },
    regex: '/^{pod="([^-"]+).*$/',
    includeAll: false,
    options: [],
    refresh: 1,
    sort: 1,
    allValue: '.*',
  },   
  {
    name: 'pod',
    type: 'query',
    datasource: {
      type: 'prometheus',
      uid: '$datasource'
    },
    definition: 'query_result(sum({namespace="$Namespace",__name__="envoy_server_version", pod=~"$app-.*"}) by (pod))',
    query: {
      qryType: 3,
      query: 'query_result(sum({namespace="$Namespace",__name__="envoy_server_version", pod=~"$app-.*"}) by (pod))',
      refId: 'PrometheusVariablePod'
    },
    regex: '/pod="([^"]+)"/',
    multi: true,
    includeAll: false,
    refresh: 2,
    sort: 1,
    options: [],
    allValue: '.*',
  },
  {
    name: 'cluster',
    type: 'query',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: 'query_result(sum({namespace="$Namespace",__name__="envoy_cluster_upstream_rq_total", pod=~"$app-.*"}) by ($clusterNameLabel))',
    query: {
      qryType: 3,
      query: 'query_result(sum({namespace="$Namespace",__name__="envoy_cluster_upstream_rq_total", pod=~"$app-.*"}) by ($clusterNameLabel))',
      refId: 'PrometheusVariableQueryEditor-VariableQuery'
    },
    hide: 0,
    options: [],
    regex: '/^{.*="(.*)"}/',
    skipUrlSync: false,
    multi: false,
    includeAll: false,
    allValue: '.*',
    refresh: 1,
    sort: 0
  },   
  {
    name: 'quantiles',
    type: 'custom',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: '0.9',
    query: '0.9',
    hide: 2,
    options: [
      {
        selected: true,
        text: '0.9',
        value: '0.9'
      }
    ],
    current: {
      selected: false,
      text: '0.9',
      value: '0.9'
    },
    regex: '',
    skipUrlSync: false,
    multi: false,
    includeAll: false,
    allValue: '.*',
    refresh: 1,
    sort: 0
  }
])
+ g.dashboard.withPanels(
  g.util.grid.makeGrid([
    row.new('Server Stats')
    + row.withCollapsed(false)    
    + row.withPanels([
        panels.stat.uptime('Uptime', server_stats_queries.envoy_server_uptime),
        panels.stat.serverLive('Server Live', server_stats_queries.envoy_server_live),
        panels.timeSeries.short('Worker Threads', server_stats_queries.envoy_server_concurrency),
        panels.timeSeries.memoryUsage('Memory Allocated', server_stats_queries.envoy_server_memory_allocated),
        panels.timeSeries.memoryUsage('Memory Heap Size', server_stats_queries.envoy_server_memory_heap_size),
        panels.timeSeries.memoryUsage('Memory Physical Size', server_stats_queries.envoy_server_memory_physical_size),
        panels.timeSeries.short('Total Connections', server_stats_queries.envoy_server_total_connections),
    ]),
    row.new('Cluster manager')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.timeSeries.short('Active clusters', queries.envoy_cluster_manager_active_clusters),
        panels.timeSeries.short('Warming clusters', queries.envoy_cluster_manager_warming_clusters),
        panels.timeSeries.rate('Total clusters added', queries.envoy_cluster_manager_cluster_added),
        panels.timeSeries.rate('Total clusters modified', queries.envoy_cluster_manager_cluster_modified),
        panels.timeSeries.rate('Total clusters removed', queries.envoy_cluster_manager_cluster_removed),
        panels.timeSeries.rate('Total cluster updates', queries.envoy_cluster_manager_cluster_updated),
        panels.timeSeries.rate('Total cluster updates via merge', queries.envoy_cluster_manager_cluster_updated_via_merge),
        panels.timeSeries.rate('Total merged updates cancelled', queries.envoy_cluster_manager_update_merge_cancelled),
        panels.timeSeries.rate('Total updates out of merge window', queries.envoy_cluster_manager_update_out_of_merge_window),
    ]),            
    row.new('Cluster Stats')
    + row.withCollapsed(true)
    + row.withPanels([
        panels.timeSeries.rate('Total requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_total),
        panels.timeSeries.short('Active requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_active),
        panels.timeSeries.rate('Pending total requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_pending_total),
        panels.timeSeries.rate('Pending overflow requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_pending_overflow),
        panels.timeSeries.rate('Pending failure eject requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_pending_failure_eject),
        panels.timeSeries.short('Pending active requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_pending_active),
        panels.timeSeries.rate('Cancelled requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_cancelled),
        panels.timeSeries.rate('Maintenance mode requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_maintenance_mode),
        panels.timeSeries.rate('Timeout requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_timeout),
        panels.timeSeries.rate('Max duration reached requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_max_duration_reached),
        panels.timeSeries.rate('Per try timeout requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_per_try_timeout),
        panels.timeSeries.rate('RX reset requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_rx_reset),
        panels.timeSeries.rate('TX reset requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_tx_reset),
        panels.timeSeries.rate('Retry requests', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_retry),
        panels.timeSeries.rate('Retry backoff exponential', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_retry_backoff_exponential),
        panels.timeSeries.rate('Retry backoff ratelimited', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_retry_backoff_ratelimited),
        panels.timeSeries.rate('Retry limit exceeded', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_retry_limit_exceeded),
        panels.timeSeries.rate('Retry success', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_retry_success),
        panels.timeSeries.rate('Retry overflow', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_retry_overflow),
    ]),     
    row.new('HTTP Metrics By Cluster')
    + row.withCollapsed(true)
    + row.withPanels([
        panels.timeSeries.rate('Upstream Requests by Response Code Class', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_by_code),
        panels.timeSeries.rate('Upstream Requests by Response Code', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_by_response_code),
        panels.timeSeries.rate('5xx Errors by Response Code', envoy_cluster_upstream_queries.envoy_cluster_upstream_rq_5xx),
    ]),
    row.new('Cluster Connection Stats')
    + row.withCollapsed(true)
    + row.withPanels([
        panels.timeSeries.rate('Total connections', queries.envoy_cluster_upstream_cx_total),
        panels.timeSeries.short('Active connections', queries.envoy_cluster_upstream_cx_active),
        panels.timeSeries.rate('HTTP/1.1 connections', queries.envoy_cluster_upstream_cx_http1_total),
        panels.timeSeries.rate('HTTP/2 connections', queries.envoy_cluster_upstream_cx_http2_total),
        panels.timeSeries.rate('HTTP/3 connections', queries.envoy_cluster_upstream_cx_http3_total),
        
        panels.timeSeries.rate('Connection failures', queries.envoy_cluster_upstream_cx_connect_fail),
        panels.timeSeries.rate('Connection timeouts', queries.envoy_cluster_upstream_cx_connect_timeout),
        panels.timeSeries.rate('0-RTT connections', queries.envoy_cluster_upstream_cx_connect_with_0_rtt),
        panels.timeSeries.rate('Idle timeouts', queries.envoy_cluster_upstream_cx_idle_timeout),
        panels.timeSeries.rate('Connection attempts exceeded', queries.envoy_cluster_upstream_cx_connect_attempts_exceeded),
        panels.timeSeries.rate('Max duration reached', queries.envoy_cluster_upstream_cx_max_duration_reached),
        
        panels.timeSeries.rate('Destroyed connections', queries.envoy_cluster_upstream_cx_destroy),
        panels.timeSeries.rate('Locally destroyed connections', queries.envoy_cluster_upstream_cx_destroy_local),
        panels.timeSeries.rate('Remotely destroyed connections', queries.envoy_cluster_upstream_cx_destroy_remote),
        panels.timeSeries.rate('Destroyed with active requests', queries.envoy_cluster_upstream_cx_destroy_with_active_rq),
        panels.timeSeries.rate('Locally destroyed with active requests', queries.envoy_cluster_upstream_cx_destroy_local_with_active_rq),
        panels.timeSeries.rate('Remotely destroyed with active requests', queries.envoy_cluster_upstream_cx_destroy_remote_with_active_rq),
        panels.timeSeries.rate('Close notify', queries.envoy_cluster_upstream_cx_close_notify),
        
        panels.timeSeries.rate('Connection overflow', queries.envoy_cluster_upstream_cx_overflow),
        panels.timeSeries.rate('Protocol errors', queries.envoy_cluster_upstream_cx_protocol_error),
        panels.timeSeries.rate('Max requests reached', queries.envoy_cluster_upstream_cx_max_requests),
        panels.timeSeries.rate('No healthy hosts', queries.envoy_cluster_upstream_cx_none_healthy),
        panels.timeSeries.rate('Connection pool overflow', queries.envoy_cluster_upstream_cx_pool_overflow),
        
        panels.timeSeries.rate('Received bytes', queries.envoy_cluster_upstream_cx_rx_bytes_total),
        panels.timeSeries.short('Received bytes buffered', queries.envoy_cluster_upstream_cx_rx_bytes_buffered),
        panels.timeSeries.rate('Transmitted bytes', queries.envoy_cluster_upstream_cx_tx_bytes_total),
        panels.timeSeries.short('Transmitted bytes buffered', queries.envoy_cluster_upstream_cx_tx_bytes_buffered),
        
        panels.timeSeries.durationQuantileMs('Connection establishment time (p90)', queries.envoy_cluster_upstream_cx_connect_ms),
        panels.timeSeries.durationQuantileMs('Connection lifetime (p90)', queries.envoy_cluster_upstream_cx_length_ms),
    ])       
  ], panelWidth=8)
)
+ g.dashboard.withUid('')  // Empty UID for sharing
+ g.dashboard.time.withFrom('now-1h')
+ g.dashboard.time.withTo('now')
+ g.dashboard.timepicker.withRefreshIntervals([
  '5s',
  '10s', 
  '30s',
  '1m',
  '5m',
  '15m',
  '30m',
  '1h',
  '2h',
  '1d'
]);

// Simply add the required external sharing fields
baseDashboard + {
  // Required for grafana.com uploads
  '__inputs': [
    {
      name: 'DS_PROMETHEUS',
      label: 'Prometheus',
      description: '',
      type: 'datasource',
      pluginId: 'prometheus',
      pluginName: 'Prometheus'
    }
  ],
  '__elements': {},
  '__requires': [
    {
      type: 'grafana',
      id: 'grafana',
      name: 'Grafana',
      version: '11.4.0'
    },
    {
      type: 'datasource',
      id: 'prometheus', 
      name: 'Prometheus',
      version: '1.0.0'
    },
    {
      type: 'panel',
      id: 'stat',
      name: 'Stat',
      version: ''
    },
    {
      type: 'panel',
      id: 'timeseries',
      name: 'Time series', 
      version: ''
    }
  ],
  // Reset for sharing
  id: null,
  uid: '',
  version: 0
}