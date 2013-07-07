<!DOCTYPE html>
<html>
<%@page import="org.springframework.context.i18n.LocaleContextHolder"%>
<head>
<g:javascript library="jquery"/>
<r:require module="jquery-ui"/>
<meta name="layout" content="main"/>
<r:layoutResources/>
<g:javascript src="timedatepicker.js" />
<link rel="stylesheet" href="${resource(dir:'css',file:'timedatepicker.css')}"/> 
</head>
<body>
<div class="divCenterClass">
<g:form controller = "edit" action = "saveevent" class="center">
   <g:if test="${session.user}">       
       <%
		String targetUri = (request.forwardURI - request.contextPath)
		String datePattern =  '^(((0[1-9]|[12]\\d|3[01])\\/(0[13578]|1[02])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|[12]\\d|30)\\/(0[13456789]|1[012])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|1\\d|2[0-8])\\/02\\/((19|[2-9]\\d)\\d{2}))|(29\\/02\\/((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$'
		String timePattern = '((?:(?:[0-1][0-9])|(?:[2][0-3])|(?:[0-9])):(?:[0-5][0-9])(?::[0-5][0-9])?(?:\\s?(?:am|AM|pm|PM))?)'
	   %>	   
     <div class="headLabel">
        <img  src="${session.user.profileImg}"/>  <strong>${session.user.name}</strong>
        <g:if test="${params.notauthorized}">
         <script>
          	alert('${g.message(code: 'label.error.notauthorized')}')
          </script>
       </g:if>       
   </div>
   <div>
   <table>         		      
   <tr>
       <g:hiddenField name="id" value="${event?.id}" />
  	   <td style="width:10%;" >
       	<label class="label" ><g:message code="label.field.event"/></label>
       </td>
       <td>
         <input type="text" style="width:60%;"  name="name" maxlength="100" value="${fieldValue(bean:event,field:'name')}"/>
	     <g:if  test="${hasErrors(bean:event,field:'name','errors')}">
       	 <div  class="errors">
       		 <g:message  code="label.error.required"/>
       	 </div>
		 </g:if>		
	  </td>
    </tr>
    <tr>
       <td>
      	  <label><g:message code="label.field.description"/></label>
      </td>
      <td>
     	   <g:textArea style="width:60%;" name="description"  escapeHtml ="false" maxlength="250" value="${fieldValue(bean:event,field:'description')}"/>
      </td>
    </tr>
    <tr>
      <td>
       	   <label><g:message code="label.field.startdate"/></label>
      </td>
      <td style="width:60%;">
        <g:textField id="datepicker${LocaleContextHolder.getLocale()?.toString()?.substring(0,2)}" class="text" name="sStartDate" pattern="${datePattern}" value="${fieldValue(bean:event,field:'sStartDate')}" /> 
         <label  class="label"><g:message code="label.field.time"/></label>
       	 <g:textField id="timepicker${LocaleContextHolder.getLocale()?.toString()?.substring(0,2)}" class="text" name="startTime" pattern="${timePattern}" value="${fieldValue(bean:event,field:'startTime')}"/>
   	     <g:if  test="${hasErrors(bean:event,field:'sStartDate','errors')}">
       		<div  class="errors"  >
       			<g:message code="label.field.startdate"/>  <g:message  code="label.error.required"/>
         	 </div>
	     </g:if>
	    <g:if  test="${hasErrors(bean:event,field:'startTime','errors')}">
       	 <div  class="errors">
       		 <g:message code="label.field.time"/> <g:message  code="label.error.required"/>
         </div>
		 </g:if>
	   </td>
     </tr>
     <tr>
       <td>
       		<label><g:message code="label.field.enddate"/></label>
       	</td>
       	<td>
      		<g:textField id="datepickerend${LocaleContextHolder.getLocale()?.toString()?.substring(0,2)}" class="text" name="sEndDate" pattern="${datePattern}" value="${fieldValue(bean:event,field:'sEndDate')}" /> 
         	<label  class="label"><g:message code="label.field.time"/></label>       	 
		    <g:textField id="timepickerend${LocaleContextHolder.getLocale()?.toString()?.substring(0,2)}" name="endTime" pattern="${timePattern}" value="${fieldValue(bean:event,field:'endTime')}"/>
       	</td>
     </tr>
     <tr>
        <td>
       		<label><g:message code="label.field.place"/></label>
       	</td>
       	<td  style="width:52%;">   
    		<g:select style="width:60px;" id="loc"  name="loc"  from="${params.locationtypes}" optionKey="id" optionValue="name"  value="${fieldValue(bean:event,field:'loc')}"  />
      	    <g:textField style="width:inherit;"  name="address" value="${event?.address}"/>	 	
        <g:if  test="${hasErrors(bean:event,field:'address','errors')}">   
      	    <div  class="errors">
       		 	<g:message code="label.error.required"/>
       		 </div>       	
		</g:if>	
		</td>
      </tr>
      <tr>
        <td>
       		<label  for="eventplace" class="label" ><g:message code="label.field.city"/></label>
       	</td>
       	<td>
       	<g:textField  style="width:30%;" name="city" value="${event?.city}"/>
         <g:if  test="${hasErrors(bean:event,field:'city','errors')}">
       	     <div  class="errors">
       			 <g:message  code="label.error.required"/>
       		 </div>
		  </g:if>
		 </td>
     </tr>
     <tr>      
       <td>
       </td>
       <td>
       	 	<g:submitButton name= "saveevent" value ="${g.message(code: 'default.save.label')}" class="buttons" />
        </td>
     </tr>  
     </table>
   </div>
   </g:if>
    <g:else>
        <%
		String forwardUri = request.forwardURI-request.contextPath;
		%>
	  <div style="margin-left:30px;margin-top:20px;" >
      <p>
            <g:link class="label"  controller="twitterLogin" params="[forwardUri: forwardUri]" action="login"><g:message code="label.default.signin"/></g:link>
      </p>
      <p>
            <g:link class="label" controller="twitterLogin" action="demologin"><g:message code="label.default.signindemo"/></g:link>
      </p>
      </div>
    </g:else>   
   </g:form>
  </div>
</body>
</html>