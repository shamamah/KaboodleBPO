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
    hidden: yes
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

  dimension: printbatch_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.printbatch_id ;;
  }

  dimension: printbatchstatus_id {
    type: number
    hidden: yes
    sql: ${TABLE}.printbatchstatus_id ;;
  }

  dimension: servicejobtype_id {
    type: number
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.users_id ;;
  }

  dimension: date_diff {
    type:  number
    sql: datediff(d,${TABLE}.batch_date,${TABLE}.end_date) ;;
  }

  dimension: delay {
    type: string
    sql: case when ${date_diff} > 1 then 'True' else 'False' end ;;
  }
  measure: count {
    type: count
    drill_fields: [customer.customer_id, customer.customer_name, users.users_id, users.first_name, users.last_name]
  }
}
