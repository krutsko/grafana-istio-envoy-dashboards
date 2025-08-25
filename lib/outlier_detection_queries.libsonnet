local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

{
  // Outlier Detection Overview
  envoy_cluster_outlier_detection_ejections_enforced_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_total{
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

  // Overview queries - all clusters, filtered only by pod
  outlier_detection_ejections_enforced_total_overview:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_total{
                    namespace=~"$Namespace"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_outlier_detection_ejections_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            envoy_cluster_outlier_detection_ejections_active{
                namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  outlier_detection_ejections_active_overview:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            envoy_cluster_outlier_detection_ejections_active{
                namespace=~"$Namespace"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_outlier_detection_ejections_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_overflow{
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

  // Consecutive 5xx Ejections
  envoy_cluster_outlier_detection_ejections_enforced_consecutive_5xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_consecutive_5xx{
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

  envoy_cluster_outlier_detection_ejections_detected_consecutive_5xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_detected_consecutive_5xx{
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

  // Success Rate Ejections
  envoy_cluster_outlier_detection_ejections_enforced_success_rate:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_success_rate{
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

  envoy_cluster_outlier_detection_ejections_detected_success_rate:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_detected_success_rate{
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

  // Gateway Failure Ejections
  envoy_cluster_outlier_detection_ejections_enforced_consecutive_gateway_failure:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_consecutive_gateway_failure{
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

  envoy_cluster_outlier_detection_ejections_detected_consecutive_gateway_failure:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_detected_consecutive_gateway_failure{
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

  // Local Origin Failure Ejections
  envoy_cluster_outlier_detection_ejections_enforced_consecutive_local_origin_failure:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_consecutive_local_origin_failure{
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

  envoy_cluster_outlier_detection_ejections_detected_consecutive_local_origin_failure:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_detected_consecutive_local_origin_failure{
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

  // Local Origin Success Rate Ejections
  envoy_cluster_outlier_detection_ejections_enforced_local_origin_success_rate:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_local_origin_success_rate{
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

  envoy_cluster_outlier_detection_ejections_detected_local_origin_success_rate:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_detected_local_origin_success_rate{
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

  // Failure Percentage Ejections
  envoy_cluster_outlier_detection_ejections_enforced_failure_percentage:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_failure_percentage{
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

  envoy_cluster_outlier_detection_ejections_detected_failure_percentage:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_detected_failure_percentage{
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

  // Local Origin Failure Percentage Ejections
  envoy_cluster_outlier_detection_ejections_enforced_failure_percentage_local_origin:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_enforced_failure_percentage_local_origin{
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

  envoy_cluster_outlier_detection_ejections_detected_failure_percentage_local_origin:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_detected_failure_percentage_local_origin{
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

  // Deprecated metrics (for reference)
  envoy_cluster_outlier_detection_ejections_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_total{
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

  envoy_cluster_outlier_detection_ejections_consecutive_5xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_outlier_detection_ejections_consecutive_5xx{
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
} 
