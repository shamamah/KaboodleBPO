view: users {
  sql_table_name: dbo.Users ;;

  dimension: users_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.users_id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
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

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
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

  dimension: usertype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.usertype_id ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [users_id, first_name, last_name, print_batch.count, print_batch_detail.count]
  }
}
