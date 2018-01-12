view: sla_group_type {

    sql_table_name: dbo.SLAGroupType ;;

    dimension: dscr {
      type: string
      label: "Service Group Description"
      sql: ${TABLE}.dscr ;;
      #html: <img src=”https://static1.squarespace.com/static/58dbd3ce579fb3ddac6806c1/t/5915ba3e197aeaf7d1c4368b/1494596164263/CLoud+graphic.png?format=300w” /> ;;
    }

    dimension: slagrouptype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.slagrouptype_id ;;
    }

    measure: count {
      type: count
      hidden: yes
      #html:  <a href="/explore/model/explore_name?fields=view.field_1,view.field_2,view.field_3&f[view.filter_1]={{ value }}&pivots=view.field_2">{{ value }}</a> ;;
      drill_fields: []
    }
  }
