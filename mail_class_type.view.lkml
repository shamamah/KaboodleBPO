view: mail_class_type {
  label: "Mailing Classes"
  sql_table_name: dbo.MailClassType ;;

  dimension: dscr {
    type: string
    label: "Mailing Class Description"
    sql: ${TABLE}.dscr ;;
  }

  dimension: mailclasstype_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.mailclasstype_id ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
