view: raw_voltage {
  sql_table_name: `biointellisense-prod.user_data.RawVoltage`
    ;;

  dimension: device_id {
    type: string
    sql: ${TABLE}.device_id ;;
  }

  dimension_group: entry_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      hour6,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.entry_timestamp ;;
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

  dimension: raw_voltage {
    type: number
    sql: ${TABLE}.rawVoltage ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: average_voltage {
    type: average
    sql: ${raw_voltage} ;;
  }
}
