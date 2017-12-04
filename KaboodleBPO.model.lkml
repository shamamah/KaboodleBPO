connection: "bpo"

# include all the views
include: "*.view"


# include all the dashboards
include: "*.dashboard"

# table CustomerServiceLevelAgreement; linked to tables IntervalType, CustomerServiceJob, CustomerService, Customer, ServiceType, ServiceJobType (Verified)
explore: print_and_distribution {

  label: "Actual vs SLA"

  access_filter: {
    field:customer.customer_name
    user_attribute:company_name
  }
  persist_for: "4 hours"

  join: customer {
    view_label: "Company"
    type: inner
    sql_on: ${print_and_distribution.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: service_type {
    type: inner
    sql_on: ${print_and_distribution.service_type_id} = ${service_type.servicetype_id} ;;
    relationship: many_to_one
  }

  join: service_job_type {
    type: inner
    sql_on: ${print_and_distribution.service_job_type_id} = ${service_job_type.servicejobtype_id} ;;
    relationship: many_to_one
  }

  join: sla_group_type {
    type: inner
    sql_on: ${service_job_type.slagrouptype_id} = ${sla_group_type.slagrouptype_id};;
    relationship: many_to_one

  }
}

explore: postage_meter_data {

  label: "Postage Meter"

  access_filter: {
    field:customer.customer_name
    user_attribute:company_name
  }
  persist_for: "4 hours"

  join: meter_account {
    type: inner
    sql_on: ${postage_meter_data.meteraccount_id} = ${meter_account.meteraccount_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: inner
    sql_on: ${meter_account.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: mail_class_type {
    type: inner
    sql_on: ${postage_meter_data.mailclasstype_id} = ${mail_class_type.mailclasstype_id} ;;
    relationship: many_to_one
  }

  join: sla_group_type {
    type: inner
    sql_on: ${meter_account.meteraccount_id} = ${sla_group_type.slagrouptype_id} ;;
    relationship: many_to_one
  }
}
