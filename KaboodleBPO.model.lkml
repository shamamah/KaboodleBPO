label: "Kaboodle BPO"
connection: "bpo"

include: "*.view"
include: "*.dashboard"

fiscal_month_offset: 0
persist_for: "30 minutes"


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
}


explore: postage_meter_data {
  description: "BPO's postage usage measure"
  label: "Postage Meter"
  group_label: "BPO: Print & Distribution"
  view_label: "Postage Usage"
  persist_for: "4 hours"
  from: postage_meter_data
  view_name: postage_meter_data
  sql_table_name: dbo.MeterData ;;

  access_filter: {
    field:customer.customer_name
    user_attribute:company_name
  }

  join: meter_account {
    type: inner
    sql_on: ${postage_meter_data.meteraccount_id} = ${meter_account.meteraccount_id} ;;
    relationship: many_to_one
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
    sql_on: ${postage_meter_data.mailclasstype_id} = ${mail_class_type.mailclasstype_id} ;;
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
    sql_on: ${postage_meter_data.meteraccount_id} = ${unused_postage.meteraccount_id} ;;
  }

  join: unused_postage_type {
    type: inner
    relationship: many_to_one
    from: unused_postage_type
    sql_table_name: dbo.unused_postage_type ;;
    view_label: "Unused Postage Type"
    #required_joins: []
    #foreign_key:
    sql_on: ${unused_postage.unusedpostagetype_id} = ${unused_postage_type.unusedpostagetype_id} ;;
  }
}
