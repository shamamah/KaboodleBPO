view: meter_data {
  sql_table_name: dbo.MeterData ;;

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

  dimension_group: meter {
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

  dimension: meterdata_id {
    type: number
    hidden: yes
    sql: ${TABLE}.meterdata_id ;;
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

  dimension: pieces {
    type: number
    sql: ${TABLE}.pieces ;;
  }

  dimension: postage_used {
    type: string
    sql: ${TABLE}.postage_used ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
