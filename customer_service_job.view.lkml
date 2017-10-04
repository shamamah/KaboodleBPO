view: customer_service_job {
  sql_table_name: dbo.CustomerServiceJob ;;

  dimension: customerservice_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customerservice_id ;;
  }

  dimension: customerservicejob_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customerservicejob_id ;;
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

  dimension: servicejobtype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.servicejobtype_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
