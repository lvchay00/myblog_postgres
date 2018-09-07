package main

import (
	"fmt"
	"myblog_postgres/models"
	_ "myblog_postgres/routers"
	_ "myblog_postgres/templates"
	_ "myblog_postgres/utils"

	_ "github.com/lib/pq"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

func init() {
	orm.RegisterDataBase("default", "postgres", "user=dbuser password=123456  dbname=exampledb host=104.224.163.70 port=5432 sslmode=disable")
	orm.RegisterModel(
		new(models.User),
		new(models.Topic),
		new(models.Section),
		new(models.Reply), new(models.ReplyUpLog))
	orm.RunSyncdb("default", false, true)
}

func main() {
	// var user = models.User{
	// 	Id:       2,
	// 	Username: "xxxxxx",
	// 	Password: "xxxxxx",
	// }
	// models.SaveUser(&user)
	fmt.Println("start")
	beego.Run()
}
