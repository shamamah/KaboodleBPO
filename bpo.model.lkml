connection: "bpo"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

# table Customer
explore: customer {}

# table CustomerService; linked to tables Customer and ServiceType
explore: customer_service {
  join: customer {
    type: left_outer
    sql_on: ${customer_service.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: service_type {
    type: left_outer
    sql_on: ${customer_service.servicetype_id}_id} = ${service_type.servicetype_id} ;;
    relationship: many_to_one
  }
}

# table CustomerServiceJob; linked to tables ServiceJobType, CustomerService, and Customer
explore: customer_service_job {
  join: service_job_type {
    type: left_outer
    sql_on: ${customer_service_job.servicejobtype_id} = ${service_job_type.servicejobtype_id} ;;
    relationship: many_to_one
  }

  join: customer_service {
    type: left_outer
    sql_on: ${customer_service_job.customerservice_id} = ${customer_service.customerservice_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${customer_service.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }
}

# table CustomerServiceLevelAgreement; linked to tables IntervalType, CustomerServiceJob, CustomerService, Customer
explore: customer_service_level_agreement {
  join: customer_service_job{
    type: left_outer
    sql_on: ${customer_service_job.customerservicejob_id} = ${customer_service_level_agreement.customerservicejob_id} ;;
    relationship: one_to_one
  }

  join: interval_type {
    type: left_outer
    sql_on: ${customer_service_level_agreement.intervaltype_id} = ${interval_type.intervaltype_id} ;;
    relationship: many_to_one
  }

  join: customer_service {
    type: left_outer
    sql_on: ${customer_service_job.customerservice_id} = ${customer_service.customerservice_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${customer_service.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: service_type {
    type: left_outer
    sql_on: ${customer_service.servicetype_id} = ${service_type.servicetype_id} ;;
    relationship: many_to_one
  }

  join: service_job_type {
    type: left_outer
    sql_on: ${customer_service_job.servicejobtype_id} = ${service_job_type.servicejobtype_id} ;;
    relationship: many_to_one
  }
}

explore: interval_type {}

explore: mail_class_type {}

explore: meter_account {
  join: customer {
    type: left_outer
    sql_on: ${meter_account.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }
}

explore: meter_data {
  join: mail_class_type {
    type: left_outer
    sql_on: ${meter_data.mailclasstype_id} = ${mail_class_type.mailclasstype_id} ;;
    relationship: many_to_one
  }

  join: meter_account {
    type: left_outer
    sql_on: ${meter_data.meteraccount_id} = ${meter_account.meteraccount_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${meter_account.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }
}

explore: print_batch {
  join: customer {
    type: left_outer
    sql_on: ${print_batch.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${print_batch.users_id} = ${users.users_id} ;;
    relationship: many_to_one
  }
}

explore: print_batch_detail {
  join: users {
    type: left_outer
    sql_on: ${print_batch_detail.users_id} = ${users.users_id} ;;
    relationship: many_to_one
  }
}

explore: print_batch_status {}

explore: service_job_type {}

explore: service_type {}

explore: station_type {}

explore: user_type {}

explore: users {
  join: user_type {
    type: left_outer
    sql_on: ${users.usertype_id} = ${user_type.usertype_id} ;;
    relationship: many_to_one
  }
}
