package routers

import (
	"myblog_postgres/controllers"
	"myblog_postgres/filters"

	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.IndexController{}, "GET:Index")
	beego.Router("/login", &controllers.IndexController{}, "GET:LoginPage")
	beego.Router("/login", &controllers.IndexController{}, "POST:Login")
	beego.Router("/register", &controllers.IndexController{}, "GET:RegisterPage")
	beego.Router("/register", &controllers.IndexController{}, "POST:Register")
	beego.Router("/logout", &controllers.IndexController{}, "GET:Logout")
	beego.Router("/about", &controllers.IndexController{}, "GET:About")

	beego.Router("/topic/create", &controllers.TopicController{}, "GET:Create")
	beego.Router("/topic/create", &controllers.TopicController{}, "POST:Save")
	beego.Router("/topic/create/Uploade", &controllers.TopicController{}, "Post:Uploade")

	beego.Router("/topic/:id([0-9]+)", &controllers.TopicController{}, "GET:Detail")
	beego.Router("/topic/edit/:id([0-9]+)", &controllers.TopicController{}, "GET:Edit")
	beego.Router("/topic/edit/:id([0-9]+)", &controllers.TopicController{}, "POST:Update")

	beego.Router("/topic/delete/:id([0-9]+)", &controllers.TopicController{}, "GET:Delete")
	beego.Router("/reply/up", &controllers.ReplyController{}, "GET:Up")
	beego.Router("/reply/save", &controllers.ReplyController{}, "POST:Save")
	beego.Router("/reply/delete/:id([0-9]+)", &controllers.ReplyController{}, "GET:Delete")

	beego.Router("/user/:username", &controllers.UserController{}, "GET:Detail")
	beego.Router("/user/setting", &controllers.UserController{}, "GET:ToSetting")
	beego.InsertFilter("/user/setting", beego.BeforeRouter, filters.FilterUser)
	beego.Router("/user/setting", &controllers.UserController{}, "POST:Setting")
	beego.InsertFilter("/user/updatepwd", beego.BeforeRouter, filters.FilterUser)
	beego.Router("/user/updatepwd", &controllers.UserController{}, "POST:UpdatePwd")
	beego.InsertFilter("/user/updateavatar", beego.BeforeRouter, filters.FilterUser)
	beego.Router("/user/updateavatar", &controllers.UserController{}, "POST:UpdateAvatar")

	beego.Router("/user/list", &controllers.UserController{}, "GET:List")
	beego.Router("/user/delete/:id([0-9]+)", &controllers.UserController{}, "GET:Delete")

	beego.Router("/user/edit/:id([0-9]+)", &controllers.UserController{}, "GET:Edit")
	beego.Router("/user/edit/:id([0-9]+)", &controllers.UserController{}, "POST:Update")
	
	beego.Router("/AddClass", &controllers.AddClassController{}, "GET:Index")
	beego.Router("/AddClass/Add", &controllers.AddClassController{},"Post:Add")
	beego.Router("/AddClass/Delete", &controllers.AddClassController{}, "Post:Delete")

	
	beego.Router("/up", &controllers.FileController{},"GET:UploadHandle")    // 上传
	beego.Router("/up", &controllers.FileController{},"Post:UploadHandle")    // 上传
	beego.Router("/uploaded/", &controllers.FileController{},"GET:ShowPicHandle") //显示图片

}
