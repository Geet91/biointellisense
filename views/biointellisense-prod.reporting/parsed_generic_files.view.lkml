view: parsed_generic_files {
  sql_table_name: `biointellisense-prod.user_data.ParsedGenericFiles`
    ;;

  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.app_version ;;
  }

  dimension: battery_percentage {
    type: number
    sql: ${TABLE}.battery_percentage ;;
  }

  dimension: device_id {
    type: string
    sql: ${TABLE}.device_id ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: downloaded_crc {
    type: number
    sql: ${TABLE}.downloaded_crc ;;
  }

  dimension: expected_crc {
    type: number
    sql: ${TABLE}.expected_crc ;;
  }

  dimension: file_type {
    type: string
    sql: ${TABLE}.file_type ;;
  }

  dimension: filename {
    type: string
    sql: ${TABLE}.filename ;;
  }

  dimension: firmware_version {
    type: string
    sql: ${TABLE}.firmware_version ;;
  }

  dimension: invalid_timestamp {
    type: yesno
    sql: ${TABLE}.invalid_timestamp ;;
  }

  dimension: manufacturer_id {
    type: string
    sql: ${TABLE}.manufacturer_id ;;
  }

  dimension: offloader_device_id {
    type: string
    sql: ${TABLE}.offloader_device_id ;;
  }

  dimension: offloader_user_id {
    type: string
    sql: ${TABLE}.offloader_user_id ;;
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

  dimension_group: sync_timestamp {
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
    sql: ${TABLE}.sync_timestamp ;;
  }

  dimension: time_drift_offset {
    type: number
    sql: ${TABLE}.time_drift_offset ;;
  }

  dimension: time_drift_to_apply {
    type: number
    sql: ${TABLE}.time_drift_to_apply ;;
  }

  dimension: trial_number {
    type: number
    sql: ${TABLE}.trial_number ;;
  }

  dimension_group: uploaded_timestamp {
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
    sql: ${TABLE}.uploaded_timestamp ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: utc_offset {
    type: number
    sql: ${TABLE}.utc_offset ;;
  }

  dimension: vendor_id {
    type: string
    sql: ${TABLE}.vendor_id ;;
  }

  measure: count {
    type: count
    drill_fields: [filename]
  }

  measure: first_sync {
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
    sql: MIN(${processing_raw}) ;;
  }

  measure: last_sync {
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
    sql: MAX(${processing_raw}) ;;
  }

  measure: is_alive {
    type: yesno
    sql: TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), MAX(${processing_raw}), DAY) > 1 ;;
  }

  measure: lifespan {
    type: number
    sql: TIMESTAMP_DIFF(MAX(${processing_raw}), MIN(${processing_raw}), DAY) ;;
  }
}
