view: sla {
  sql_table_name: report.Sla ;;

  dimension: sla_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.SLA_id ;;
  }

  dimension: customer_id {
    type: number
    hidden:yes
    sql: ${TABLE}.Customer_ID ;;
  }

  dimension: customer_service_job_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CustomerServiceJob_ID ;;
  }

  dimension: fail_count {
    type: number
    sql: ${TABLE}.Fail_Count ;;
  }

  dimension: pass_count {
    type: number
    sql: ${TABLE}.Pass_Count ;;
  }

  dimension: service_job_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ServiceJobType_ID ;;
  }

  dimension: service_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ServiceType_ID ;;
  }

  dimension: sla_actual {
    type: number
    sql: ${TABLE}.SLA_Actual ;;
  }

  dimension: sla_expected {
    type: number
    sql: ${TABLE}.SLA_Expected ;;
  }

  dimension_group: sla_month {
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
    sql: ${TABLE}.SLA_Month ;;
  }

  dimension: total_count {
    type: number
    sql: ${TABLE}.Total_Count ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [sla_id]
  }
}
