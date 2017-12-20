<#setting number_format="################.####">
<#setting date_format="yyyy-MM-dd HH:mm:ss">

<!DOCTYPE html>
<html>
 	<#include "jformhtmlhead.ftl">
 <body style="overflow-y: scroll" >
 
 		<form id="formobj" action="chrhcFormBuildController.do?saveOrUpdate" name="formobj" method="post" class="form-inline valideForm">
			<input type="hidden" id="btn_sub" class="btn_sub"/>

		 <section id="mainbox"> 
		 
		  <div class="tab-content tab-box">
		  	<div class="Current_position" style="display: none">
		    	<img src="plug-in/media/image/dingwei.png"/><span id="current_position_text">当前所在的位置：</span>
	    		<script type="text/javascript">
	    			if(parent.parent.url_title_map[parent.location.href]){
	    				document.write(parent.parent.url_title_map[parent.location.href]);
	    			}else {
		    			if(location.href.indexOf('scQuickTitle') != -1){
							var reg = new RegExp("(^|&)scQuickTitle=([^&]*)(&|$)");
							var r  = window.location.search.substr(1).match(reg);
							document.write("<a href='javascript:;'>快捷业务</a>" + "<a href='javascript:;' class='last'>" +decodeURI(r[2]) + "</a>");
		    			}		    			
	    			}

	    		</script>
		    </div>
		  	<div class="tabs_btn_div">
                <span style="display:none;" class="btn btn_bag_1" id="zxjd" type="button"  title="自助报修结单"><i class="fa fa-paper-plane"></i></span>

                <span style="display:none;" class="btn btn_bag_1" id="process_btn" type="button" onclick="$('#btn_sub').click();sub_process=true;changeTypeTab();" title="提交"><i class="fa fa-paper-plane"></i></span>
		    	<span  class="btn btn_bag_1" id="save_btn" type="button" onclick="$('#btn_sub').click();changeTypeTab();" title="保存"><i class="fa fa-floppy-o"></i></span>
		        <span class="btn btn_bag_2" id="reset_btn" type="button" onclick="location.reload();" title="重置"><i class="fa fa-repeat"></i></span>
		        <span class="btn btn_bag_3" id="back_btn" type="button" onclick='sub_process=false;back_fun();' title="返回"><i class="fa fa-reply"></i></span>
		    </div>
		    <#--<ul class="nav nav-tabs">
		      	<li class="active"><a href="#jbxx" data-toggle="tab">基本信息</a></li>

		      	 <#list typeTitleList as tt>
		      	    <li><a href="#${tt.field_name!}" data-toggle="tab">${tt.content!}</a></li>
		      	 </#list>

		    </ul>-->
		    <div class="tab-pane active" id="jbxx">

				  <div class="container form-card">
							<input type="hidden" id="btn_sub" class="btn_sub"/>
							<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
							<input type="hidden" name="id" value="${id?if_exists?html}" >
							<input type="hidden" name="layerId" value="${layerId?if_exists?html}" >
							<#if bizType?? && bizType!=''> <input type="hidden" name="biztype" value="${bizType}" > </#if>
							<#global typetitle_index=0>  
							<#list columnhidden as po>
							<#if po.field_name!='biztype'>
								
								<#if po.show_type=='date' || po.show_type=='datetime'||po.type=='Date'>
									<input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
								<#else>
									<input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
								</#if>
							 
							</#if>
							</#list>
		 
								<#global pocl_index=0>
							   <#list columns as po>
							    <#if (columns?size>4)>
									<#if (pocl_index-typetitle_index)%2==0>
										<div class="row">
									</#if>
								<#else>
										<div class="row">
								</#if>
							
									<#if po.show_type=='typetitle'>
					
										<#if ((pocl_index-typetitle_index-1)%2==0 )>
										 
											<div class="col-md-6" >
											<div class="form-group">
											</div>
											</div>
											</div>
										<#else> 
											</div>
										</#if>
				 
									 	<#global typetitle_index=(pocl_index+1)> 
									
									</div>
									 </div>
									 <div class="tab-pane" id="${po.field_name!}"  >
						 				  <div class="container form-card">
							
									<#else>
										<#if po.show_type=='file'>
											<#if ((pocl_index-1)%2==0 )>
												<div class="col-md-6" >
												<div class="form-group">
												</div>
												</div>
												</div>
												<div class="row">
											<#else>
												<#global pocl_index=(pocl_index+1)>
											</#if>
										    <div class="col-md-12">
										    	<div class="form-group" style="float:left;">
												<label class="control-label fl" style="margin-top:0px;" for="${po.field_name}">${po.content}</label>
										<#else><!--if po.show_type != 'file' -->
											<#if po.show_type=='checkbox'>
												<#if ((pocl_index-1)%2==0 )>
													<div class="col-md-6" >
													<div class="form-group">
													</div>
													</div>
													</div>
													<div class="row">
												<#else>
													<#global pocl_index=(pocl_index+1)>
												</#if>
											    <div class="col-md-12">
											    	<div class="form-group" style="float:left;">
													<label class="control-label fl" style="margin-top:0px;" for="${po.field_name}">${po.content}</label>
											<#else>
												<div class="col-md-6" >
													<div class="form-group">
													<label class="control-label" for="${po.field_name}">
													${po.content}
										 
													</label>
										 
											</#if>
											<#assign field_name = po.field_name>
											<#assign field_value = data['${tableName}']['${po.field_name}']?if_exists?html>
										</#if>
										<#if po.show_type == 'date' || po.show_type == 'datetime'>
										   
										    <#if po.type == 'string'>
										    <#assign date_field_value = data['${tableName}']['${po.field_name}']?if_exists?html>
										    <#assign datetime_field_value = data['${tableName}']['${po.field_name}']?if_exists?html>
										    <#else>
										    
											 <#assign date_field_value = data['${tableName}']['${po.field_name}']?if_exists?html>
										    <#assign datetime_field_value = data['${tableName}']['${po.field_name}']?if_exists?html>
											</#if>
										</#if>
				
									<#include "jformfield.ftl">
									<#if po.is_null=='N'>
										<span style="color: red;">*</span>
									</#if>
									<span class="Validform_checktip"></span>
									<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
										
									<!--</td> -->
									</div>
									</div>
									<#if (columns?size>4)>
									<#if ((pocl_index-typetitle_index)%2!=0)||(!po_has_next)>
										
										</div>
									</#if>
									<#else>
										</div>
									</#if>
								</#if>
									
							 
								<#global pocl_index=(pocl_index+1)>
							  </#list>
							  
							  <#list columnsarea as po>
							  <#if (columns?size>4)>
								<div class="row">
									<div class="col-md-12">
										<label class="control-label">
										${po.content}
										</label>
										<textarea id="${po.field_name}" name="${po.field_name}" 
										        class="form-control" rows="3" cols="80" 
										<#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
										<#if po.validate_attr?if_exists?html != ''>
									              	${po.validate_attr}
									                </#if>
								               <#if po.field_valid_type?if_exists?html != ''>
								               datatype="${po.field_valid_type?if_exists?html}"
								               <#else>
								               <#if po.is_null != 'Y'>datatype="*"</#if> 
								               </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
								         <#if po.is_null=='N'>
										<span style="color: red;">*</span>
										</#if>     
										<span class="Validform_checktip"></span>
										<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
										
									</div>
								</div>
								<#else>
				 
								<div class="row">
									<div class="col-md-12">
										<label class="control-label">
										${po.content}
										</label>
										<textarea id="${po.field_name}" name="${po.field_name}" 
										        class="form-control" rows="3" cols="80" 
										<#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
										<#if po.validate_attr?if_exists?html != ''>
									              	${po.validate_attr}
									                </#if>
								               <#if po.field_valid_type?if_exists?html != ''>
								               datatype="${po.field_valid_type?if_exists?html}"
								               <#else>
								               <#if po.is_null != 'Y'>datatype="*"</#if> 
								               </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
								           <#if po.is_null=='N'>
											<span style="color: red;">*</span>
											</#if>   
										<span class="Validform_checktip"></span>
										<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
										
									</div>
								</div>
								</#if>
							  </#list>
					
								
						</div>
	
		    </div>
	 
		  </div> 
		    <a href="javascript:location.href = prve_url;" class="dataprve" style="display:none;"></a>
  			<a href="javascript:location.href = next_url;" class="datanext"  style="display:none;"></a>
  			
		</section>


  
		
							<link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css"/>
							<link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css"/>
							<script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
							<script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
							<script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script>
							<script type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
							<script type="text/javascript">
									$(function() {
										$("#formobj").Validform(
										{
											beforeSubmit : function(curform) {
												try {
													//获取disable属性设置为false
													$("[disabled]").removeAttr("disabled");
													return beforeSubmit_();
												} catch (e) {
													return true;
												}
												;
												return true;
											},
											tiptype : "<#if head.tipType?? && head.tipType!=''> ${head.tipType} <#else>4</#if>",
											btnSubmit : "#btn_sub",
											btnReset : "#btn_reset",
											ajaxPost : true,
											usePlugin : {
												passwordstrength : {
													minLen : 6,
													maxLen : 18,
													trigger : function(obj, error) {
														if (error) {
															obj.parent().next().find(
																	".Validform_checktip").show();
															obj.find(".passwordStrength").hide();
														} else {
															$(".passwordStrength").show();
															obj.parent().next().find(
																	".Validform_checktip").hide();
														}
													}
												}
											},
											callback : function(data) {
												if (data.success == true) {
													if(submitCallback){
														submitCallback(data);
													}
													uploadFile(data);
												} else {
													if (data.responseText == ''
															|| data.responseText == undefined) {
														$.messager.alert('错误', data.msg);
														$.Hidemsg();
													} else {
															try {
																var emsg = data.responseText.substring(
																		data.responseText
																				.indexOf('错误描述'),
																		data.responseText
																				.indexOf('错误信息'));
																$.messager.alert('错误', emsg);
																$.Hidemsg();
															} catch (ex) {
																$.messager.alert('错误',
																		data.responseText + '');
															}
														}
														return false;
													}
													if (!neibuClickFlag) {
													}
																										
												}
											});
										});
					
								
								</script>
							 
	</form>
<script type="text/javascript">

	var prve_url , next_url;
	$(window).load(function(){
		window.top.closeLoadingDialog();
	});
   $(function(){
   $('input').iCheck({
				checkboxClass : 'icheckbox_square-blue',
				radioClass : 'iradio_square-blue',
				increaseArea : '20%' 
			});
   <#list columns as po>
  		<#if po.show_type=='popupgis'>
  		var gis = $('#${po.field_name}').val().length;	
  		if(gis){
  		$("#showgis").show();
  		}	
  		</#if>
  		<#if po.show_type=='doctype'>
  		
  		var doctype = $('#${po.field_name}').val().length;	
  		if(doctype){
  		$("#adddoc").attr({'title':'编辑','class':'editbtn-new inner-newbtn'});
  		$("#editdoc").show();
  		}	
  		</#if>
  	</#list>

	
	if (location.href.indexOf("mode=read") == -1) {
    } else {
        //查看模式控件禁用
        debugger;
        $("#adddoc").hide();
        $("#formobj").find(":input").attr("disabled", "disabled");
        $("#cleargis").hide();
        $("#buttonPanel").hide();

        $(".suoshu").hide();
        //$("[id^='uploadify_']").hide();
        $("[class*='delflag']").hide();
        $("#file_uploadspan").hide();
        $("#save_btn").hide();
        $("#reset_btn").hide();
        $("#back_btn").attr("disabled", false);


        var id = $("input[name='id']").val();

        /*if (parent.nextRecord) {
            prve_url = parent.nextRecord(id, -1);
            next_url = parent.nextRecord(id, 1);
            if (prve_url) {
                $(".dataprve").show();
            }
            if (next_url) {
                $(".datanext").show();
            }
        }*/

    }


    //查看模式情况下,删除和上传附件功能禁止使用
	if(location.href.indexOf("load=detail")!=-1){
		$(".jeecgDetail").hide();
	}
	
 
  		
  		
	if($("#bpm_status").size() > 0 && ($("#bpm_status").val() == 1 || $("#bpm_status").val() == '')){
		//流程提交按钮
		$("#process_btn").show();
	}
	
	if(location.href.indexOf("mode=onbutton")!=-1){
		//其他模式显示提交按钮
		$("#sub_tr").show();
	}
	

	
   });
   
   
	var sub_process = false ;
	function submitCallback(data){
	 	if($("#process_btn").is(":visible") && sub_process){
			var url = 'activitiController.do?startOnlineProcess&configId=${tableName}&id=' + data.obj.id;
			$.post(url,{},function(data){
				parent.reloadTable(data);
				parent.$("#editFormDiv").hide();
				parent.$("#editForm").attr("src","");
				parent.$(".datagrid").show();
			});
	 	}
	}

  function upload() {
  	<#list columns as po>
  		<#if po.show_type=='file'>
  		$('#${po.field_name}').uploadify('upload', '*');		
  		</#if>
  	</#list>
  }
  var neibuClickFlag = false;
  function neibuClick() {
	  neibuClickFlag = true; 
	  $('#btn_sub').trigger('click');
  }
  function cancel() {
  	<#list columns as po>
  		<#if po.show_type=='file'>
 	 $('#${po.field_name}').uploadify('cancel', '*');
 	 	</#if>
  	</#list>
  }
  
   function uploadFile(data){
  			if(!$("input[name='id']").val()){
  				$("input[name='id']").val(data.obj.id);
  			}
  		
  			if (neibuClickFlag){
  				alert(data.msg);
  				neibuClickFlag = false;
  			}else {
  			
  				//alert(getParentWindow().document.body.innerHTML);
  			
  				var win =  getCurrentTab().find("iframe")[0].contentWindow;
  				
				//处理是否户主的亲属关系开始
  				if($("select[name='sfhz']").length){
		  			whqsgx(data);
		  		}

				//处理是否户主的亲属关系结束
  			    //处理家庭信息户主回写开始
  		
  				var urldata = getUrlData();
                debugger;
				if(urldata.tableName == "hl_customer"){
					updatehlcalls(data);
				}
				if(urldata.jthz){				
				var iframejt ;
				var iframeedit = getParentWindow().$("#editForm");
				if(iframeedit.length){
				iframejt = getParentWindow().$("#editForm")[0].contentWindow;
				}else{
				iframejt = getParentWindow()
				}
				iframejt.whjtxx(data);
				}
	  			//处理家庭信息户主回写结束
	  			
	  			//处理快捷业务回写开始
	  			if(urldata.docWarId){
	  			saverkxxgrzp(docfile,data.obj.id,"sc_rkjbxxnew","grzp");
				getParentWindow().getModelTypeBtn(data.obj.sfzh,data.obj.id);
				//parent.closeCurrentTab();
				//return;
				}
	  			//处理快捷业务回写结束
 
				//GIS编辑时，回调GIS方法
				if(win)
				{
			  		if($("input[name='layerId']").val()){
			  			getParentWindow().businessCallBackDrawPointOrVector($("input[name='layerId']").val(),data.obj.id,data.obj.name,data.obj.gisxy);
			  		}
			  		if(!sub_process){
				  		//alert(getParentWindow().document.body.innerHTML);
			  		//alert(parent.document.body.innerHTML)
			  			if(urldata.sqly_id){	//建筑物房间查看处理		  			
			  			getParentWindow().reloadTable(data);
			  			}else{
			  			parent.reloadTable(data);
			  			}
			  		}
					win.tip(data.msg);
				}else{
					closeCurrentTab();
				}		
  			}
  			
  			if($(".uploadify-queue-item").length>0){
  				upload();
  			}else{
  				back_fun();
  			}
  			
  	}
  	var datagrid_view_height = parent.$(".datagrid-view").height();
  	var datagrid_header_height = parent.$(".datagrid-header").height();
  	
  	function back_fun(){
		var editFormDiv = parent.$("#editFormDiv");
		if(editFormDiv.length){
			if(!sub_process){
				parent.$("#editFormDiv").hide();
				parent.$("#editForm").attr("src","");
				parent.$(".datagrid").show();
			}
		}else{
			parent.closeCurrentTab();
		} 	
		 
		//处理datagrid-view datagrid-header
		parent.$(".datagrid-view").height(datagrid_view_height);
		parent.$(".datagrid-header").height(datagrid_header_height);
		parent.fitColumns();
  	}
  	
	//$.dialog.setting.zIndex = 999999999;
	function delFile(url,obj){
	$.dialog.setting.zIndex = $.dialog.setting.zIndex+20;
		$.dialog.confirm("确认删除该条记录?", function(){
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
						$(obj).closest("li").hide("slow");
						$("img",$(obj).closest("div").parent()).remove();
					}
				}
			});  
		}, function(){
		}).zindex();
	}

	/**
	 * 下载flash安装文件
	 */
	function downLoadFlashFile(){
		var filePath = "downfiles/flash/flashplayer17ax_ra_install.exe";
		window.open(filePath,"下载",'height=100, width=400, top=0, left=0, toolbar=yes, menubar=yes, scrollbars=yes, resizable=yes,location=yes, status=yes,alwaysLowered=yes');
	}
	/**
	 * 下载驱动安装文件
	 */
	function downLoadDriver(){
		var filePath = "http://192.168.1.73:8080/sc/downfiles/sclient.msi";
		window.open(filePath,"下载",'height=100, width=400, top=0, left=0, toolbar=yes, menubar=yes, scrollbars=yes, resizable=yes,location=yes, status=yes,alwaysLowered=yes');
	}
	
 
 
		//切换tab校验
		$('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
			if(!$('#formobj').Validform().check(false,".active [datatype]")){
				return false;
			}
			e.target ;// 激活的标签页
			e.relatedTarget; // 前一个激活的标签页
		})

		function changeTypeTab(){
		 	if($(".Validform_error").closest("div.tab-pane").size() > 0){
		 		var aid ;
				$(".Validform_error").closest("div.tab-pane").each(function(n,v){
					if(n == 0){
						aid = $(v).attr("id");
					}
				}) ;
				$('a[data-toggle="tab"][href="#' + aid +'"]').tab('show') ;
		 	}
		}
</script>
	${js_plug_in?if_exists}	
 </body>
</html>