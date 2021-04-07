view: uat {
  sql_table_name: `biointellisense-prod.temp.uat`
    ;;

  dimension: bio_id {
    type: string
    sql: ${TABLE}.bio_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
