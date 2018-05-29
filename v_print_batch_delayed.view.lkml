view: v_print_batch_delayed {
  sql_table_name: dbo.vPrintBatchDelayed ;;

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${batch_id},${customer_id},${service_job_type_id},${station_type_id}) ;;
  }

  dimension_group: batch {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Batch_Date ;;
  }

  dimension_group: batch_end {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Batch_End_Date ;;
  }

  dimension: batch_id {
    type: number
    hidden: yes
    sql: ${TABLE}.Batch_id ;;
  }

  dimension: batch_sla_not_met {
    type: string
    sql: ${TABLE}.Batch_SLA_Not_Met ;;
  }

  dimension: count {
    hidden: yes
    type: number
    sql: ${TABLE}.Count ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.Customer_id ;;
  }

  dimension_group: detail_end {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Detail_End_date ;;
  }

  dimension_group: detail_start {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Detail_Start_Date ;;
  }

  dimension: flat_count {
    type: number
    hidden: yes
    sql: ${TABLE}.Flat_Count ;;
  }

  dimension: non_flat_count {
    type: number
    hidden: yes
    sql: ${TABLE}.NonFlat_Count ;;
  }

  dimension: service_job_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ServiceJobType_id ;;
  }

  dimension: sla_days {
    type: number
    sql: ${TABLE}.SLA_Days ;;
  }

  dimension: station_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.StationType_id ;;
  }

  dimension: users_id {
    type: number
    hidden: yes
    sql: ${TABLE}.Users_id ;;
  }

  measure: penalty_score {
  type:  sum
  sql: ${count} ;;
  }
#  measure: count {
#    type: count
#    drill_fields: []
#  }
}
