/*======================
  Name:pieuser.js
  Data:2015.5.10 13:44
  Author:zhucf
  Notes:解决IE7、8、9兼容html5圆角及阴影
  =====================*/
$(function() { 
	if (window.PIE) { 
		/*== .Application_menu a 需要兼容的元素==*/
		
		$('.icon_div').each(function() { 
		PIE.attach(this); 
		}); 
		$('.sy_div').each(function() { 
		PIE.attach(this); 
		});
		
		
	
	} 
}); 