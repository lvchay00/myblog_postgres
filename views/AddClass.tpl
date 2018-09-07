<html>
<head>
<title></title>
</head>
<body>
<form action="/AddClass/Add" method="post">
  <div>
	  <input type="text" name="name">
    <input type="submit" value="添加">	
  </div>
</form>
	 <p>       </p> 	
<form action="/AddClass/Delete" method="post">
	 <div class="form-group">
            <select name="sid" id="sid" class="form-control" width =50 >
              {{range .Sections}}
                <option value="{{.Id}}">{{.Name}}   </option>
              {{end}}
            </select>
			<input type="submit" value="删除">	
     </div>	
</form>
<div class="panel-heading"><a href="/">返回主页</a></div>   
</body>
</html>