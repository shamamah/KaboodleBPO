view: service_type {
  sql_table_name: dbo.ServiceType ;;

  dimension: dscr {
    type: string
    label: "Service Desription"
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

  dimension: servicetype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.servicetype_id ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
