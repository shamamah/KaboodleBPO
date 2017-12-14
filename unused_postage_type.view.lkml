view: unused_postage_type {
  sql_table_name: dbo.UnusedPostageType ;;

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

  dimension: unusedpostagetype_id {
    type: number
    sql: ${TABLE}.unusedpostagetype_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
