<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/7/4
  Time: 21:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="plug-in/artDiglog/artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="plug-in/artDiglog/iframeTool.js"></script>
</head>
<body>
<input id="path" value="${path}" hidden/>
<audio src="HlSoundRecordController.do?download&path=${path}" controls="controls">
    Your browser does not support the audio element.
</audio>
</body>
</html>
