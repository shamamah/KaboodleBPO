view: total_print_counts {

  derived_table: {
    sql:
      SELECT
        servicejobtype_id,
        sla_month,
        SUM(pass_count) as thepasscount,
        SUM(fail_count) as thefailcount,
        SUM(total_count) as thetotalcount
      FROM
        rpt.sla
      GROUP BY
        servicejobtype_id, sla_month
        ;;
    persist_for: "24 hours"
    indexes: ["servicejobtype_id"]
  }

  dimension:  servicejobtype_id {
    hidden: yes
    primary_key: yes
    type:  number
    sql: ${TABLE}.servicejobtype_id ;;
  }

  dimension_group: sla_month {
    hidden: yes
    type: time
    timeframes: [year,month]
    sql: CONCAT(${TABLE}.sla_month,'01') ;;
    datatype: yyyymmdd
  }

  dimension: thepasscount {
    hidden: yes
    type: number
    sql: ${TABLE}.thepasscount ;;
  }

  dimension: thefailcount {
    hidden: yes
    type: number
    sql: ${TABLE}.thefailcount ;;
  }

  dimension: thetotalcount {
    hidden: yes
    type: number
    sql: ${TABLE}.thetotalcount ;;
  }

  measure: pass_count {
    type: sum
    label: "Total Pass Count"
    sql: ${thepasscount} ;;
    value_format: "#,##0"
    }

measure: sumfailcount {
  type: sum
  label: "Total Fail Count"
  sql: ${thefailcount} ;;
  value_format: "#,##0"
  }

measure: sumtotalcount {
  type: sum
  label: "Total Count"
  sql: ${thetotalcount} ;;
  value_format: "#,##0"
}

}
