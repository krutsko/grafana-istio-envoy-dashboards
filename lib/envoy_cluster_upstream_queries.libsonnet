local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

{

   envoy_cluster_upstream_rq_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_total{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||), 

  envoy_cluster_upstream_rq_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            envoy_cluster_upstream_rq_active{
                namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
            }
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_pending_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_pending_total{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_pending_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_pending_overflow{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_pending_failure_eject:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_pending_failure_eject{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_pending_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            envoy_cluster_upstream_rq_pending_active{
                namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
            }
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_cancelled:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_cancelled{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_maintenance_mode:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_maintenance_mode{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_timeout:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_timeout{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_max_duration_reached:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_max_duration_reached{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_per_try_timeout:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_per_try_timeout{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_rx_reset:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_rx_reset{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_tx_reset:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_tx_reset{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_retry:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_retry{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_retry_backoff_exponential:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_retry_backoff_exponential{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_retry_backoff_ratelimited:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_retry_backoff_ratelimited{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_retry_limit_exceeded:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_retry_limit_exceeded{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_retry_success:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_retry_success{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),
    
  envoy_cluster_upstream_rq_retry_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_rq_retry_overflow{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_rq_by_code:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel, response_code_class) (
            rate(
                envoy_cluster_upstream_rq{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}} {{response_code_class}}
    |||),

  envoy_cluster_upstream_rq_by_response_code:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel, response_code) (
            rate(
                envoy_cluster_upstream_rq{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}} {{response_code}}
    |||),

  envoy_cluster_upstream_rq_5xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel, response_code) (
            rate(
                envoy_cluster_upstream_rq{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster",
                    response_code=~"5.."
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}} {{response_code}}
    |||),
}

// vim: foldmethod=indent shiftwidth=2 foldlevel=1
