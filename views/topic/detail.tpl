<div class="row">
  <div class="col-md-12">
    <div class="panel panel-default">
      <div class="panel-body topic-detail-header">
        <div class="media">
          <div class="media-body">
            <h2 class="topic-detail-title">{{.Topic.Title}}</h2>
            <p class="gray">
              <span class="label label-primary">{{.Topic.Section.Name}}</span>

              {{if .IsLogin}}
              <span>•</span>
              <span><a href="/user/{{.Topic.User.Username}}">{{.Topic.User.Username}}</a></span>
              {{end}}
              
              <span>•</span>
              <span>{{.Topic.InTime | timeago}}</span>
              <span>•</span>
              <span>{{.Topic.View}}次点击</span>
              <span>•</span>
              <span>来自 <a href="/?s={{.Topic.Section.Id}}">{{.Topic.Section.Name}}</a></span>
 {{if .IsLogin}}
                <span>•</span>
                <span><a href="/topic/edit/{{.Topic.Id}}">编辑</a></span>


                <span>•</span>
                <span><a href="javascript:if(confirm('确定删除吗?')) location.href='/topic/delete/{{.Topic.Id}}'">删除</a></span>
{{end}}
            </p>
          </div>
          <div class="media-right">
          </div>
        </div>
      </div>
      <div class="divide"></div>
      <div class="panel-body topic-detail-content">
        {{str2html (.Topic.Content | markdown)}}
      </div>
    </div>
    {{if eq .Topic.ReplyCount 0}}
    <div class="panel panel-default">
      <div class="panel-body text-center">目前暂无回复</div>
    </div>
    {{else}}
    <div class="panel panel-default">
      <div class="panel-heading">{{.Topic.ReplyCount}} 条回复</div>
      <div class="panel-body paginate-bot">
        {{range .Replies}}
        <div class="media">
          <div class="media-left">
            <a  class="avatar" alt="{{.User.Username}}"></a>
          </div>
          <div class="media-body reply-content">
            <div class="media-heading gray">
              <a href="/user/{{.User.Username}}">{{.User.Username}} </a>
              <span>{{.InTime | timeago}}</span>
              <span class="pull-right">
                {{if $.IsLogin}}<a href="javascript:if(confirm('确定删除吗?')) location.href='/reply/delete/{{.Id}}'">删除</a>{{end}}
                <a href="javascript:up('{{.Id}}');"><span class="glyphicon glyphicon-thumbs-up"></span></a>
                <span id="up_{{.Id}}">{{.Up}}赞</span>
              </span>
            </div>
            {{str2html (.Content | markdown)}}
          </div>
        </div>
        <div class="divide mar-top-5"></div>
        {{end}}
      </div>
    </div>
    {{end}}

    <div class="panel panel-default">
      <div class="panel-heading">
        添加一条新回复
      </div>
      <div class="panel-body">
        <form action="/reply/save" method="post">
          <input type="hidden" value="{{.Topic.Id}}" name="tid">
          <div class="form-group">
            <textarea name="content" rows="5" class="form-control" placeholder="支持Markdown语法哦~"></textarea>
          </div>
          <button type="submit" class="btn btn-default">回复</button>
        </form>
      </div>
    </div>

  </div>
 
</div>
<script type="text/javascript">
  function up(id) {
    
      $.ajax({
        url: "/reply/up",
        async: true,
        cache: false,
        type: "get",
        dataType: "json",
        data: {rid: id},
        success: function (data) {
          if(data.Code == 200) {
            var upele = $("#up_" + id);
            upele.text(parseInt(upele.text()) + 1);
          } else {
            alert(data.Description)
          }
        }
      });
    
  }
</script>