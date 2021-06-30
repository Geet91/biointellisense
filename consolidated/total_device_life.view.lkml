view: total_device_life {
  sql_table_name: `biointellisense-prod.user_data_combined.TotalDeviceLife`
    ;;

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.end_date ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }

  dimension: final_voltage {
    type: number
    sql: ${TABLE}.final_voltage ;;
  }

  dimension: initial_voltage {
    type: number
    sql: ${TABLE}.initial_voltage ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_date ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: lifespan {
    type: duration
    intervals: [
      day,
      week,
      month
    ]
    sql_start: ${start_raw} ;;
    sql_end: ${end_raw} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: voltage_drop {
    type: average
    sql: ${initial_voltage} - ${final_voltage} ;;
    drill_fields: [device_type, start_date, initial_voltage, end_date, final_voltage]
  }
}
