view: device_lifespan_summary {
  derived_table: {
    sql:
    SELECT
      user_id,
      ANY_VALUE(device_type) as device_type,
      MIN(processing_time) as first_sync_time,
      MAX(processing_time) as last_sync_time
    FROM (
    SELECT
      user_id,
      processing_time,
      CASE
        WHEN STARTS_WITH(device_id, "P") THEN "biobutton"
        WHEN STARTS_WITH(device_id, "M") THEN "biosticker"
        WHEN STARTS_WITH(device_id, "N") THEN "biohub"
        WHEN device_id = "biomobile" THEN "biomobile"
      ELSE
        "unknown"
      END as device_type
    FROM `biointellisense-prod.user_data.ParsedGenericFiles`)
    WHERE
      device_type != "unknown"
    GROUP BY user_id;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension_group: first_sync {
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
    sql: ${TABLE}.first_sync_time ;;
  }

  dimension_group: last_sync {
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
    sql: ${TABLE}.last_sync_time ;;
  }

  dimension: lifespan_days {
    type: number
    sql: TIMESTAMP_DIFF(${last_sync_raw}, ${first_sync_raw}, DAY) ;;
  }

  measure: min_lifespan_days {
    type: min
    sql: ${lifespan_days} ;;
  }

  measure: 1q_lifespan_days {
    type: percentile
    percentile: 25
    sql: ${lifespan_days} ;;
  }
  measure: median_lifespan_days {
    type: median
    sql: ${lifespan_days} ;;
  }
  measure: 3q_lifespan_days {
    type: percentile
    percentile: 75
    sql: ${lifespan_days} ;;
  }
  measure: max_lifespan_days {
    type: max
    sql: ${lifespan_days} ;;
  }
}
