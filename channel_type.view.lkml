view: channel_type {
  sql_table_name: pho.ChannelType ;;

  dimension: channeltype_id {
    type: number
    hidden:  yes
    sql: ${TABLE}.channeltype_id ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: dscr {
    type: string
    label: "Channel Name"
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

  dimension: name {
    type: string
    label: "Channel Detail"
    sql: ${TABLE}.name ;;
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
    hidden: yes
    drill_fields: [name]
  }
}
