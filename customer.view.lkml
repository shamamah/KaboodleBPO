view: customer {
  sql_table_name: dbo.Customer ;;

  dimension: customer_id {
    primary_key: yes
    type: number
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.contract_start_date ;;
  }

  dimension: customer_name {
    type: string
    label: "Company Name"
    sql: ${TABLE}.customer_name ;;
  }

  dimension: customer_number {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_number ;;
  }

  dimension: diamond_client {
    type: string
    hidden: yes
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

  dimension: sla_reporting {
    type: string
    hidden: yes
    sql: ${TABLE}.SLA_Reporting ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [customer_id, customer_name, customer_service.count, meter_account.count, print_batch.count]
  }
}
