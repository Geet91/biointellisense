view: device_days {
  sql_table_name: `biointellisense-prod.user_data_combined.DeviceDays`
    ;;

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }

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

  dimension: firmware_version {
    type: string
    sql: ${TABLE}.firmware_version ;;
  }

  dimension: offloader_user_id {
    type: string
    sql: ${TABLE}.offloader_user_id ;;
  }

  dimension_group: processing {
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
    sql: ${TABLE}.processing_date ;;
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
