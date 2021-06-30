view: consolidated_unified_binary_entries {
  sql_table_name: `biointellisense-prod.user_data_combined.UnifiedBinaryEntries`
    ;;

  dimension: device_id {
    type: string
    sql: ${TABLE}.device_id ;;
  }

  dimension: entry_type {
    type: string
    sql: ${TABLE}.entry_type ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }

  dimension: firmware_version {
    type: string
    sql: ${TABLE}.firmware_version ;;
  }

  dimension_group: processing {
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
    sql: ${TABLE}.processing_time ;;
  }

  dimension_group: sync_timestamp {
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
    sql: ${TABLE}.sync_timestamp ;;
  }

  dimension: time_drift_offset {
    type: number
    sql: ${TABLE}.time_drift_offset ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.timestamp ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: device_type {
    type: string
    sql: CASE
        WHEN STARTS_WITH(${device_id}, "P") THEN "biobutton"
        WHEN STARTS_WITH(${device_id}, "M") THEN "biosticker"
        WHEN STARTS_WITH(${device_id}, "N") THEN "biohub"
        WHEN ${device_id} = "biomobile" THEN "biomobile"
      ELSE
      "unknown"
    END ;;
  }

  dimension_group: system_lag {
    type: duration
    intervals: [
      hour,
      minute,
      second
    ]
    sql_start: ${timestamp_raw} ;;
    sql_end: ${processing_raw} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: avg_system_lag_minutes {
    type: average
    sql: ${minutes_system_lag} ;;
  }
}
