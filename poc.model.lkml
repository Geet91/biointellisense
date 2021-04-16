connection: "production_bigquery"

#include: "views/*.view.lkml"                # include all views in the views/ folder in this project
 include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
explore: offloaded_files {
  label: "Files"
  join: active_orders_20210318 {
    type: left_outer
    sql_on: ${offloaded_files.user_id} = ${active_orders_20210318.biohub_id} ;;
    relationship: many_to_many
  }
  # join: active_orders_20210318__wearable_ids {
  #   view_label: "Active Orders 20210318: Wearable Ids"
  #   sql: LEFT JOIN UNNEST(${active_orders_20210318.wearable_ids}) as active_orders_20210318__wearable_ids ;;
  #   relationship: one_to_many
  # }
}


explore: sync_gaps {
  join: raw_voltage {
    type: left_outer
    relationship: one_to_many
    sql_on: ${sync_gaps.user_id} = ${raw_voltage.user_id} and ${raw_voltage.processing_raw} between ${sync_gaps.start_raw} and ${sync_gaps.end_raw} ;;
  }
}

explore: consolidated_parsed_generic_files {}

explore: device_lifespan_summary {
  join: active_orders_20200326 {
    type: left_outer
    relationship: many_to_many
    sql_on: ${device_lifespan_summary.user_id} = ${active_orders_20200326.biohub_id} ;;
  }
}

explore: uat {
  join: message_logs {
    type: left_outer
    relationship: one_to_many
    sql_on: ${uat.bio_id} = ${message_logs.user_id} ;;
  }
}

explore: consolidated_message_logs {}

explore: biohub_modem_sessions {
  join: biohub_cell_signals {
    type: left_outer
    relationship: one_to_many
    sql_on: ${biohub_modem_sessions.environment} = ${biohub_cell_signals.environment} and ${biohub_modem_sessions.user_id} = ${biohub_cell_signals.user_id} and ${biohub_cell_signals.entry_timestamp_raw} between ${biohub_modem_sessions.start_raw} and ${biohub_modem_sessions.end_raw};;
  }
}

explore: biohub_cell_signals {}
