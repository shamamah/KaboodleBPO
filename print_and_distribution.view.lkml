view: print_and_distribution {
  sql_table_name: rpt.sla ;;

  dimension: sla_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.sla_id ;;
  }

  dimension: customer_id {
    type: number
    hidden:yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: service_type_id {
    type: number
    hidden:yes
    sql: ${TABLE}.servicetype_id ;;
  }

  dimension: service_job_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.servicejobtype_id ;;
  }

  dimension: customer_service_job_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customerservicejob_id ;;
  }

  dimension: pass_count {
    type: number
    hidden:  yes
    sql: ${TABLE}.pass_count ;;
  }

  measure: aggregate_pass_count {
    label: "Pass Count"
    type: sum
    sql: ${pass_count} ;;
  }

  dimension: fail_count {
    type: number
    hidden: yes
    sql: ${TABLE}.fail_count ;;
  }

  measure: aggregate_fail_count {
    label: "Fail Count"
    type: sum
    sql: ${fail_count} ;;
  }

  dimension: total_count {
    type: number
    hidden: yes
    sql: ${TABLE}.total_count ;;
  }

  measure: aggregate_total_count {
    label: "Total Count"
    type: sum
    sql: ${total_count} ;;
  }

  dimension_group: sla_month {
    type: time
    timeframes: [year,month]
    sql: CONCAT(${TABLE}.sla_month,'01') ;;
    datatype: yyyymmdd
  }

  dimension: sla_actual {
    type: number
    sql: ${TABLE}.sla_actual ;;
  }

  dimension: sla_expected {
    type: number
    hidden: yes
    sql: ${TABLE}.sla_expected ;;
  }

  measure: aggregate_sla_expected {
    type:  max
    label: "SLA Expected"
    sql: ${sla_expected} ;;
  }

  measure:  calc_sla_actual{
    type: number
    sql: ${aggregate_pass_count}/nullif(${aggregate_total_count},0) * 100.0 ;;
    value_format: "0.00\%"
    }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [sla_id]
  }
}
