// Listener Manager queries for Envoy proxy metrics
// These queries track the state and operations of Envoy's listener manager

local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

local queries = {
  // Current state metrics
  state: {
    total_listeners_active: {
      expr: 'envoy_listener_manager_total_listeners_active{namespace="$Namespace", pod=~"$pod"}',
      legendFormat: '{{pod}}'
    },
    total_listeners_draining: {
      expr: 'envoy_listener_manager_total_listeners_draining{namespace="$Namespace", pod=~"$pod"}',
      legendFormat: '{{pod}}'
    },
    total_listeners_warming: {
      expr: 'envoy_listener_manager_total_listeners_warming{namespace="$Namespace", pod=~"$pod"}',
      legendFormat: '{{pod}}'
    },
    total_filter_chains_draining: {
      expr: 'envoy_listener_manager_total_filter_chains_draining{namespace="$Namespace", pod=~"$pod"}',
      legendFormat: '{{pod}}'
    },
    workers_started: {
      expr: 'envoy_listener_manager_workers_started{namespace="$Namespace", pod=~"$pod"}',
      legendFormat: '{{pod}}'
    }
  },

  // Listener lifecycle operations
  operations: {
    listener_added: {
      expr: 'rate(envoy_listener_manager_listener_added{namespace="$Namespace", pod=~"$pod"}[$__rate_interval])',
      legendFormat: '{{pod}}'
    },
    listener_create_failure: {
      expr: 'rate(envoy_listener_manager_listener_create_failure{namespace="$Namespace", pod=~"$pod"}[$__rate_interval])',
      legendFormat: '{{pod}}'
    },
    listener_create_success: {
      expr: 'rate(envoy_listener_manager_listener_create_success{namespace="$Namespace", pod=~"$pod"}[$__rate_interval])',
      legendFormat: '{{pod}}'
    },
    listener_in_place_updated: {
      expr: 'rate(envoy_listener_manager_listener_in_place_updated{namespace="$Namespace", pod=~"$pod"}[$__rate_interval])',
      legendFormat: '{{pod}}'
    },
    listener_modified: {
      expr: 'rate(envoy_listener_manager_listener_modified{namespace="$Namespace", pod=~"$pod"}[$__rate_interval])',
      legendFormat: '{{pod}}'
    },
    listener_removed: {
      expr: 'rate(envoy_listener_manager_listener_removed{namespace="$Namespace", pod=~"$pod"}[$__rate_interval])',
      legendFormat: '{{pod}}'
    },
    listener_stopped: {
      expr: 'rate(envoy_listener_manager_listener_stopped{namespace="$Namespace", pod=~"$pod"}[$__rate_interval])',
      legendFormat: '{{pod}}'
    }
  }
};

{
  envoy_listener_manager_total_listeners_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_total_listeners_active{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_total_listeners_draining:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_total_listeners_draining{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_total_listeners_warming:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_total_listeners_warming{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_total_filter_chains_draining:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_total_filter_chains_draining{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_workers_started:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_workers_started{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_listener_added:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_listener_added{
              namespace=~"$Namespace",
              pod=~"$pod"
            }
          [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_listener_create_failure:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_listener_create_failure{
              namespace=~"$Namespace",
              pod=~"$pod"
            }
          [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_listener_create_success:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_listener_create_success{
              namespace=~"$Namespace",
              pod=~"$pod"
            }
          [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_listener_in_place_updated:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_listener_in_place_updated{
              namespace=~"$Namespace",
              pod=~"$pod"
            }
          [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_listener_modified:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_listener_modified{
              namespace=~"$Namespace",
              pod=~"$pod"
            }
          [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_listener_removed:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_listener_removed{
              namespace=~"$Namespace",
              pod=~"$pod"
            }
          [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_listener_stopped:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_listener_stopped{
              namespace=~"$Namespace",
              pod=~"$pod"
            }
          [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||)
} 