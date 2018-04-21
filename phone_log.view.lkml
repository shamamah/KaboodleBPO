view: phone_log {
  sql_table_name: pho.PhoneLog ;;

  dimension_group: abandon {
    type: time
    label: "Abandon Time"
    timeframes: [raw,time,date,week,month,quarter,year]
    hidden: yes
    sql: ${TABLE}.abandon_time ;;
  }

  dimension_group: accept {
    type: time
    label: "Accept Time"
    timeframes: [raw,time,date,week,month,quarter,year]
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
    label: "Call Arrival"
    timeframes: [raw,time,date,week,month,quarter,year]
    hidden: no
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
    timeframes: [raw,time,date,week,month,quarter,year]
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
    timeframes: [raw,time,date,week,month,quarter,year]
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
    label: "Calls/Chats Arrived"
    drill_fields: [phonelog_id,transaction,create_time,accept_time]
  }

  dimension: filter_accepted_calls {
    type: date
    hidden: yes
    sql: CASE WHEN ${accept_time} < '1900/01/01' THEN NULL
         ELSE ${accept_date}
        END ;;
  }

  measure: count_accepted_calls {
    type: count
    label: "Calls/Chats Answered"
    filters: {
      field: filter_accepted_calls
      value: "-NULL"
    }
  }

  measure: count_abandoned_calls {
    type: count
    label: "Calls/Chats Abandoned"
    filters: {
      field: filter_accepted_calls
      value: "NULL"
    }
  }

  dimension: filter_queue_wi30_before_answer {
    type: date
    hidden: yes
    sql: CASE WHEN (${accept_time} > '1900/01/01' AND datediff(s, ${create_time}, ${accept_time}) <= 30)
        THEN datediff(s, ${create_time}, ${accept_time})
        ELSE NULL
      END ;;
  }

  measure: count_answered_calls_wi30 {
    type: count
    label: "Calls/Chats Answered within 30 sec"
    filters: {
      field: filter_queue_wi30_before_answer
      value: "-NULL"
    }
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
  }

  measure: TalkTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Talk/Chat Time (sec)"
    sql:  (${transaction_processing_time} * 0.0000001) ;;
    value_format: "0"
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
  }

  measure: PostProcessingTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Talk/Chat Post Processing Time"
    sql:  (${post_processing_time} * 0.0000001) ;;
    value_format: "0"
    hidden: yes
  }

  measure: TotalTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Talk/Chat Time inc PP (sec)"
    sql:  (${total_time} * 0.0000001) ;;
    value_format: "0"
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
  }

  measure: PercentAnsweredWithin30Seconds {
    type: number
    label: "Calls/Chats Answered within 30 sec %"
    sql: case when (${count_accepted_calls} = 0) Then 0 Else ((${count_answered_calls_wi30} * 100.0) / ${count_accepted_calls}) End ;;
    value_format: "0.00\%"
  }

  measure: PercentAbandoned {
    type: number
    label: "Calls/Chats Abandoned %"
    sql: case when (${CallCount} = 0) Then 0 Else ((${count_abandoned_calls} * 100.0) / ${CallCount}) End ;;
    value_format: "0.00\%"
  }

  measure: AverageTalkTime_sec {
    type: number
    label: "Talk/Chat Average Time (sec)"
    sql: case when (${count_accepted_calls} = 0) Then 0 Else (${TotalTime} / ${count_accepted_calls}) End ;;
    value_format: "0.0"
  }

  measure: AverageTalkTime_min {
    type: number
    label: "Talk/Chat Average Time (min)"
    sql: case when (${count_accepted_calls} = 0) Then 0 Else ((${TotalTime} / 60.) / ${count_accepted_calls}) End ;;
    value_format: "0.0"
  }

  dimension : TimeAnsweredWithin {
    type: tier
    label: "Time in Answering"
    tiers: [31, 61, 91, 121]
    style: integer
    sql: CASE WHEN (${accept_time} > '1900/01/01')
      THEN datediff(s, ${create_time}, ${accept_time})
      ELSE -1
    END ;;
    value_format: "0"
  }
}
