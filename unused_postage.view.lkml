view: unused_postage {
  label: "unused_postage"
  sql_table_name: dbo.UnusedPostage ;;

  dimension: comments {
    type: string
    hidden: yes
    sql: ${TABLE}.comments ;;
  }

  dimension: pieces {
    type: number
    hidden: yes
    sql: ${TABLE}.count ;;
  }

  measure: aggregate_unused_postage_count {
    label: "Pieces"
    type: sum
    sql: ${pieces} ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: last_modified {
    type: time
    hidden: yes
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

  dimension_group: meter_date {
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
    sql: ${TABLE}.meter_date ;;
  }

  dimension: meteraccount_id {
    type: number
    hidden: yes
    sql: ${TABLE}.meteraccount_id ;;
  }

  dimension_group: pcadded {
    type: time
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.printbatch_id ;;
  }

  dimension: stamp_amount {
    type: number
    hidden: yes
    sql: ${TABLE}.stamp_amount ;;
  }

  measure: aggregate_stamp_amount {
    label: "Stamp Amount"
    type: sum
    sql: ${stamp_amount} ;;
  }

  dimension: unusedpostage_id {
    type: number
    hidden: yes
    sql: ${TABLE}.unusedpostage_id ;;
  }

  dimension: unusedpostagetype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.unusedpostagetype_id ;;
  }

}
