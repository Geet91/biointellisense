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
