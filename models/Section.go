package models

import (
	"github.com/astaxie/beego/orm"
)

type Section struct {
	Id   int `orm:"pk;auto"`
	Name string `orm:"unique"`
}

func FindAllSection() []*Section {
	o := orm.NewOrm()
	var section Section
	var sections []*Section
	o.QueryTable(section).OrderBy("id").All(&sections)
	return sections
}
func InsertSection(section *Section) int64 {
	o := orm.NewOrm()
	id, _ := o.Insert(section)
	return id
}
func DeleteSection(section *Section)  {
	o := orm.NewOrm()
	o.Delete(section)
}
