view: offloaded_files {
  sql_table_name: `biointellisense-prod.reporting.offloaded_files`
    ;;

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: file_length {
    type: number
    sql: ${TABLE}.file_length ;;
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

  parameter: date_granularity {
    type: string

    allowed_value: {
      label: "Break down by Day"
      value: "day"
    }
    allowed_value: {
      label: "Break down by Week"
      value: "week"
    }
    allowed_value: {
      label: "Break down by Month"
      value: "month"
    }
  }

  dimension: processing_time_unit {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      ${processing_date}
    {% elsif date_granularity._parameter_value == 'week' %}
      ${processing_week}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${processing_month}
    {% else %}
      ${processing_date}
    {% endif %};;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: total_active_unique_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: first_sync_date {
    type:  date
    sql: MIN(${processing_raw}) ;;
  }

  measure: last_sync_date {
    type:  date
    sql: MAX(${processing_raw}) ;;
  }

  measure: lifespan {
    type: number
    sql: DATE_DIFF(${last_sync_date}, ${first_sync_date}, DAY) ;;
  }
}
