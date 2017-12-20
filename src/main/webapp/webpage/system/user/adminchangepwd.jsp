<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
<link id="easyuiTheme" rel="stylesheet"
	href="plug-in/easyui/themes/default/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="plug-in/easyui/themes/icon.css"
	type="text/css"></link>
<link rel="stylesheet" type="text/css"
	href="plug-in/accordion/css/accordion.css">
<link href="plug-in/chrhc/bootstrap.css" rel="stylesheet">
<link href="plug-in/chrhc/style.css" rel="stylesheet">
<link href="plug-in/icheck/skin/square/blue.css" rel="stylesheet">
<script type="text/javascript"
	src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script>
<script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/syUtil.js"></script>
<script type="text/javascript"
	src="plug-in/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script>
<link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css"
	type="text/css"></link>
<script type="text/javascript"
	src="plug-in/uploadify/jquery.uploadify-3.1.js"></script>
<script type="text/javascript" src="plug-in/tools/Map.js"></script>
<script src="plug-in/chrhc/bootstrap.min.js"></script>
<script src="plug-in/chrhc/ie8/html5.js"></script>
<script src="plug-in/chrhc/ie8/respond.min.js"></script>
<script src="plug-in/icheck/icheck.js"></script>
<script src="plug-in/chrhc/jquery.tabs.js"></script>
<script src="plug-in/chrhc/jquery.lazyload.js"></script>
<script src="plug-in/Validform/js/Validform_v5.3.1.js" type="text/javascript"></script>
<link rel="stylesheet" href="plug-in/chrhc/currentPosition.css" type="text/css"></link>
</head>
<body>
<div class="Current_position">
		<img src="plug-in/media/image/dingwei.png"/><span>当前所在的位置：</span>
		<a href="javascript:;">系统管理</a>&nbsp;>
     	 <a href="javascript:;">用户管理</a>&nbsp;>
     	 <a href="javascript:;">密码重置</a>
    </div>
<t:formvalid formid="formobj" refresh="false" dialog="true" action="userController.do?savenewpwdforuser" usePlugin="password" layout="table">
<div class="container form-card">		
		<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<input id="id" type="hidden" name="id" value="${user.id }">
						<label class="control-label" for="password"><t:mutiLang langKey="common.password"/>:</label> 
						<input type="password" name="password" class="form-control w260" value="" datatype="*6-18" errormsg="">
						<span class="passwordStrength" style="display: none;"><span><t:mutiLang langKey="common.weak"/></span>
						<span><t:mutiLang langKey="common.middle"/></span>
						<span class="last"><t:mutiLang langKey="common.strong"/></span> </span> 
						<span class="Validform_checktip"><t:mutiLang langKey="password.rang6to18"/></span>
					</div>
				</div>				
		</div>
		<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<label class="control-label" for="password"><t:mutiLang langKey="common.repeat.password"/>:</label> 
						<input id="repassword" type="password" name="password" recheck="password" class="form-control w260" value="" datatype="*6-18" errormsg="两次输入的密码不一致！">
						<span class="Validform_checktip"><t:mutiLang langKey="common.repeat.password"/></span>
					</div>
				</div>				
		</div>
		<div class="row" id="buttonPanel">
				<div class="col-md-8 center">
					<button type="submit" class="btn btn-sure">确定</button>
          			<button type="button" class="btn btn-cancel" onclick="closeCurrentTab()">关闭</button>
				</div>
		</div>
</div>
</t:formvalid>
<script type="text/javascript">
$(document).ready(function(){
	//********************************表单验证 开始******************************************
    $(".valideForm").Validform({
      tiptype:2
    });
    //********************************表单验证 结束******************************************
	
	$("#formobj").attr({"class":"form-inline valideForm"});
});

var neibuClickFlag = false;
function neibuClick() {
	  neibuClickFlag = true;
	  $('#btn_sub').trigger('click');
}
function uploadFile(data){
	 debugger;
		if(!$("input[name='id']").val()){
			$("input[name='id']").val(data.obj.id);
		}
		if($(".uploadify-queue-item").length>0){
			upload();
		}else{
			if (neibuClickFlag){
				alert(data.msg);
				neibuClickFlag = false;
			}else {
			//getParentWindow();
				//alert(getParentWindow().document.body.innerHTML);
	  			var win = getParentWindow();
	  			if(win)
		  		{
	  				win.reloadTable(data);
					win.tip(data.msg);
		  		}
				
				if(frameElement.api)
				{
					frameElement.api.close();
				}
				else
				{
					closeCurrentTab();
				}
			}
		}
	}

</script>
</body>
</html>