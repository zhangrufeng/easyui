<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
</head>
<body>
   <form action="" method="post">
      <div>
         <label for="name">Name:</label>
         <input type="text" id="name" class="easyui-validatebox" data-options="required:true">
      </div>
      <div>
         <label for="email">Email:</label>
         <input type="text" id="email" class="easyui-validatebox" data-options="required:true">
      </div>
   </form>
</body>
</html>