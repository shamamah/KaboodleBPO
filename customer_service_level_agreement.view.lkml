view: customer_service_level_agreement {
  sql_table_name: dbo.CustomerServiceLevelAgreement ;;

  dimension: customerservicejob_id {
    type: number
    sql: ${TABLE}.customerservicejob_id ;;
  }

  dimension: data_table {
    type: string
    sql: ${TABLE}.data_table ;;
  }

  dimension: end_column {
    type: string
    sql: ${TABLE}.end_column ;;
  }

  dimension: intervalrange {
    type: number
    sql: ${TABLE}.intervalrange ;;
  }

  dimension: intervaltype_id {
    type: number
    sql: ${TABLE}.intervaltype_id ;;
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

  dimension: sla_percentage {
    type: number
    sql: ${TABLE}.sla_percentage ;;
  }

  dimension: start_column {
    type: string
    sql: ${TABLE}.start_column ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
