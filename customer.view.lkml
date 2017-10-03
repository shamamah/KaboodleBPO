view: customer {
  sql_table_name: dbo.Customer ;;

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: contract_start {
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
    sql: ${TABLE}.contract_start_date ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension: customer_number {
    type: number
    sql: ${TABLE}.customer_number ;;
  }

  dimension: diamond_client {
    type: string
    sql: ${TABLE}.Diamond_Client ;;
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

  dimension: sla_reporting {
    type: string
    sql: ${TABLE}.SLA_Reporting ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_id, customer_name, customer_service.count, meter_account.count, print_batch.count]
  }
}
