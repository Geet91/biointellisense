view: broken_temperature_sensor {
  sql_table_name: `biointellisense-prod.user_data_combined.BrokenTemperatureSensor`
    ;;

  dimension: broken_amb_flag {
    type: yesno
    sql: ${TABLE}.broken_amb_flag ;;
  }

  dimension: broken_skin_flag {
    type: yesno
    sql: ${TABLE}.broken_skin_flag ;;
  }

  dimension: device_id {
    type: string
    sql: ${TABLE}.device_id ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}
