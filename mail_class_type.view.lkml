view: mail_class_type {
  sql_table_name: dbo.MailClassType ;;

  dimension: dscr {
    type: string
    label: "Mail_Class_Type_Desc"
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

  dimension: mailclasstype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.mailclasstype_id ;;
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
