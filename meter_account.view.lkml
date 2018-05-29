view: meter_account {
  label: "Meter Accounts"
  sql_table_name: dbo.MeterAccount ;;

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_ID ;;
  }

  dimension: dscr {
    type: string
    label: "Meter Description"
    sql: ${TABLE}.dscr ;;
  }

  dimension: meteraccount_code {
    type: number
    label: "Meter Account"
    sql: ${TABLE}.meteraccount_code ;;
  }

  dimension: meteraccount_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.meteraccount_id ;;
  }

  dimension: slagrouptype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.slagrouptype_id ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [customer.customer_id, customer.customer_name]
  }
}
