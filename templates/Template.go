package utils

import (
    "time"
    "github.com/xeonx/timeago"
    "github.com/russross/blackfriday"
    "github.com/astaxie/beego"
 _   "myblog_postgres/models"
    "myblog_postgres/utils"
)

func FormatTime(time time.Time) string {
    return timeago.Chinese.Format(time)
}

func Markdown(content string) string {
    return string(blackfriday.MarkdownCommon([]byte(utils.NoHtml(content))))
}



func init() {
    beego.AddFuncMap("timeago", FormatTime)
    beego.AddFuncMap("markdown", Markdown)

}