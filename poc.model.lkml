connection: "production_bigquery"

#include: "views/*.view.lkml"                # include all views in the views/ folder in this project
 include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: sync_gaps {
  join: raw_voltage {
    type: left_outer
    relationship: one_to_many
    sql_on: ${sync_gaps.user_id} = ${raw_voltage.user_id} and ${raw_voltage.processing_raw} between ${sync_gaps.start_raw} and ${sync_gaps.end_raw} ;;
  }
}

explore: consolidated_parsed_generic_files {}

explore: uat {
  join: message_logs {
    type: left_outer
    relationship: one_to_many
    sql_on: ${uat.bio_id} = ${message_logs.user_id} ;;
  }
}

explore: consolidated_message_logs {}

explore: biohub_modem_sessions {
  join: biohub_cell_signals {
    type: left_outer
    relationship: one_to_many
    sql_on: ${biohub_modem_sessions.environment} = ${biohub_cell_signals.environment} and ${biohub_modem_sessions.user_id} = ${biohub_cell_signals.user_id} and ${biohub_cell_signals.entry_timestamp_raw} between ${biohub_modem_sessions.start_raw} and ${biohub_modem_sessions.end_raw};;
  }
}

explore: biohub_cell_signals {}

explore: cloud_observed_sync_gaps {
  # join: offloader_boot_events {
  #   from: boot_events
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${cloud_observed_sync_gaps.environment} = ${offloader_boot_events.environment} and ${cloud_observed_sync_gaps.offloader_user_id} = ${offloader_boot_events.user_id} and ${offloader_boot_events.entry_timestamp_raw} between ${cloud_observed_sync_gaps.last_sync_end_raw} and ${cloud_observed_sync_gaps.start_raw};;
  # }

  # join: offloader_modem_timeouts {
  #   from: biohub_modem_timeouts
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${cloud_observed_sync_gaps.environment} = ${offloader_modem_timeouts.environment} and ${cloud_observed_sync_gaps.offloader_user_id} = ${offloader_modem_timeouts.user_id} and ${offloader_boot_events.entry_timestamp_raw} between ${cloud_observed_sync_gaps.last_sync_end_raw} and ${cloud_observed_sync_gaps.start_raw} ;;
  # }

  join: offloader_cell_signal {
    from: biohub_cell_signals
    type: left_outer
    relationship: one_to_many
    fields: [
        entry_timestamp_time,
        cell_signal,
        average_cell_signal,
        min_cell_signal,
        25p_cell_signal,
        median_cell_signal,
        75p_cell_signal,
        max_cell_signal
      ]
    sql_on: ${cloud_observed_sync_gaps.environment} = ${offloader_cell_signal.environment} and ${cloud_observed_sync_gaps.offloader_user_id} = ${offloader_cell_signal.user_id} and ${offloader_cell_signal.entry_timestamp_raw} between timestamp_sub(${cloud_observed_sync_gaps.last_sync_end_raw}, interval 5 minute) and timestamp_add(${cloud_observed_sync_gaps.start_raw}, interval 5 minute) ;;
  }
}

explore: boot_events {}

explore: device_life {}
