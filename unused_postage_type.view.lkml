view: unused_postage_type {
  label: "Reverse Postage Reasons"
  sql_table_name: dbo.UnusedPostageType ;;

  dimension: unusedpostagetype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.unusedpostagetype_id ;;
  }

  dimension: dscr {
    type: string
    label: "Reversed Postage Reason"
    sql: ${TABLE}.dscr ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
