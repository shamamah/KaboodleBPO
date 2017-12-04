view: meter_account {
  sql_table_name: dbo.MeterAccount ;;

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_ID ;;
  }

  dimension: dscr {
    type: string
    label: "Description"
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

  dimension: meteraccount_code {
    type: number
    sql: ${TABLE}.meteraccount_code ;;
  }

  dimension: meteraccount_id {
    type: number
    hidden: yes
    sql: ${TABLE}.meteraccount_id ;;
  }

  dimension: slagrouptype_id {
    type: number
    sql: ${TABLE}.slagrouptype_id ;;
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

  measure: count {
    type: count
    drill_fields: [customer.customer_id, customer.customer_name]
  }
}
