<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;">
<table id="processList" style="width: 700px; height: 300px">
	<thead>
		<tr>
			<th field="id" hidden="hidden">编号</th>
			<th field="processDefinitionId" width="50">ProcessDefinitionId</th>
			<th field="deploymentId" width="50">DeploymentId</th>
			<th field="name" width="50">流程名称</th>
			<th field="key" width="50">KEY</th>
			<th field="version" width="20">版本</th>
			<th field="xml" width="50">流程文件</th>
			<th field="image" width="50">流程图片</th>
			<th field="isSuspended" width="50">是否挂起</th>
			<th field="opt" width="50">操作</th>
		</tr>
	</thead>
</table>
<div id="tb2" style="height: 30px;" class="datagrid-toolbar"><span style="float: left;"> 
<a href="#" id='add' class="easyui-linkbutton" plain="true" icon="icon-add"
	onclick="add('部署流程','activitiController.do?developmentInit','processList',400,150)" id="">部署流程</a> 
</span></div>
<script type="text/javascript">
		//查看流程xml或流程图片
		function readProcessResouce(processDefinitionId,resourceType) {
			var url = "";
			var title = "";
			if(resourceType == "xml"){
				title = "查看流程文件";
				url = "activitiController.do?resourceRead&processDefinitionId="+processDefinitionId+"&resourceType=xml&isIframe"
				//url = "activitiController.do?resourceRead&processDefinitionId=vacation:1:10&resourceType=image&isIframe"
			}

			if(resourceType == "image"){
				title = "查看流程图片";
				url = "activitiController.do?resourceRead&processDefinitionId="+processDefinitionId+"&resourceType=image&isIframe"
			}
			addOneTab(title, url);
		}
		
	    // 编辑初始化数据
		function getData(data){
			var rows = [];			
			var total = data.total;
			for(var i=0; i<data.rows.length; i++){
				rows.push({
					id: data.rows[i].id,
					processDefinitionId: data.rows[i].processDefinitionId,
					deploymentId: data.rows[i].deploymentId,
					name: data.rows[i].name,
					key: data.rows[i].key,
					version: data.rows[i].version,
					xml: "[<a href=\"#\" onclick=\"readProcessResouce('"+data.rows[i].processDefinitionId+"','xml')\">查看流程xml</a>]",
					image: "[<a href=\"#\" onclick=\"readProcessResouce('"+data.rows[i].processDefinitionId+"','image')\">查看流程图片</a>]",
					isSuspended: data.rows[i].isSuspended,
					opt: "[<a href=\"#\" onclick=\"delObj('activitiController.do?del&deploymentId="+data.rows[i].deploymentId+"','processList')\">删除流程</a>]"
				});
			}
			var newData={"total":total,"rows":rows};
			return newData;
		}
	    // 筛选
		function jeecgEasyUIListsearchbox(value,name){
    		var queryParams=$('#processList').datagrid('options').queryParams;
    		queryParams[name]=value;
    		queryParams.searchfield=name;
    		$('#processList').datagrid('load');
    	}
	    // 刷新
	    function reloadTable(){
	    	$('#processList').datagrid('reload');
	    }
	    
		// 设置datagrid属性
		$('#processList').datagrid({
			title: '流程定义及部署管理',
	        idField: 'id',
	        fit:true,
	        loadMsg: '数据加载中...',
	        pageSize: 10,
	        pagination:true,
	        sortOrder:'asc',
	        rownumbers:true,
	        singleSelect:true,
	        fitColumns:true,
	        showFooter:true,
	        url:'activitiController.do?datagrid',  
	        toolbar: '#tb2',
	        loadFilter: function(data){
	        	return getData(data);
	    	}
	        
	    }); 
	    //设置分页控件  
	    $('#processList').datagrid('getPager').pagination({  
	        pageSize: 10,  
	        pageList: [10,20,30],  
	        beforePageText: '',  
	        afterPageText: '/{pages}',
	        displayMsg: '{from}-{to}共{total}条',
	        showPageList:true,
	        showRefresh:true,
	        onBeforeRefresh:function(pageNumber, pageSize){
	            $(this).pagination('loading');
	            $(this).pagination('loaded');
	        }
	    });
	    // 设置筛选
    	$('#jeecgEasyUIListsearchbox').searchbox({
    		searcher:function(value,name){
    			jeecgEasyUIListsearchbox(value,name);
    		},
    		menu:'#jeecgEasyUIListmm',
    		prompt:'请输入查询关键字'
    	});
	</script></div>
</div>