view: cloud_observed_sync_gaps {
  sql_table_name: `biointellisense-prod.user_data_combined.CloudObservedSyncGaps`
    ;;

  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.app_version ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_time ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }

  dimension: file_count {
    type: number
    sql: ${TABLE}.file_count ;;
  }

  dimension: firmware_version {
    type: string
    sql: ${TABLE}.firmware_version ;;
  }

  dimension_group: last_sync_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_sync_end_time ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  dimension_group: duration {
    type: duration
    sql_start: ${start_raw} ;;
    sql_end: ${end_raw} ;;
    intervals: [
      hour,
      minute,
      second
    ]
  }

  dimension: sync_gap_seconds {
    type: number
    sql: ${TABLE}.sync_gap_seconds ;;
  }

  dimension: sync_id {
    type: number
    sql: ${TABLE}.sync_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [
      environment,
      user_id,
      offloader_user_id,
      firmware_version,
      sync_gap_minutes,
      last_sync_end_time,
      start_time,
      offloader_cell_signal.average_cell_signal,
      offloader_boot_events.count,
      offloader_modem_timeouts.count]
  }

  dimension: sync_gap_minutes {
    type: number
    sql: ROUND(${TABLE}.sync_gap_seconds/60);;
  }

  dimension: sync_gap_minutes_tier {
    type: tier
    tiers: [0, 10, 15, 20, 25, 30, 35, 40, 50, 60]
    style: integer
    sql: ${sync_gap_minutes} ;;
  }

  dimension: sync_duration_seconds_tier {
    type:  tier
    tiers: [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30]
    style:  integer
    sql: ${seconds_duration} ;;
  }

  dimension: display_user_id {
    type: string
    sql: CONCAT(LEFT(${environment}, 1), ${user_id}) ;;
  }

  dimension: offloader_user_id {
    type: string
    sql: ${TABLE}.offloader_user_id ;;
  }

  measure: percent_of_total {
    type: percent_of_total
    drill_fields: []
  }

  measure: running_total_count {
    type: running_total
    sql: ${count} ;;
  }

  measure: last_sync_time {
    type: date_time
    sql: MAX(${TABLE}.end_time) ;;
  }
}
