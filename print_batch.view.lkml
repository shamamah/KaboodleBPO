view: print_batch {
  sql_table_name: dbo.PrintBatch ;;

  dimension_group: batch {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.batch_date ;;
  }

  dimension: comments {
    type: string
    sql: ${TABLE}.comments ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.end_date ;;
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

  dimension: printbatch_id {
    type: number
    sql: ${TABLE}.printbatch_id ;;
  }

  dimension: printbatchstatus_id {
    type: number
    sql: ${TABLE}.printbatchstatus_id ;;
  }

  dimension: servicejobtype_id {
    type: number
    sql: ${TABLE}.servicejobtype_id ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_date ;;
  }

  dimension: users_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.users_id ;;
  }

  measure: count {
    type: count
    drill_fields: [customer.customer_id, customer.customer_name, users.users_id, users.first_name, users.last_name]
  }
}
