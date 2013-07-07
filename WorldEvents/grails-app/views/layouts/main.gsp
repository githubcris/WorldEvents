<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="World Events"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon3.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}">
		<link rel="stylesheet" href="${resource(dir:'css',file:'timedatepicker.css')}"/> 
		<g:javascript library="jquery"/>
		<r:require module="jquery-ui"/>
		<g:layoutHead/>		
			</head>
	<body>
	<%String targetUri = (request.forwardURI - request.contextPath) %>
	<div  id="worldLogo" role="contentinfo">
	<table>
	<tr>
	<td width="60%">
	  	<img src="${resource(dir: 'images', file: 'worldevent.png')}" alt="World Events"/>
	</td>
	 <td style="vertical-align:bottom; width:50%; text-align: right;" >
	    <g:link class="rightAlign" controller="twitterLogin" action="changelanguage"  params="[lang: 'en', targetUri: targetUri]"><g:message class="litleletter" code="label.language.english"/></g:link>
	 </td>
	  <td style="vertical-align:bottom; width:10%" >
	    <g:link class="rightAlign" controller="twitterLogin" action="changelanguage" params="[lang: 'es', targetUri: targetUri]"><g:message class="litleletter"  code="label.language.spanish"/></g:link>
    </td>
    <td style="vertical-align:top; width:10%" >
        <g:link class="rightAlign" controller="twitterLogin" action="logout">Logout</g:link>
    </td>
    </tr>
    </table>      
    </div>  
       <g:if test="${session.user}"> 
        <div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${grailsApplication.config.grails.serverURL}"><g:message code="label.title.home"/></a></li>
				<li><a href="${grailsApplication.config.grails.serverURL}/edit" class="create"><g:message code="label.title.new"/></a></li>
				<li><a href="${grailsApplication.config.grails.serverURL }/display" class="list"><g:message code="label.title.events"/></a></li>
			</ul>
		</div>
		</g:if>
		<g:layoutBody/>
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>
