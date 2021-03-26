# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: active_orders_20200326 {
  hidden: yes

  join: active_orders_20200326__wearable_ids {
    view_label: "Active Orders 20200326: Wearable Ids"
    sql: LEFT JOIN UNNEST(${active_orders_20200326.wearable_ids}) as active_orders_20200326__wearable_ids ;;
    relationship: one_to_many
  }
}

view: active_orders_20200326 {
  sql_table_name: `biointellisense-prod.orders.active_orders_20200326`
    ;;

  dimension: biohub_id {
    type: string
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
    sql: ${TABLE}.wearable_ids ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: active_orders_20200326__wearable_ids {
  dimension: active_orders_20200326__wearable_ids {
    type: string
    sql: active_orders_20200326__wearable_ids ;;
  }
}
