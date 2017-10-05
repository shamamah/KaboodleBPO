view: interval_type {
  sql_table_name: dbo.IntervalType ;;

  dimension: dscr {
    type: string
    label: "Interval_Description"
    sql: ${TABLE}.dscr ;;
  }

  dimension: intervaltype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.intervaltype_id ;;
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
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.pcadded_date ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
