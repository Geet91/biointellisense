view: biohub_modem_sessions {
  sql_table_name: `biointellisense-prod.user_data_combined.BiohubModemSessions`
    ;;

  dimension: device_id {
    type: string
    sql: ${TABLE}.device_id ;;
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

  dimension: firmware_version {
    type: string
    sql: ${TABLE}.firmware_version ;;
  }

  dimension: session_id {
    type: number
    sql: ${TABLE}.session_id ;;
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

  dimension: status {
    type: string
    sql: CAST(${TABLE}.status as STRING) ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: display_user_id {
    type: string
    sql:concat(left(${TABLE}.environment, 1), ${TABLE}.user_id) ;;
  }

  dimension_group: duration {
    type: duration
    intervals: [
      day,
      hour,
      minute,
      second
    ]
    sql_start: ${start_raw} ;;
    sql_end: ${end_raw} ;;
  }

  dimension: duration_tier {
    type:  tier
    tiers: [0, 5, 10, 20, 30, 60, 120]
    style:  integer
    sql:  ${minutes_duration};;
  }

  measure: count {
    type: count
    drill_fields: [environment, user_id, start_time, end_time, status]
  }
}
