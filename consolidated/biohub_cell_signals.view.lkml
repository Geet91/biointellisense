view: biohub_cell_signals {
  sql_table_name: `biointellisense-prod.user_data_combined.BiohubCellSignals`
    ;;

  dimension: cell_signal {
    type: number
    sql: ${TABLE}.cell_signal ;;
  }

  dimension: device_id {
    type: string
    sql: ${TABLE}.device_id ;;
  }

  dimension_group: entry_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.entry_timestamp ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }

  dimension: firmware_version {
    type: string
    sql: ${TABLE}.firmware_version ;;
  }

  dimension_group: partition {
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
    sql: ${TABLE}.partition_time ;;
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

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: display_user_id {
    type: string
    sql:concat(left(${TABLE}.environment, 1), ${TABLE}.user_id) ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: average_cell_signal {
    type: average
    sql: ${cell_signal} ;;
    drill_fields: [entry_timestamp_time, cell_signal]
  }

  measure: min_cell_signal {
    type: min
    sql: ${cell_signal} ;;
  }

  measure: 25p_cell_signal {
    type: percentile
    percentile: 25
    sql: ${cell_signal} ;;
  }

  measure: median_cell_signal {
    type: median
    sql: ${cell_signal} ;;
  }

  measure: 75p_cell_signal {
    type: percentile
    percentile: 75
    sql: ${cell_signal} ;;
  }

  measure: max_cell_signal {
    type: max
    sql: ${cell_signal} ;;
  }
}
