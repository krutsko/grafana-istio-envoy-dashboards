local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

{
  envoy_listener_manager_lds_config_reload:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_lds_config_reload{
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

  envoy_listener_manager_lds_config_reload_time_ms:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_lds_config_reload_time_ms{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_lds_init_fetch_timeout:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_lds_init_fetch_timeout{
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

  envoy_listener_manager_lds_update_attempt:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_lds_update_attempt{
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

  envoy_listener_manager_lds_update_success:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_lds_update_success{
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

  envoy_listener_manager_lds_update_failure:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_lds_update_failure{
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

  envoy_listener_manager_lds_update_rejected:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_listener_manager_lds_update_rejected{
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

  envoy_listener_manager_lds_update_time:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_lds_update_time{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_listener_manager_lds_version:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_lds_version{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_control_plane_connected_state:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_control_plane_connected_state{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_control_plane_rate_limit_enforced:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (
          rate(
            envoy_control_plane_rate_limit_enforced{
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

  envoy_control_plane_pending_requests:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_control_plane_pending_requests{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||)
} 