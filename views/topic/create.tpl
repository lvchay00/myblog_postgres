<div class="row">
  <div class="col-md-9">
    <div class="panel panel-default">
      <div class="panel-heading">
        <a href="/">主页</a> / 发布话题
      </div>
      <div class="panel-body">
        {{template "../components/flash_error.tpl" .}}
        <form method="post" action="/topic/create">
            <div class="form-group">
              <label for="title">标题</label>
               <input type="text" class="form-control" id="title" name="title" placeholder="标题">
            </div>
             <div class="form-group">
               <label for="title">内容</label>
               <textarea name="content" id="content" rows="15" class="form-control" placeholder="支持Markdown语法哦~"></textarea>
              </div>
             <div class="form-group">
               <label for="title">版块</label>
               <select name="sid" id="sid" class="form-control">
               {{range .Sections}}
                <option value="{{.Id}}">{{.Name}}</option>
               {{end}}
                 </select>
                 </div>
                <button type="submit" class="btn btn-default">发布</button>
            </form>
            </div>    
            <form method="post"  action="/topic/create/Uploade"  enctype="multipart/form-data">             
            <label for="title">上传文件</label>
              <p>  </p>
		       文件目录：<input type="text" name="path" value="static/blog" />	     	
            <input type="file" name="file" />
            <input type="submit" />
            <label for="title">{{.output}}</label>
        </form>
    </div>

  </div>

  <div class="col-md-3 hidden-sm hidden-xs">
    {{if .IsLogin}}
      {{template "components/user_info.tpl" .}}
    {{else}}
      {{template "components/welcome.tpl" .}}
    {{end}}
      {{template "components/otherbbs.tpl" .}}
  </div>

</div>