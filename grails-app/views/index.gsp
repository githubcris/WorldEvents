<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">

<g:javascript library="jquery"/>
<r:require module="jquery-ui"/>
<r:layoutResources/>
<link rel="stylesheet" href="${resource(dir:'css',file:'sky.css')}" /> 
  <body>
  <p style="color:red">${flash.message}</p>
   <div class="divCenterClass">
   <g:form controller = "twitterLogin" action = "newevent"  class="center" >
    <%
		String targetUri = (request.forwardURI - request.contextPath)
		%>
   <g:if test="${session.user}">     
       <div class="head">
       <table>
       <tr>
       <td width="80%" colspan="3"/>
       <td>
     <%--    <g:link class="rightAlign" controller="twitterLogin" action="changelanguage"  params="[lang: 'en', targetUri: targetUri]"><g:message class="litleletter" code="label.language.english"/></g:link>--%>
       </td>
       <td>
       <%--  <g:link class="rightAlign" controller="twitterLogin" action="changelanguage" params="[lang: 'es', targetUri: targetUri]"><g:message class="litleletter"  code="label.language.spanish"/></g:link>--%>
       </td>
       </tr>
       <tr height="20px">
       <td colspan="3"/>
       </tr>
       <tr>
       <td width="70%" colspan="2">
        <img class="headLabel" src="${session.user.profileImg}"/>  <g:message code="label.title.welcome"/>    <strong>${session.user.name}</strong>
        </td>
        
        <td>
         <g:link class="rightAlign" controller="twitterLogin" action="logout">Logout</g:link>
        </td>
       </tr>
       </table>
   </div>
   
    <div id="menu" class="title" >
  <p class="title" >
   <g:link class="headLabel" controller="newEvent"><g:message code="label.title.new"/></g:link>
   <label>  |  </label>
   <g:link class="headLabel" controller="event"><g:message code="label.title.events"/></g:link>
  </p>
  </div> 
      </g:if>
      <g:else>
      <p>
            <g:link class="label" controller="twitterLogin" action="login">Signin with Twitter</g:link>
      </p>
      <p>
            <g:link class="label" controller="twitterLogin" action="demologin">Signin with Demo User</g:link>
      </p>
      </g:else>
    </g:form>
  </div>

  </body>
</html>