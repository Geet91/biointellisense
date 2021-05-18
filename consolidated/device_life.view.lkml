view: device_life {
  sql_table_name: `biointellisense-prod.user_data_combined.DeviceLife`
    ;;

  dimension: voltage {
    type: number
    sql: ${TABLE}.average_voltage ;;
  }

  dimension: voltage_tier {
    type: tier
    style: integer
    tiers: [2600, 2650, 2700, 2750, 2800, 2850, 2900, 2950, 3000]
    sql:  ${voltage} ;;
  }

  dimension: days_remaining {
    type: number
    sql: ${TABLE}.days_remaining ;;
  }

  dimension: days_remaining_tier {
    type: tier
    style: integer
    tiers: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
    sql: ${days_remaining} ;;
  }

  dimension: firmware_version {
    type: string
    sql: ${TABLE}.firmware_version ;;
  }

  dimension: days_elapsed {
    type: number
    sql: ${device_lifespan} - ${days_remaining} ;;
  }

  dimension: days_elapsed_tier {
    type: tier
    tiers: [0, 5, 10, 15, 20, 25, 30]
    style: integer
    sql: ${days_elapsed} ;;
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

  dimension: voltage_drop {
    type:  number
    sql: ${TABLE}.voltage_drop ;;
  }

  dimension: voltage_drop_tier {
    type: tier
    style: integer
    tiers: [-10, -5, 0, 5, 10, 15, 20]
    sql: ${TABLE}.voltage_drop ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: average_voltage {
    type: average
    sql: ${voltage} ;;
  }
}
