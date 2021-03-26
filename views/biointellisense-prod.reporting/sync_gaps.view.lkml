view: sync_gaps {
  sql_table_name: `biointellisense-prod.reporting.sync_gaps`
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

  dimension: sync_gap_seconds {
    type: number
    sql: ${TABLE}.sync_gap_seconds ;;
  }

  dimension: sync_gap_minutes {
    type:  number
    sql:  ${sync_gap_seconds}/60 ;;
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
    drill_fields: []
  }

  measure: sync_gap_length {
    type:  average
    sql:  ${sync_gap_minutes} ;;
  }

  measure: sync_file_count {
    type:  average
    sql:  ${file_count} ;;
  }
}
