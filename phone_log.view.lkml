view: phone_log {
  sql_table_name: pho.PhoneLog ;;

  dimension_group: abandon {
    type: time
    label: "Abandon Time"
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
    sql: ${TABLE}.abandon_time ;;
  }

  dimension_group: accept {
    type: time
    label: "Accept Time"
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
    sql: ${TABLE}.accept_time ;;
  }

  dimension: answer_time_leg_1 {
    type: number
    hidden: yes
    sql: ${TABLE}.answer_time_leg_1 ;;
  }

  dimension: answer_time_leg_2 {
    type: number
    hidden: yes
    sql: ${TABLE}.answer_time_leg_2 ;;
  }

  dimension: channeltype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.channeltype_id ;;
  }

  dimension_group: create {
    type: time
    label: "Call Arrive Time"
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
    sql: ${TABLE}.create_time ;;
  }

  dimension: hold_count {
    type: number
    hidden: yes
    sql: ${TABLE}.hold_count ;;
  }

  dimension: hold_time_max {
    type: number
    hidden: yes
    sql: ${TABLE}.hold_time_max ;;
  }

  dimension: hold_time_total {
    type: number
    hidden: yes
    sql: ${TABLE}.hold_time_total ;;
  }

  dimension: ivr_treatment_time {
    type: number
    hidden: yes
    sql: ${TABLE}.ivr_treatment_time ;;
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

  dimension: mediatype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.mediatype_id ;;
  }

  dimension: origination_number {
    type: string
    hidden: yes
    label: "Caller ID"
    sql: ${TABLE}.origination_number ;;
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

  dimension: phonelog_id {
    type: number
    hidden: yes
    sql: ${TABLE}.phonelog_id ;;
  }

  dimension: post_dial_delay_leg_1 {
    type: number
    hidden: yes
    sql: ${TABLE}.post_dial_delay_leg_1 ;;
  }

  dimension: post_dial_delay_leg_2 {
    type: number
    hidden: yes
    sql: ${TABLE}.post_dial_delay_leg_2 ;;
  }

  dimension: post_processing_time {
    type: number
    hidden: yes
    sql: ${TABLE}.post_processing_time ;;
  }

  dimension: queuetype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.queuetype_id ;;
  }

  dimension: sip_id_inbound {
    type: string
    hidden: yes
    sql: ${TABLE}.SIP_ID_inbound ;;
  }

  dimension: sip_id_leg_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.SIP_ID_leg_1 ;;
  }

  dimension: sip_id_leg_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.SIP_ID_leg_2 ;;
  }

  dimension: total_time {
    type: number
    hidden: yes
    sql: ${TABLE}.total_time ;;
  }

  dimension: transaction {
    type: number
    hidden: yes
    sql: ${TABLE}."transaction" ;;
  }

  dimension: transaction_processing_time {
    type: number
    hidden: yes
    sql: ${TABLE}.transaction_processing_time ;;
  }

  dimension: users_id {
    type: number
    hidden: yes
    sql: ${TABLE}.users_id ;;
  }

  measure: CallCount {
    type: count
    label: "Incoming Calls"
    #drill_fields: []
  }

  dimension: filter_accepted_calls {
    type: date
    sql: CASE WHEN ${accept_time} < '1900/01/01' THEN NULL
         ELSE ${accept_date}
        END ;;
  }

  measure: count_accepted_calls {
    type: count
    label: "Answered Calls"
    filters: {
      field: filter_accepted_calls
      value: "-NULL"
    }
  }

  measure: count_abandoned_calls {
    type: count
    label: "Abandoned Calls"
    filters: {
      field: filter_accepted_calls
      value: "NULL"
    }
  }

  #CASE WHEN (accept_time = '1800-01-01 00:00:00.000') THEN NULL ELSE datediff(s, pl.create_time, pl.accept_time) END as OnHoldBeforeAnswer_Seconds
  dimension: filter_queue_wi30_before_answer {
    type: date
    sql: CASE WHEN (${accept_time} > '1900/01/01' AND datediff(s, ${create_time}, ${accept_time}) <= 30)
        THEN datediff(s, ${create_time}, ${accept_time})
        ELSE NULL
      END ;;
  }

  measure: count_answered_calls_wi30 {
    type: count
    label: "Answered Calls w/i 30 sec"
    filters: {
      field: filter_queue_wi30_before_answer
      value: "-NULL"
    }
  }

  measure: TalkTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Talk Time"
    sql:  (${transaction_processing_time} * 0.0000001) ;;
    value_format: "0"
  }

  measure: PostProcessingTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Post Processing Time"
    sql:  (${post_processing_time} * 0.0000001) ;;
    value_format: "0"
  }

  measure: TotalTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Total Time (Incl PP)"
    sql:  (${total_time} * 0.0000001) ;;
    value_format: "0"
  }
}
