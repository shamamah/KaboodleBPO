view: media_type {
  sql_table_name: pho.MediaType ;;

  dimension: dscr {
    type: string
    label: "Media Type"
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

  dimension: mediatype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.mediatype_id ;;
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
