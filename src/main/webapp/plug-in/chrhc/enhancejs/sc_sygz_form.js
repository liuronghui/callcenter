
$(document).ready(function(){
	var id=$("input[name='id'][type='hidden']").val();
	if(!id){
		//是否志愿者默认值设置
	    $("input[type=radio][name='demonstration'][value='shi']").attr("checked",true); 
		$("input[type=radio][name='demonstration'][value='shi']").parent().addClass("checked",true);  
	}
	
	
	var date = new Date();
	var date1=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	//设置时间在当前时间之前
	var attval= "WdatePicker({errDealMode:1,maxDate:'"+date1+"'})";
	$("input[name='action_time']").attr('onClick',attval);
    
});//document 加载