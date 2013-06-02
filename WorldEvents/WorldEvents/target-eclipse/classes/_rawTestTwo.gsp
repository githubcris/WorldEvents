<!--  Start my plugin -->
<div> 
This is my NEW Dialog:
<button id="myDialog3_launch">Show New Dialog</button> 
 
 
 
	  <script type="text/javascript"> 
		var myDialog3_message_o;
$(function() {
			var myDialog3_message = $( "#myDialog3_message" );
myDialog3_message_o=myDialog3_message.val();
			var allFields = $( [] ).add( myDialog3_message );  $( "#myDialog3" ).dialog({autoOpen: false,width: 600,modal: true,modal: true,
				   buttons: {
					   "Submit": function() {
											   var bValid = true;
						   allFields.removeClass( "ui-state-error" );
	   
						   if ( bValid ) {
				   pulsateTips('Connecting to Server...',30);;jQuery.ajax({type:'POST',data:jQuery.param(allFields), url:'/jquery-ui-extensions/test/testCall',success:function(data,textStatus){jQuery('#s_div3').html(data);$("#myDialog3" ).dialog( "close" );;},error:function(XMLHttpRequest,textStatus,errorThrown){jQuery('#myDialog3_failure').html(XMLHttpRequest.responseText);pulsateTips($(myDialog3_failure).html(),5);showErrors('myDialog3');}});
											   }
									   },
					   Cancel: function() {
						   $( this ).dialog( "close" );
					   }
				   },
				   close: function() {
					   allFields.val( "" ).removeClass( "ui-state-error" );
				   }
			   });
	   
						 $( "#myDialog3_launch" )
								 .click(function() {
										 initTips('');
							   $( "#myDialog3" ).val(myDialog3_message_o);
					$( "#myDialog3" ).dialog( "open" );
					return false;
					});
					});</script> 
				<div id="myDialog3_failure" style="display:none"></div> 
				<div id="myDialog3" title="Test Dialog" style="display:none;" > 
					<p class="validateTips"></p> 
					<form action="/jquery-ui-extensions/test/testCall" method="post" name="myDialog3_form" id="myDialog3_form" > 
		<table width="100%" class="ui-dialog-content"><tbody> 
			   <tr> 
			   <td width="40%"><label class="ui-dialog-content" for="myDialog3_message">Message:</label></td> 
			   <td> 
   <input type="text" name="message" id="myDialog3_message" value="Are you still there?" class="text ui-widget-content ui-corner-all" /> <br/>
    <g:select
        name="state" id="state" from="${['PA','OH']}"
        onchange="\$.ajax({
  url: 'test/getChoices',
  success: function( data ) {
	populateSelect(\$('#sType').get(0), \$.map(data, function(type) { return { name: type.name, value: type.value} }));
  }
});"
    ></g:select>
		   </td></tr> 
			   </tbody></table></form></div> 
		   
 
 
<div id="s_div3" style="border:1px solid blue;"> 
Will this change???
</div> 
 
<select id="sType" name="type_id" style="{width=75px}"></select> 
</div>
<!--  End My Plugin -->

