<!DOCTYPE html>
<html>
<style type="text/css" media="screen"></style>

<g:javascript library="jquery"/>
<r:require module="jquery-ui"/>
<r:layoutResources/>
<g:javascript library="jquery" plugin="jquery" />

<link rel="stylesheet" href="${resource(dir:'css',file:'sky.css')}"/> 
<link rel="stylesheet" href="${resource(dir:'css',file:'timedatepicker.css')}"/> 
<g:javascript src="timedatepicker.js" />

<script>
$(function() {

	$( "#timepicker" ).timepicker();
	});	
$(function() {

	$( "#datepicker" ).datepicker({
        dateFormat:'dd/mm/yy',
        changeYear:true,
        changeMonth:true
    });

	});	

</script>
<body>
<div class="divCenterClass">
<g:form controller = "newEvent" action = "saveevent" class="center">
   <g:if test="${session.user}">     
     <div class="head">
       <table>
       <tr>
       <%
		String targetUri = (request.forwardURI - request.contextPath)
		String datePattern =  '^(((0[1-9]|[12]\\d|3[01])\\/(0[13578]|1[02])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|[12]\\d|30)\\/(0[13456789]|1[012])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|1\\d|2[0-8])\\/02\\/((19|[2-9]\\d)\\d{2}))|(29\\/02\\/((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$'
		String timePattern = '((?:(?:[0-1][0-9])|(?:[2][0-3])|(?:[0-9])):(?:[0-5][0-9])(?::[0-5][0-9])?(?:\\s?(?:am|AM|pm|PM))?)'
	
		%>
       <td width="80%" colspan="2"/>
       <td>
        <g:link class="rightAlign" controller="twitterLogin" action="changelanguage"  params="[lang: 'en', targetUri: targetUri]"><g:message class="litleletter" code="label.language.english"/></g:link>
       </td>
       <td>
         <g:link class="rightAlign" controller="twitterLogin" action="changelanguage" params="[lang: 'es', targetUri: targetUri]"><g:message class="litleletter"  code="label.language.spanish"/></g:link>
       </td>
       </tr>
       <tr height="20px">
       <td colspan="3"/>
       </tr>
       <tr>
       <td width="70%" colspan="2">
        <img class="headLabel" src="${session.user.profileImg}"/>  <strong>${session.user.name}</strong>
        </td>
        <td>
         <g:link class="rightAlign" controller="twitterLogin" action="logout">Logout</g:link>
        </td>
       </tr>
       <td colspan="3">
      
       <g:if test="${params.notauthorized}">
         <script>
          	alert('${g.message(code: 'label.error.notauthorized')}')
          </script>
       </g:if>
       </td>
       </table>
   </div>
  <div id="menu" class="title" >
   
  <p class="title" >
   <label  class="headLabel"><g:message code="label.title.new"/></label>  
   <label style="pad-left:10px;color:black;">  |  </label>
   <g:link class="headLabel" controller="event"><g:message code="label.title.events"/></g:link>
  </p>
  </div>
       <p class="separator"></p>
       <div>
 
       <table width="97%">             		      
       <tr>
       <g:hiddenField name="id" value="${myevent?.id}" />
       <td width="2%"/>
       <td>
       	<label  for="eventnamelable" class="label" ><g:message code="label.field.event"/></label>
       </td>
       <td width="80%" >
         <g:if  test="${hasErrors(bean:myevent,field:'name','errors')}">
       		 <input   type="text" class="errortext" name="name" value="${fieldValue(bean:myevent,field:'name')}"/>
       		 <div  class="messageerror">
       		 <g:message  code="label.error.required"/>
       		 </div>
		  </g:if>
		  <g:else>
			  <input type="text" class="textlarge" name="name" value="${fieldValue(bean:myevent,field:'name')}"/>
	     </g:else>
	  </td>
       </tr>
       <tr>
         <td width="2%"/>
      	 <td>
      	  	<label  class="label" ><g:message code="label.field.description"/></label>
         </td>
       	 <td>
     	   <g:textArea class="textlarge" name="description"  value="${fieldValue(bean:myevent,field:'description')}"/>
       	 </td>
       </tr>
       <tr>
         <td width="2%"/>
       	 <td>
       		<label  class="label" ><g:message code="label.field.date"/></label>
       	</td>
       	<td>
       	  <g:if  test="${hasErrors(bean:myevent,field:'sDate','errors')}">
       	  	<g:textField id="datepicker" class="shorterrortext" name="sDate" pattern="${datePattern}" value="${fieldValue(bean:myevent,field:'sDate')}" />       
             <div  class="messageerror">
       		 <g:message  code="label.error.required"/>
       		 </div>
		  </g:if>
		  <g:else>
       		<g:textField id="datepicker" class="text" name="sDate" pattern="${datePattern}" value="${fieldValue(bean:myevent,field:'sDate')}" /> 
       	  </g:else>       
       	</td>
       </tr>
       <tr>
         <td width="2%"/>
         <td>
         	<label  class="label"><g:message code="label.field.time"/></label>
         </td>
      	 <td>
      	  <g:if  test="${hasErrors(bean:myevent,field:'eventtime','errors')}">
       	  	<g:textField id="timepicker" class="shorterrortext" name="eventtime" pattern="${timePattern}" value="${fieldValue(bean:myevent,field:'eventtime')}" />       
             <div  class="messageerror">
       		 <g:message  code="label.error.required"/>
       		 </div>
		  </g:if>
		  <g:else>
		    	<g:textField id="timepicker" class="text" name="eventtime" pattern="${timePattern}" value="${fieldValue(bean:myevent,field:'eventtime')}"/>
       	  </g:else>
      	 </td>
       </tr>
       <tr>
         <td width="2%"/>
      	 <td>
       		<label  for="eventplace" class="label" ><g:message code="label.field.place"/></label>
       	</td>
       	<td>
       	 <g:if  test="${hasErrors(bean:myevent,field:'place','errors')}">
       	  	<g:textField id="timepicker" class="errortext" name="place" value="${fieldValue(bean:myevent,field:'place')}" />       
             <div  class="messageerror">
       		 <g:message  code="label.error.required"/>
       		 </div>
		  </g:if>
		  <g:else>
       	   <g:textArea class="textlarge" name="place" value="${myevent?.place}"/>
       	  </g:else>
       	</td>
       </tr>
       <tr>      
        <td>
        </td>
        <td>
        </td>
        <td>
       	 	<g:submitButton name= "saveevent" value ="${g.message(code: 'default.save.label')}" class="btn signup-btn" />
        </td>
      </tr>  
     </table>
      </div>
      </g:if>
      <g:else>
            <g:link controller="twitterLogin" action="login">Signin with Twitter</g:link>
      </g:else>
      </g:form>
  </div>
  </body>
</html>