view: print_batch_status {
  sql_table_name: dbo.PrintBatchStatus ;;

  dimension: dscr {
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension_group: last_modified {
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
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension_group: pcadded {
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
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension: printbatchstatus_id {
    type: number
    sql: ${TABLE}.printbatchstatus_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
