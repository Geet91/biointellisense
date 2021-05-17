view: device_life {
  sql_table_name: `biointellisense-prod.user_data_combined.DeviceLife`
    ;;

  dimension: average_voltage {
    type: number
    sql: ${TABLE}.average_voltage ;;
  }

  dimension: voltage_tier {
    type: tier
    tiers: [3000, 2950, 2900, 2850, 2800, 2750, 2700, 2650, 2600]
  }

  dimension: days_remaining {
    type: number
    sql: ${TABLE}.days_remaining ;;
  }

  dimension: device_lifespan {
    type: number
    sql: ${TABLE}.device_lifespan ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension_group: end_of_device_life {
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
    sql: ${TABLE}.end_of_device_life ;;
  }

  dimension_group: entry {
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
    sql: ${TABLE}.entry_date ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
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
