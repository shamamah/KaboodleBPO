view: aaa {

  derived_table: {
    sql:
      SELECT
        servicejobtype_id,
        SUM(pass_count) as thepasscount,
        SUM(fail_count) as thefailcount,
        SUM(total_count) as thetotalcount
      FROM
        rpt.sla
      GROUP BY
        servicejobtype_id
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

  measure: sumpasscount {
    type: sum
    sql: ${thepasscount} ;;
    value_format: "#,##0"
    }

measure: sumfailcount {
  type: sum
  sql: ${thefailcount} ;;
  value_format: "#,##0"
  }

measure: sumtotalcount {
  type: sum
  sql: ${thetotalcount} ;;
  value_format: "#,##0"
}

}
