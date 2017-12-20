view: postage_data {
  sql_table_name: dbo.MeterData ;;

  dimension: meterdata_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.meterdata_id ;;
  }

  dimension: meteraccount_id {
    type: number
    hidden: yes
    sql: ${TABLE}.meteraccount_id ;;
  }

  dimension_group: meter_date {
    type: time
    timeframes: [month,quarter,year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.meter_date ;;
  }

  dimension: mailclasstype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.mailclasstype_id ;;
  }

  dimension: postage_used {
    type: number
    hidden: yes
    sql: ${TABLE}.postage_used ;;
  }

  measure: aggregate_postage_used {
    label: "Metered Postage Amount"
    type: sum
    sql: ${postage_used} ;;
    value_format: "$#,##0.00"
  }

  dimension: pieces {
    type: number
    hidden: yes
    sql: ${TABLE}.pieces ;;
  }

  measure: aggregate_pieces {
    label: "Metered Pieces"
    type: sum
    sql: ${pieces} ;;
    value_format: "#,##0"
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
