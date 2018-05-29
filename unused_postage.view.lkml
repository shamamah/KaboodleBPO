view: unused_postage {
  label: "Unused Postage"
  sql_table_name: dbo.UnusedPostage ;;

  dimension: unusedpostage_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.unusedpostage_id ;;
  }

  dimension: unusedpostagetype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.unusedpostagetype_id ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: meteraccount_id {
    type: number
    hidden: yes
    sql: ${TABLE}.meteraccount_id ;;
  }

  dimension_group: meter_date {
    label: "Meter Stamp Date"
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

  dimension: count {
    type: number
    hidden: yes
    sql: ${TABLE}.count ;;
  }

  measure: aggregate_count {
    label: "Unused Count"
    type: sum
    sql: ${count} ;;
  }

  dimension: stamp_amount {
    type: number
    hidden: yes
    sql: ${TABLE}.stamp_amount ;;
  }

  measure: aggregate_stamp_amount {
    label: "Unused Postage Amount"
    type: sum
    sql: ${stamp_amount} ;;
  }
}
