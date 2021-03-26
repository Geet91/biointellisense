view: device_lifespan_summary {
  derived_table: {
    sql: SELECT user_id, min(processing_time) as first_sync_time, max(processing_time) as last_sync_time from `biointellisense-prod.user_data.ParsedGenericFiles` group by user_id
      ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
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
}
