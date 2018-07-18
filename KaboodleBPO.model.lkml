label: "Kaboodle BPO"
connection: "bpo"

include: "*.view"
#include: "*.dashboard"

fiscal_month_offset: 0
persist_for: "30 minutes"

week_start_day: sunday

explore: print_and_distribution {
  description: "BPO's print and distribution operations, to gauge turnaround in print and mailing of batches in comparison to customer's SLA"
  label: "Actual vs SLA"
  group_label: "BPO: Print & Distribution"
  view_label: "Service Level Agreement"
  hidden: no
  sql_always_where: ${service_type.servicetype_id}=1 ;;    #servicetype_id = 1 is for "Print & Distribution as in the table"
  persist_for: "4 hours"
  from: print_and_distribution
  view_name: print_and_distribution
  sql_table_name: rpt.sla ;;

  #fields: []
  #always_filter: {}
  #always_join: []

  access_filter: {
    field:customer.customer_name
    user_attribute:company_name
  }

  join: customer {
    type: inner
    relationship: many_to_one
    from: "customer"
    sql_table_name: dbo.Customer ;;
    view_label: "Company"
    #required_joins: []
    #foreign_key:
    sql_on: ${print_and_distribution.customer_id} = ${customer.customer_id} ;;
  }

  join: service_type {
    type: inner
    relationship: many_to_one
    from: service_type
    sql_table_name: dbo.ServiceType ;;
    view_label: "Service Types"
    #required_joins: []
    #foreign_key:
    sql_on: ${print_and_distribution.service_type_id} = ${service_type.servicetype_id} ;;
  }

  join: service_job_type {
    type: inner
    relationship: many_to_one
    from: service_job_type
    sql_table_name: dbo.ServiceJobType ;;
    view_label: "Service Job Types"
    #required_joins: []
    #foreign_key:
    sql_on: ${print_and_distribution.service_job_type_id} = ${service_job_type.servicejobtype_id} ;;
  }

  join: sla_group_type {
    type: inner
    relationship: many_to_one
    from: sla_group_type
    sql_table_name: dbo.SLAGroupType ;;
    view_label: "Service Groups"
    #required_joins: []
    #foreign_key:
    sql_on: ${service_job_type.slagrouptype_id} = ${sla_group_type.slagrouptype_id};;
  }

  join: total_print_counts {
    type: inner
    relationship: many_to_one
    view_label: "Cohort"
    sql_on: ${print_and_distribution.service_job_type_id} = ${total_print_counts.servicejobtype_id} and
            ${print_and_distribution.sla_month_month} = ${total_print_counts.sla_month_month} and
            ${print_and_distribution.sla_month_year} = ${total_print_counts.sla_month_year};;
  }
}


explore: postage_data {
  description: "BPO's postage usage measure"
  label: "Postage Meter"
  group_label: "BPO: Print & Distribution"
  view_label: "Postage Usage"
  persist_for: "4 hours"
  from: postage_data
  view_name: postage_data
  sql_table_name: dbo.MeterData ;;

  access_filter: {
    field:customer.customer_name
    user_attribute:company_name
  }

  join: meter_account {
    type: inner
    relationship: many_to_one
    from: "meter_account"
    sql_table_name: dbo.MeterAccount ;;
    view_label: "Postage Meter Account"
    #required_joins: []
    #foreign_key:
    sql_on: ${postage_data.meteraccount_id} = ${meter_account.meteraccount_id} ;;
  }

  join: customer {
    type: inner
    relationship: many_to_one
    from: "customer"
    sql_table_name: dbo.Customer ;;
    view_label: "Company"
    #required_joins: []
    #foreign_key:
    sql_on: ${meter_account.customer_id} = ${customer.customer_id} ;;
  }

  join: mail_class_type {
    type: inner
    relationship: many_to_one
    from: mail_class_type
    sql_table_name: dbo.MailClassType ;;
    view_label: "Mailing Classes"
    #required_joins: []
    #foreign_key:
    sql_on: ${postage_data.mailclasstype_id} = ${mail_class_type.mailclasstype_id} ;;
  }

  join: sla_group_type {
    type: inner
    relationship: many_to_one
    from: sla_group_type
    sql_table_name: dbo.SLAGroupType ;;
    view_label: "Service Groups"
    #required_joins: []
    #foreign_key:
    sql_on: ${meter_account.slagrouptype_id} = ${sla_group_type.slagrouptype_id} ;;
  }

  join: unused_postage {
    type: inner
    relationship: many_to_many
    from: unused_postage
    sql_table_name: dbo.UnusedPostage ;;
    view_label: "Unused Postage"
    #required_joins: []
    #foreign_key:
    sql_on: ${postage_data.meteraccount_id} = ${unused_postage.meteraccount_id} and ${meter_account.slagrouptype_id} = ${sla_group_type.slagrouptype_id} ;;
    sql_where: ${unused_postage.unusedpostagetype_id} <> 11 ;;
  }

  #join: unused_postage_type {
  #  type: inner
  #  relationship: many_to_one
  #  from: unused_postage_type
  #  sql_table_name: dbo.UnusedPostageType ;;
  #  view_label: "Unused Postage Type"
  #  #required_joins: []
  #  #foreign_key:
  #  sql_on: ${unused_postage.unusedpostagetype_id} = ${unused_postage_type.unusedpostagetype_id} ;;
  #}
}


explore: phone_log {
  description: "BPO's Customer Service Performance"
  label: "Customer Service (Phone/Chat)"
  group_label: "BPO: Customer Service"
  view_label: "Call/Chat Characteristics"
  hidden: no

  persist_for: "1 hours"
  from: phone_log
  view_name: phone_log
  sql_table_name: pho.PhoneLog ;;
  sql_always_where: ((CASE WHEN ((ISNULL(from_transfer,0)=0) AND (ISNULL(from_conference,0)=0)) THEN 1 ELSE 0 END) <> 0)
      AND ${direction_type.directiontype_id} = 1 AND LEFT(${customer.customer_name},7) <> 'Covenir'
      AND CAST(create_time as time) BETWEEN '08:00:00.0000000' AND '19:59:59.9999999' ;;

  #fields: []
  #always_filter: {}
  #always_join: []

  join: channel_type {
    type: inner
    relationship: many_to_one
    from: "channel_type"
    sql_table_name: pho.ChannelType ;;
    view_label: "Call/Chat Characteristics"
    sql_on: ${phone_log.channeltype_id} = ${channel_type.channeltype_id} ;;
  }

  join: media_type {
    type: inner
    relationship: many_to_one
    from: "media_type"
    sql_table_name: pho.MediaType ;;
    view_label: "Call/Chat Characteristics"
    sql_on: ${phone_log.mediatype_id} = ${media_type.mediatype_id} ;;
  }

  join: queue_type {
    type: inner
    relationship: many_to_one
    from: "queue_type"
    sql_table_name: pho.QueueType ;;
    view_label: "Call/Chat Characteristics"
    sql_on: ${phone_log.queuetype_id} = ${queue_type.queuetype_id} ;;
  }

  join: direction_type {
    type: inner
    relationship: many_to_one
    from: "direction_type"
    sql_table_name: pho.DirectionType ;;
    view_label: "Call/Chat Characteristics"
    sql_on: ${phone_log.directiontype_id} = ${direction_type.directiontype_id} ;;
  }

  join: call_type {
    type: inner
    relationship: many_to_one
    from: "call_type"
    sql_table_name: pho.CallType ;;
    view_label: "Call/Chat Characteristics"
    sql_on: ${phone_log.calltype_id} = ${call_type.calltype_id} ;;
  }

  join: customer {
    type: inner
    relationship: many_to_one
    from: "customer"
    sql_table_name: dbo.customer ;;
    view_label: "Customer"
    sql_on: ${channel_type.customer_id} = ${customer.customer_id} ;;
  }

  join: users {
    type: inner
    relationship: many_to_one
    from: "users"
    sql_table_name: dbo.users ;;
    view_label: "CSR"
    sql_on: ${phone_log.users_id} = ${users.users_id} ;;
    sql_where: ${phone_log.users_id} <> 0  ;;
    }

  join: user_type {
    type: left_outer
    relationship: many_to_one
    from: "user_type"
    sql_table_name: dbo.usertype ;;
    view_label: "CSR"
    sql_on: ${users.usertype_id} = ${user_type.usertype_id} ;;
  }
}
