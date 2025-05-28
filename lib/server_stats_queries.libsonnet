local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

{
  envoy_server_uptime:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_server_uptime{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),    

  envoy_server_memory_allocated:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_server_memory_allocated{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),    

  envoy_server_memory_heap_size:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_server_memory_heap_size{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),   

  envoy_server_concurrency:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_server_concurrency{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_server_memory_physical_size:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_server_memory_physical_size{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_server_live:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_server_live{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_server_parent_connections:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_server_parent_connections{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_server_total_connections:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_server_total_connections{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_server_debug_assertion_failures:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
            rate(
                envoy_server_debug_assertion_failures{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_server_envoy_bug_failures:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
            rate(
                envoy_server_envoy_bug_failures{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_server_static_unknown_fields:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
            rate(
                envoy_server_static_unknown_fields{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_server_dynamic_unknown_fields:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
            rate(
                envoy_server_dynamic_unknown_fields{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),
} 