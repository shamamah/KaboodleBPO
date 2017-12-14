view: postage_meter_data {
  sql_table_name: dbo.MeterData ;;

  dimension: meterdate_id {
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
    timeframes: [week,month,quarter,year]
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
    type: string
    hidden: yes
    sql: ${TABLE}.postage_used ;;
  }

  measure: aggregate_postage_used {
    label: "Postage Used"
    type: sum
    sql: ${postage_used} ;;
    value_format: "$#,##0.00"
  }

  dimension: pieces {
    type: number
    hidden: yes
    sql: ${TABLE}.pieces ;;
  }

  measure:  aggregate_pieces {
    label: "Pieces"
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
