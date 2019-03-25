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
    label: "Arrival"
    timeframes: [raw,time,date,week,month,quarter,year]
    hidden: no
    sql: ${TABLE}.create_time ;;
  }

  dimension: time_12h {
    type: string
    label: "Hour of Day (12hr)"
    hidden: no
    sql: CASE WHEN DATEPART( HH , ${TABLE}.create_time) > 12 THEN CAST ( ( DATEPART( HH , ${TABLE}.create_time)  % 12 ) AS VARCHAR) + ' PM'
                  ELSE  CAST ( ( DATEPART( HH , ${TABLE}.create_time)   ) AS VARCHAR) + ' AM'
              END ;;
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

  dimension: directiontype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.directiontype_id ;;
  }

  dimension: calltype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.calltype_id ;;
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
    label: "Arrived Count"
    drill_fields: [phonelog_id,transaction,create_time,accept_time]
  }

  #ADDED THIS MEASURE ON 2018-05-14 PER EMAIL FROM JON TO USE 4 WEEKS 'LOOKPBACK' PERIOD TO COUNT FTE NEED
  measure: FTE_Count {
    type: number
    #CallCount divided by 8 (for # of calls per hour per FTE) divided by 4 (for 4 week loopback)
    #sql: (${CallCount} / 8.0) / 4.0 ;;
    # 2019-03-25  Per Jon's request, the hourly rate is changed from 8 to 10, for the number of calls per CSR
    sql: (${CallCount} / 10.0) / 4.0 ;;
    label: "FTE Count"
    value_format: "0.#"
    drill_fields: [phonelog_id,transaction,create_time,accept_time]
  }
  #END BLOCK -- 2018-05-14

  dimension: filter_accepted_calls {
    type: date
    hidden: yes
    sql: CASE WHEN ${accept_time} < '1900/01/01' THEN NULL
         ELSE ${accept_date}
        END ;;
  }

  measure: count_accepted_calls {
    type: count
    label: "Answered Count"
    filters: {
      field: filter_accepted_calls
      value: "-NULL"
    }
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time, TotalTime_min]
  }

  measure: count_abandoned_calls {
    type: count
    label: "Abandoned Count"
    filters: {
      field: filter_accepted_calls
      value: "NULL"
    }
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
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
    label: "Answered Within 30 Sec Count"
    filters: {
      field: filter_queue_wi30_before_answer
      value: "-NULL"
    }
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
  }

  #ADDED THIS BLOCK ON 2018-05-05 PER EMAIL FROM JON INDICATING THAT % ABANDONED CALLS OVER 30 SEC IS SLA
  dimension: filter_abandoned_after_30sec {
    type: date
    hidden: yes
    sql: CASE WHEN (${accept_time} < '1900/01/01' AND datediff_big(ss, ${create_time}, ${abandon_time}) > 30)
        THEN datediff_big(ss, ${create_time}, ${abandon_time})
        ELSE NULL
      END ;;
  }

  measure:  abandoned_after_30sec {
    type: count
    label: "Abandoned After 30 Sec Count"
    filters: {
      field: filter_abandoned_after_30sec
      value: "-NULL"
    }
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
  }

  measure: PercentAbandonedAfter30Seconds {
    type: number
    hidden: no
    label: "% Abandoned After 30 sec"
    sql: case when (${count_accepted_calls} = 0) Then 0 Else ((${abandoned_after_30sec} * 100.0) / ${CallCount}) End ;;
    value_format: "0.00\%"
  }
  #END BLOCK -- 2018-05-05 PER EMAIL FROM JON INDICATING THAT % ABANDONED CALLS OVER 30 SEC IS SLA

  measure: TalkTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Talk Duration (sec)"
    sql:  (${transaction_processing_time} * 0.0000001) ;;
    value_format: "0"
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
  }

  measure: PostProcessingTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Post Processing Duration"
    sql:  (${post_processing_time} * 0.0000001) ;;
    value_format: "0"
    hidden: yes
  }

  measure: TotalTime {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    label: "Total Duration (sec)"
    sql:  (${total_time} * 0.0000001) ;;
    value_format: "0"
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
  }

  measure: TotalTime_min {
    #(transaction_processing_time * POWER(10.00000000000,-7))
    type: sum
    hidden: yes
    label: "Total Duration (min)"
    sql:  ((${total_time} * 0.0000001) / 60.) ;;
    value_format: "0.0"
    drill_fields: [phonelog_id,transaction,create_time,accept_time,transaction_processing_time,post_processing_time]
  }

  measure: PercentAnsweredWithin30Seconds {
    type: number
    label: "% Answered Within 30 Sec"
    sql: case when (${count_accepted_calls} = 0) Then 0 Else ((${count_answered_calls_wi30} * 100.0) / ${count_accepted_calls}) End ;;
    value_format: "0.00\%"
  }

  measure: PercentAnswered {
    type: number
    label: "% Answered"
    sql: case when (${CallCount} = 0) Then 0 Else ((${count_accepted_calls} * 100.0) / ${CallCount}) End ;;
    value_format: "0\%"
  }

  measure: PercentAbandoned {
    type: number
    label: "% Abandoned"
    sql: case when (${CallCount} = 0) Then 0 Else ((${count_abandoned_calls} * 100.0) / ${CallCount}) End ;;
    value_format: "0.00\%"
  }

  measure: AverageTalkTime_sec {
    type: number
    label: "Average Duration (sec)"
    sql: case when (${count_accepted_calls} = 0) Then 0 Else (${TotalTime} / ${count_accepted_calls}) End ;;
    value_format: "0.0"
  }

  measure: AverageTalkTime_min {
    type: number
    label: "Average Duration (min)"
    sql: case when (${count_accepted_calls} = 0) Then 0 Else ((${TotalTime} / 60.) / ${count_accepted_calls}) End ;;
    value_format: "0.0"
  }

  dimension : TimeAnsweredWithin {
    type: tier
    label: "Time in Answering (sec)"
    tiers: [31, 61, 91, 121]
    style: integer
    sql: CASE WHEN (${accept_time} > '1900/01/01')
      THEN datediff(s, ${create_time}, ${accept_time})
      ELSE -1
    END ;;
    value_format: "0"
  }

  dimension : TalkTime_sec {
    type: tier
    label: "Duration (sec)"
    #MODEIFIED INTERVALS ON 2018-05-05 PER EMAIL FROM JON
    tiers: [31, 61, 121, 181, 241, 301]
    style: integer
    sql:  (${total_time} * 0.0000001) ;;
    value_format: "0"
  }

  dimension : TalkTime_min {
    type: tier
    label: "Duration (min)"
    tiers: [2, 5, 10, 15, 30]
    style: relational
    sql:  (${total_time} * 0.0000001 / 60.0) ;;
    value_format: "0"
  }

  dimension : Weekday {
    type: date_day_of_week
    label: "Day of Week"
    sql: ${TABLE}.create_time ;;
  }

  dimension : HourOfDay {
    type: date_hour_of_day
    label: "Hour of Day (24hr)"
    sql: ${TABLE}.create_time ;;
  }
}
