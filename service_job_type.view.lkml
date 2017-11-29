view: service_job_type {
  sql_table_name: dbo.ServiceJobType ;;

  dimension: dscr {
    label: "Job Description"
    type: string
    sql: ${TABLE}.dscr ;;
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

  dimension: servicejobtype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.servicejobtype_id ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
