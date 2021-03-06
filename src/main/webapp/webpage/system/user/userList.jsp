<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<link rel="stylesheet" href="plug-in/chrhc/currentPosition.css" type="text/css"></link>
<style type="text/css"> 
.datagrid .datagrid-pager {
  margin-top: -44px;
}
 </style>
<%--update-start--Author:zhangguoming  Date:20140827 for：添加 组织机构查询条件--%>
<script>
    $(function() {
        var datagrid = $("#userListtb");
        datagrid.find("div[name='searchColums']").append($("#tempSearchColums div[name='searchColums']").html());
    });
</script>
<div class="Current_position">
    	<img src="plug-in/media/image/dingwei.png"/><span>当前所在的位置：</span>
		<a href="javascript:;">系统管理</a>&nbsp;>
     	 <a href="javascript:;">用户管理</a>
    </div>
<div id="tempSearchColums" style="display: none">
    <div name="searchColums">
        <span style="display:-moz-inline-box;display:inline-block;">
            <span style="vertical-align:middle;display:-moz-inline-box;display:inline-block;width: 80px;text-align:right;" title="<t:mutiLang langKey="common.department"/>">
                <t:mutiLang langKey="common.department"/>：
            </span>
            <input id="orgIdss" name="orgIdss" type="hidden">
            <input readonly="true" type="text" name="departname" style="width: 100px" onclick="choose_297e201048183a730148183ad85c0001()"/>
            <%--<t:choose hiddenName="orgIdss" hiddenid="id"--%>
                      <%--url="departController.do?departSelect" name="departList"--%>
                      <%--icon="icon-search" title="common.department.list"--%>
                      <%--textname="departname" isclear="true"></t:choose>--%>
        </span>
    </div>
</div>
<%--update-end--Author:zhangguoming  Date:20140827 for：添加 组织机构查询条件--%>

<t:datagrid name="userList" title="用户管理" actionUrl="userController.do?datagrid" fit="true" fitColumns="true" idField="id" queryMode="group" checkbox="true">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.username" sortable="false" field="userName" query="true"></t:dgCol>
    <%--update-start--Author:zhangguoming  Date:20140827 for：通过用户对象的关联属性值获取组织机构名称（多对多关联）--%>
	<%--<t:dgCol title="common.department" field="TSDepart_id" query="true" replace="${departsReplace}"></t:dgCol>--%>
	<t:dgCol title="common.department" field="userOrgList.tsDepart.departname" query="false"></t:dgCol>
    <%--update-end--Author:zhangguoming  Date:20140827 for：通过用户对象的关联属性值获取组织机构名称（多对多关联）--%>
	<t:dgCol title="common.real.name" field="realName" query="true"></t:dgCol>
	<t:dgCol title="common.role" field="userKey" ></t:dgCol>
	<t:dgCol title="common.status" sortable="true" field="status" replace="common.active_1,common.inactive_0,super.admin_-1" ></t:dgCol>
	<t:dgCol title="common.operation" field="opt"></t:dgCol>
	<t:dgDelOpt title="common.delete" url="userController.do?del&id={id}&userName={userName}" />
	<t:dgFunOpt title="数据权限" funname="userPermClick(id,realName)" operationCode="dataPrvl"/>

</t:datagrid>
<script type="text/javascript">

function lockObj(title,url, id) {

	gridname=id;	
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('<t:mutiLang langKey="please.select.lock.item"/>');
		return;
	}
	if (!rowsData || rowsData.length > 1) {
		tip('不允许批量锁定用户');
		return;
	}
		url += '&id='+rowsData[0].id;

	$.dialog.confirm('<t:mutiLang langKey="is.confirm"/>', function(){
		lockuploadify(url, '&id');
	}, function(){
	});
}
//解锁用户
function unLockObj(title,url, id) {

	gridname=id;
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('<t:mutiLang langKey="please.select.unlock.item"/>');
		return;
	}
	if (!rowsData || rowsData.length > 1) {
		tip('不允许批量解锁用户');
		return;
	}
		url += '&id='+rowsData[0].id;

	$.dialog.confirm('<t:mutiLang langKey="is.confirm"/>', function(){
		lockuploadify(url, '&id');
	}, function(){
	});
}

function lockuploadify(url, id) {
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
		
		
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
			var msg = d.msg;
				tip(msg);
				reloadTable();
			}
			
		}
	});
}
</script>

<%--update-start--Author:zhangguoming  Date:20140827 for：添加 组织机构查询条件：弹出 选择组织机构列表 相关操作--%>
<%--<a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" onClick="choose_297e201048183a730148183ad85c0001()">选择</a>--%>
<%--<a href="#" class="easyui-linkbutton" plain="true" icon="icon-redo" onClick="clearAll_297e201048183a730148183ad85c0001();">清空</a>--%>
<script type="text/javascript">
//    var windowapi = frameElement.api, W = windowapi.opener;
    function choose_297e201048183a730148183ad85c0001() {
        if (typeof(windowapi) == 'undefined') {
            $.dialog({content: 'url:departController.do?departSelect', zIndex: 2100, title: '<t:mutiLang langKey="common.department.list"/>', lock: true, width: 560, height: 560,  opacity: 0.4, button: [
                {name: '<t:mutiLang langKey="common.confirm"/>', callback: clickcallback_297e201048183a730148183ad85c0001, focus: true},
                {name: '<t:mutiLang langKey="common.cancel"/>', callback: function () {
                }}
            ]});
        } else {
            $.dialog({content: 'url:departController.do?departSelect', zIndex: 2100, title: '<t:mutiLang langKey="common.department.list"/>', lock: true, parent: windowapi, width: 560, height: 560,  opacity: 0.4, button: [
                {name: '<t:mutiLang langKey="common.confirm"/>', callback: clickcallback_297e201048183a730148183ad85c0001, focus: true},
                {name: '<t:mutiLang langKey="common.cancel"/>', callback: function () {
                }}
            ]});
        }
    }
    function clearAll_297e201048183a730148183ad85c0001() {
        if ($('#departname').length >= 1) {
            $('#departname').val('');
            $('#departname').blur();
        }
        if ($("input[name='departname']").length >= 1) {
            $("input[name='departname']").val('');
            $("input[name='departname']").blur();
        }
        $('#orgIdss').val("");
    }
    function clickcallback_297e201048183a730148183ad85c0001() {
        iframe = this.iframe.contentWindow;
        var departname = iframe.getdepartListSelections('departname');
        if ($('#departname').length >= 1) {
            $('#departname').val(departname);
            $('#departname').blur();
        }
        if ($("input[name='departname']").length >= 1) {
            $("input[name='departname']").val(departname);
            $("input[name='departname']").blur();
        }
        var id = iframe.getdepartListSelections('id');
        if (id !== undefined && id != "") {
            $('#orgIdss').val(id);
            $("input[name='orgIdss']").val(id);
        }
    }
    function userPermClick(id,realName) {
        var url = "scReportPermController.do?scReportPerm&permType=1&permId=" + id; 
    	addOneTab("用户【" + realName + "】数据权限设置", url);
    }
</script>
<%--update-end--Author:zhangguoming  Date:20140827 for：添加 组织机构查询条件：弹出 选择组织机构列表 相关操作--%>
