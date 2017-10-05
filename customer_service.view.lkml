view: customer_service {
  sql_table_name: dbo.CustomerService ;;

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customerservice_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customerservice_id ;;
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

  dimension: servicetype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.servicetype_id ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [customer.customer_id, customer.customer_name]
  }
}
