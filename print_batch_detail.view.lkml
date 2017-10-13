view: print_batch_detail {
  sql_table_name: dbo.PrintBatchDetail ;;

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${printbatch_id},${printbatchdetail_num}) ;;
  }


  dimension: comments {
    type: string
    sql: ${TABLE}.comments ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.end_date ;;
  }

  dimension: flat_count {
    type: number
    sql: ${TABLE}.flat_count ;;
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

  dimension: nonflat_count {
    type: number
    sql: ${TABLE}.nonflat_count ;;
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
    hidden: yes
    sql: ${TABLE}.printbatch_id ;;
  }

  dimension: printbatchdetail_num {
    type: number
    hidden: yes
    sql: ${TABLE}.printbatchdetail_num ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_date ;;
  }

  dimension: stationtype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.stationtype_id ;;
  }

  dimension: users_id {
    type: number
    hidden: yes
    sql: ${TABLE}.users_id ;;
  }


  measure: Print_Batch_Detail_count {
    type: count
    drill_fields: [users.users_id, users.first_name, users.last_name]
  }

  measure: sum_batch_detail_count {
    type: sum
    label: "Total Batch Detail Count"
    sql: ${count} ;;

  }
}
