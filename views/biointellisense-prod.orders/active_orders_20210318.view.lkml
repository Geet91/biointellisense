# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
# explore: active_orders_20210318 {
#   hidden: yes


# }

view: active_orders_20210318 {
  sql_table_name: `biointellisense-prod.orders.active_orders_20210318`
    ;;

  dimension: biohub_id {
    type: number
    sql: ${TABLE}.biohub_id ;;
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: order_number {
    type: string
    sql: ${TABLE}.order_number ;;
  }

  dimension: patient_id {
    type: string
    sql: ${TABLE}.patient_id ;;
  }

  dimension: wearable_ids {
    hidden: yes
    type: string
    sql: cast (${TABLE}.wearable_ids as string) ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: active_orders_20210318__wearable_ids {
  dimension: active_orders_20210318__wearable_ids {
    type: string
    value_format_name: id
    sql: cast(active_orders_20210318__wearable_ids as string)  ;;
  }

  measure: total_active_users {
    type: count_distinct
    sql: ${active_orders_20210318__wearable_ids} ;;

  }
}
