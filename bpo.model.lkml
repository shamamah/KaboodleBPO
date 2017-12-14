connection: "bpo"

# include all the views
include: "*.view"


# include all the dashboards
include: "*.dashboard"


# table Customer; No linked tables (Verified)
#explore: customer {
#  access_filter: {
#    field:customer.customer_name
#    user_attribute:customer
#  }
#}


# table CustomerService; linked to tables Customer, ServiceType (Verified)
#explore: customer_service {
#  access_filter: {
#    field:customer.customer_name
#   user_attribute:customer
#  }
#  join: customer {
#    type: left_outer
#    sql_on: ${customer_service.customer_id} = ${customer.customer_id} ;;
#    relationship: many_to_one
#  }

#  join: service_type {
#    type: left_outer
#    sql_on: ${customer_service.servicetype_id} = ${service_type.servicetype_id} ;;
#    relationship: many_to_one
#  }
#}


# table CustomerServiceJob; linked to tables ServiceJobType, CustomerService, Customer, Service_Type (Verified)
#explore: customer_service_job {
#  join: service_job_type {
#    type: left_outer
#    sql_on: ${customer_service_job.servicejobtype_id} = ${service_job_type.servicejobtype_id} ;;
#    relationship: many_to_one
#  }

#  join: customer_service {
#    type: left_outer
#    sql_on: ${customer_service_job.customerservice_id} = ${customer_service.customerservice_id} ;;
#    relationship: many_to_one
# }

#  join: customer {
#    type: left_outer
#    sql_on: ${customer_service.customer_id} = ${customer.customer_id} ;;
#    relationship: many_to_one
#  }

#  join: service_type {
#    type: left_outer
#    sql_on: ${customer_service.servicetype_id} = ${service_type.servicetype_id} ;;
#    relationship: many_to_one
#  }
#}


# table CustomerServiceLevelAgreement; linked to tables IntervalType, CustomerServiceJob, CustomerService, Customer, ServiceType, ServiceJobType (Verified)
explore: customer_service_level_agreement {
  group_label: "OLD: To Be Removed"
  hidden: yes
  access_filter: {
    field:customer.customer_name
    user_attribute:customer
  }
  label: "SLA Data"
  view_label: "Customer SLA"
  join: customer_service_job{
    type: inner
    sql_on: ${customer_service_job.customerservicejob_id} = ${customer_service_level_agreement.customerservicejob_id} ;;
    relationship: one_to_one
  }

  join: interval_type {
    view_label: "Customer SLA"
    type: inner
    sql_on: ${customer_service_level_agreement.intervaltype_id} = ${interval_type.intervaltype_id} ;;
    relationship: many_to_one
  }

  join: customer_service {
    view_label: "Customer SLA"
    type: inner
    sql_on: ${customer_service_job.customerservice_id} = ${customer_service.customerservice_id} ;;
    relationship: many_to_one
  }

  join: customer {
    view_label: "Customer SLA"
    type: inner
    sql_on: ${customer_service.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: service_type {
    view_label: "Customer SLA"
    type: inner
    sql_on: ${customer_service.servicetype_id} = ${service_type.servicetype_id} ;;
    relationship: many_to_one
  }

  join: service_job_type {
    view_label: "Customer SLA"
    type: inner
    sql_on: ${customer_service_job.servicejobtype_id} = ${service_job_type.servicejobtype_id} ;;
    relationship: many_to_one
  }
  join: sla {
    view_label: "Customer SLA"
    type: inner
    sql_on:  ${sla.customer_id} = ${customer.customer_id}
    and ${sla.service_job_type_id} = ${service_job_type.servicejobtype_id}
    and ${sla.customer_service_job_id} =  ${customer_service_level_agreement.customerservicejob_id}
    and ${sla.service_type_id} = ${service_type.servicetype_id} ;;
    relationship: many_to_one
  }

  join: print_batch {
    view_label: "Print Batch"
    type: inner
    sql_on: ${print_batch.customer_id} = ${customer.customer_id}
    and ${print_batch.servicejobtype_id} = ${customer_service_job.servicejobtype_id};;
    relationship: many_to_one
}
  join: v_print_batch_delayed {
    view_label: "Print Batch"
    type: left_outer
    relationship: many_to_one
    sql_on: ${v_print_batch_delayed.batch_id} = ${print_batch.printbatch_id}
    and ${v_print_batch_delayed.customer_id} = ${print_batch.customer_id}
    and ${v_print_batch_delayed.service_job_type_id} = ${print_batch.servicejobtype_id};;
  }
  join: users {
    view_label: "Print Batch"
    type: inner
    sql_on: ${print_batch.users_id} = ${users.users_id} ;;
    relationship: many_to_one
  }

  join: print_batch_status {
    view_label: "Print Batch"
    type: inner
    sql_on: ${print_batch.printbatchstatus_id} = ${print_batch_status.printbatchstatus_id} ;;
    relationship: many_to_one
  }
  join: print_batch_detail {
  view_label: "Print Batch Detail"
  type: inner
  sql_on: ${print_batch.printbatch_id} = ${print_batch_detail.printbatch_id} ;;
  relationship: one_to_many
  }
  join: user_type {
  view_label: "Print Batch"
  type: inner
  sql_on: ${users.usertype_id} = ${user_type.usertype_id} ;;
  relationship: many_to_one
}

  join: station_type {
    view_label: "Print Batch Detail"
    type: inner
    sql_on: ${print_batch_detail.stationtype_id} = ${station_type.stationtype_id} ;;
    relationship: many_to_one
  }
#}

#table PrintBatchDetail; Linked to tables Users, PrintBatch, Customer, StationType, PrintBatchStatus, UserType (Verified)
#explore: print_batch_detail {
#  access_filter: {
#    field:customer.customer_name
#    user_attribute:customer
# }






# table Users; Linked to table UserType (Verified)
#explore: users {}


#table: PrintBatch; Linked to tables Customer, Users, ServiceJobType, PrintBatchStatus (Verified)
#explore: print_batch {
#  access_filter: {
#    field:customer.customer_name
#    user_attribute:customer
#  }


#}
}

# table: IntervalType; No linked tables (Verified)
#explore: interval_type {}


# table: MailClassType; No linked tables (Verified)
#explore: mail_class_type {}


# table: MeterAccount; linked to table Customer (Verified)
#explore: meter_account {
#  join: customer {
#    type: left_outer
#    sql_on: ${meter_account.customer_id} = ${customer.customer_id} ;;
#    relationship: many_to_one
#  }
#}


# table: MeterData; Linked to tables MailClassType, MeterAccount, Customer (Verified)
explore: meter_data {
  group_label: "OLD: To Be Removed"
  hidden: yes
  join: mail_class_type {
    type: inner
    sql_on: ${meter_data.mailclasstype_id} = ${mail_class_type.mailclasstype_id} ;;
    relationship: many_to_one
  }

  join: meter_account {
    type: inner
    sql_on: ${meter_data.meteraccount_id} = ${meter_account.meteraccount_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: inner
    sql_on: ${meter_account.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }
}

# table PrintBatchStatus; No linked tables (Verified)
#explore: print_batch_status {}


# table ServiceJobType; No linked tables (Verified)
#explore: service_job_type {}


# table ServiceType; No linked tables (Verified)
#explore: service_type {}


# table StationType; No linked tables (Verified)
#explore: station_type {}


# table UserType; No linked tables (Verified)
#explore: user_type {}
