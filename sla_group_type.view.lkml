view: sla_group_type {

    sql_table_name: dbo.SLAGroupType ;;

    dimension: dscr {
      type: string
      label: "Service Group Description"
      sql: ${TABLE}.dscr ;;
    }

    dimension: slagrouptype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.slagrouptype_id ;;
    }

    measure: count {
      type: count
      hidden: yes
      drill_fields: []
    }
  }
