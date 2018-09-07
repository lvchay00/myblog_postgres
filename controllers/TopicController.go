package controllers

import (
	"myblog_postgres/filters"
	"myblog_postgres/models"
	"strconv"

	"github.com/astaxie/beego"

	_"errors"
	"io"
	_"net/http"
	"os"
	"path"
	"strings"
)

type TopicController struct {
	beego.Controller
}
//上传文件接口
func (c *TopicController) Uploade() {
	req := c.Ctx.Request
	req.ParseForm()

		// 接收文件
		uploadFile, handle, err := req.FormFile("file")
		if err != nil {	
			c.Data["output"]=	 "接收文件失败"
			return
		}
		filepath := c.Input().Get("path")
		filepath1 := "./" + filepath + "/"

		// 保存文件
		os.Mkdir(filepath1, 0777)
		saveFile, err := os.OpenFile(filepath1+handle.Filename, os.O_WRONLY|os.O_CREATE, 0666)
		if err != nil {
			c.Data["output"]=	"文件创建失败"
			return
		}
		_,err=io.Copy(saveFile, uploadFile)
		if err != nil {
			c.Data["output"]=	"文件创建失败"
			return
		}

		defer uploadFile.Close()
		defer saveFile.Close()
		// 检查图片后缀
		ext := strings.ToLower(path.Ext(handle.Filename))
		if ext == ".jpg" || ext == ".png" {
			c.Data["output"]=	 filepath + "/"+handle.Filename +"上传成功  "
			// 上传图片成功
			
		}else{
			c.Data["output"]=	 filepath + "/"+handle.Filename +"上传成功  "
		}
		c.Layout = "layout/layout.tpl"
		c.TplName = "topic/create.tpl"
	return
}
func (c *TopicController) Create() {
	beego.ReadFromRequest(&c.Controller)
	c.Data["IsLogin"], c.Data["UserInfo"] = filters.IsLogin(c.Controller.Ctx)
	c.Data["PageTitle"] = "发布话题"
	c.Data["Sections"] = models.FindAllSection()
	c.Layout = "layout/layout.tpl"
	c.TplName = "topic/create.tpl"
}

func (c *TopicController) Save() {
	flash := beego.NewFlash()
	title, content, sid := c.Input().Get("title"), c.Input().Get("content"), c.Input().Get("sid")
	if len(title) == 0 || len(title) > 120 {
		flash.Error("话题标题不能为空且不能超过120个字符")
		flash.Store(&c.Controller)
		c.Redirect("/topic/create", 302)
	} else if len(sid) == 0 {
		flash.Error("请选择话题版块")
		flash.Store(&c.Controller)
		c.Redirect("/topic/create", 302)
	} else {
		s, _ := strconv.Atoi(sid)
		section := models.Section{Id: s}
		_, user := filters.IsLogin(c.Ctx)
		topic := models.Topic{Title: title, Content: content, Section: &section, User: &user}
		id := models.SaveTopic(&topic)
		c.Redirect("/topic/"+strconv.FormatInt(id, 10), 302)
	}
}

func (c *TopicController) Detail() {
	id := c.Ctx.Input.Param(":id")
	tid, _ := strconv.Atoi(id)
	if tid > 0 {
		c.Data["IsLogin"], c.Data["UserInfo"] = filters.IsLogin(c.Controller.Ctx)
		topic := models.FindTopicById(tid)
		models.IncrView(&topic) //查看+1
		c.Data["PageTitle"] = topic.Title
		c.Data["Topic"] = topic
		c.Data["Replies"] = models.FindReplyByTopic(&topic)
		c.Layout = "layout/layout.tpl"
		c.TplName = "topic/detail.tpl"
	} else {
		c.Ctx.WriteString("话题不存在")
	}
}

func (c *TopicController) Edit() {
	beego.ReadFromRequest(&c.Controller)
	id, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	if id > 0 {
		topic := models.FindTopicById(id)
		c.Data["IsLogin"], c.Data["UserInfo"] = filters.IsLogin(c.Controller.Ctx)
		c.Data["PageTitle"] = "编辑话题"
		c.Data["Sections"] = models.FindAllSection()
		c.Data["Topic"] = topic
		c.Layout = "layout/layout.tpl"
		c.TplName = "topic/edit.tpl"
	} else {
		c.Ctx.WriteString("话题不存在")
	}
}

func (c *TopicController) Update() {
	flash := beego.NewFlash()
	id, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	title, content, sid := c.Input().Get("title"), c.Input().Get("content"), c.Input().Get("sid")
	if len(title) == 0 || len(title) > 120 {
		flash.Error("话题标题不能为空且不能超过120个字符")
		flash.Store(&c.Controller)
		c.Redirect("/topic/edit/"+strconv.Itoa(id), 302)
	} else if len(sid) == 0 {
		flash.Error("请选择话题版块")
		flash.Store(&c.Controller)
		c.Redirect("/topic/edit/"+strconv.Itoa(id), 302)
	} else {
		s, _ := strconv.Atoi(sid)
		section := models.Section{Id: s}
		topic := models.FindTopicById(id)
		topic.Title = title
		topic.Content = content
		topic.Section = &section
		models.UpdateTopic(&topic)
		c.Redirect("/topic/"+strconv.Itoa(id), 302)
	}
}

func (c *TopicController) Delete() {
	id, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	if id > 0 {
		topic := models.FindTopicById(id)
		models.DeleteTopic(&topic)

		c.Redirect("/", 302)
	} else {
		c.Ctx.WriteString("话题不存在")
	}
}
