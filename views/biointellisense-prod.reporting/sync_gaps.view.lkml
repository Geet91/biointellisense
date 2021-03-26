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

  dimension: sync_history_order_key {
    type:  string
    sql: CONCAT(${user_id}, ${start_raw}) ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";"
    drill_fields: []
  }

  dimension: sync_gap_minutes_tier {
    type:  tier
    tiers: [0, 10, 30, 60, 120, 240, 480, 1000]
    style:  integer
    sql:  ${sync_gap_minutes};;
  }

  measure: percent_of_total_count {
    type:  percent_of_total
    sql:  ${count} ;;
  }

  measure: total_files {
    type:  sum
    sql:  ${file_count} ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";"
  }

  measure: first_sync_date {
    type: date
    sql:  MIN(${start_raw}) ;;
  }

  measure: last_sync_date {
    type:  date
    sql:  MAX(${end_raw}) ;;
  }

  measure: unique_bio_ids {
    type:  count_distinct
    sql:  ${user_id} ;;
  }

  measure: lifespan_days {
    type: number
    sql: DATE_DIFF(${last_sync_date}, ${first_sync_date}) ;;
  }
}
