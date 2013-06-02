<!DOCTYPE html>
<%@page import="worldevents.Event"%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<style type="text/css" media="screen"></style>
<g:javascript library="jquery"/>
<r:require module="jquery-ui"/>
<r:layoutResources/>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&sensor=true"></script>  
<script type="text/javascript">

    function loadMap(address, mapdivname)
    {
    
      var geocoder = new google.maps.Geocoder();
      google.load("visualization", "1", {packages:["map"]});
      geocoder.geocode( { 'address': address}, function(results, status) {    	

        if (status == google.maps.GeocoderStatus.OK) {

          var lat = parseFloat(results[0].geometry.location.toString().split(",")[0].replace("(","").substring(0,20));
          var lon = parseFloat(results[0].geometry.location.toString().split(",")[1].replace(")","").substring(0,20));

          var data = google.visualization.arrayToDataTable([
                                                            ['Lat', 'Lon', 'Name'],
                                                            [lat, lon, address]
                                                          ]);

    			      
          var map = new google.visualization.Map(document.getElementById(mapdivname));
              
          map.draw(data, {useMapTypeControl: true, enableScrollWheel: true, mapType:'normal', zoomLevel:0});
        } else {
         
        }
      });
    };
  
    </script>
<g:javascript src="timedatepicker.js" />
<script>
$(function() {

	$( "#timepicker" ).timepicker();
	});	
$(function() {

	$( "#datepickerini" ).datepicker({
        dateFormat:'dd/mm/yy',
        changeYear:true,
        changeMonth:true
    });
	$( "#datepickerlast" ).datepicker({
        dateFormat:'dd/mm/yy',
        changeYear:true,
        changeMonth:true
    });

	});	

</script>
<link rel="stylesheet" href="${resource(dir:'css',file:'sky.css')}" /> 
<link rel="stylesheet" href="${resource(dir:'css',file:'timedatepicker.css')}"/> 
<div class="divCenterClass">
   <g:form action = "searchResults" class="center" >
   <g:if test="${session.user}">

    <div class="head">
       <table>
       <tr>
       <%
		String targetUri = (request.forwardURI - request.contextPath)
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
       <tr>

       </tr>
       </table>
   </div>
  <g:if  test="${params.mode == 'detail'}" >  
  
  	   <div id="menu" class="title" >
   	   <p>
   	    <g:link  class="headLabel" action="newevent"><g:message code="label.title.new"/></g:link>
        <label style="pad-left:10px;color:black;">  |  </label>
     	<g:link class="headLabel" controller="display"><g:message code="label.title.events"/></g:link>
   	   </p>
   	   </div>
   	     <p class="separator"></p>
   	     <g:if test="${session?.user?.twitter_id == event?.user?.twitter_id }">
   	     <div  class="label">
   	     <table class="tablemenu">
   	     <tr>
   	     <td>   	    
            <g:link action="modevent"  controller="edit"  class="label" id="${event.id}">
            <g:message code="default.edit.label"/>
            </g:link>         	
   	     </td>
   	     <td>
   	      <g:link action="sendtwit"  controller="edit"  class="label" id="${event.id}">
            <g:message code="default.sendtwit.label"/>
            </g:link>
   	     </td>
   	     <td>  	     
            <g:link action="delevent"  controller="edit"  class="label" id="${event.id}">
            <g:message code="default.delete.label"/>
            </g:link>
   	     </td>
   	     <tr>
   	     </table>
   	     </div>
   	     </g:if>
       <div class="itemlist" > 	    
      <table>
       <td width="20px" style= "vertical-align: top;">
	 	<p>
	  		<img class="headLabel" src="${event?.user?.profileImg}" width="40px" height="40px"/> 
	 	</p>
	 	</td>
	   <td>
	     <p class = "leftAlign" style="list-style: none outside none;">
       		<label for="eventlabel" class="label"><g:message code="label.field.event"/>:</label>
          	<link  class="label" id="${event.name}">${event.name?.encodeAsHTML()}<link>          
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">
       		 <label  for="eventlabel" class="label"><g:message code="label.field.user"/>:</label>
          	 <link class="label" id="${event?.user.screenName}">${event?.user.screenName?.encodeAsHTML()}</link>
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">
            <label for="eventlabel" class="label" ><g:message code="label.field.description"/>:</label>
          	<label class="label" id="${event.description}">${event.description?.encodeAsHTML()}</label>
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">   
            <label  for="eventlabel" class="label" ><g:message code="label.field.startdate"/>:</label>
            <label  for="eventlabel" class="label" id="${event.sStartDate}">${event.sStartDate?.encodeAsHTML()}</label>
            <label  for="eventlabel" class="label" ><g:message code="label.field.time"/>:</label>
            <label class="label" id="${event.startTime}">${event.startTime?.toString().substring(0,5).encodeAsHTML()}</label>
      </p>
       <p class = "leftAlign" style="list-style: none outside none;">   
     	    <label  for="eventnamelable" class="label" ><g:message code="label.field.enddate"/>:</label>
            <label  for="eventnamelable" class="label" id="${event.sEndDate}">${event.sEndDate?.encodeAsHTML()}</label>
            <label  for="eventnamelable" class="label" ><g:message code="label.field.time"/>:</label>
            <label class="label" id="${event.endTime}">${event.endTime?.toString()?.substring(0,5)?.encodeAsHTML()}</label>
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">
            <label  for="eventnamelable" class="label"><g:message code="label.field.place"/>:</label>
            <label class="label"  id="${event.loc}">${event.loc?.name.encodeAsHTML()}</label>
           	<label class="label"  id="${event.address}">${event.address?.encodeAsHTML()}</label>
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">
            <label  for="eventnamelable" class="label"><g:message code="label.field.city"/>:</label>
           	<label class="label"  id="${event.city}">${event.city?.encodeAsHTML()}</label>
       </p>
       <p class = "centerAlign" style="list-style: none outside none;"></p>
       	     <div class="leftAlign" id="map" style="width: 400px; height: 300px" >
       	      <script type="text/javascript">
             	  loadMap("${event.loc.name+' '+event.address+' '+ event.city}","map");
           	  </script>
      		 </div>      
	 </td>
      </table>
     </div>
  </g:if>
  <g:else>
  <div id="menu" class="title" >
   <p class="title" >
     <label class="headLabel"><g:message code="label.title.events"/></label> 
     <label style="pad-left:10px;color:black;">  |  </label>
     <g:link class="headLabel" action="newevent"><g:message code="label.title.new"/></g:link> 
   </p>
   </div>
   <div id="filter">
  	<table>
   		<tr>
   		    <td width="2%"></td> 
   			<td  class="filtertext" >
   				<g:message code="label.filter.from"/>:
   				 <g:textField class="text"  id="datepickerini" name="dateIni" value="${dateIni}" />
   				<g:message code="label.filter.to"/>: 
   				 <g:textField class="text"   id="datepickerlast"  name="dateLast" value="${dateLast}" />
   				<g:actionSubmitImage  class="btnimg" name= "search" action="searchResults" value ="Buscar" src="${resource(dir: 'images', file: 'search.png')}" />
   		   </td>
   		    <td width="2%"></td>
   			<td>
     		</td>  			
  		 </tr>
  		 <tr>
  		 <td width="2%"></td>
  		 <td>
  		 <g:message code="label.filter.followers"/>
  		 <g:checkBox name="followers"  value="${params.followers}"/>
  		 <td>
  		 <td width="2%"></td>
  		 <tr>  		 
  	</table>
  </div>  
  <script>
  </script>
       <g:if test="${params.deletedevent}">
          <script>
         	 alert('${g.message(code: 'label.error.eventdelete')}')
          </script>
       </g:if>
  <p class="separator"></p>
	 <g:each in="${results}" var="event" style="list-style: none outside none;">
	 <table>
	 <tr>
	 <td width="20px" style= "vertical-align: top;">
	 <p>
	  <img class="headLabel" src="${event?.user?.profileImg}" width="40px" height="40px"/> 
	 </p>
	 </td>
	 <td>
	 <div class="itemlist" > 	   
       <p class = "leftAlign" style="list-style: none outside none;">
       		<label  for="eventlabel" class="label"><g:message code="label.field.event"/>:</label>
          	<g:link action="showdetail"  controller="display"  class="label" id="${event.id}">${event.name?.encodeAsHTML()}</g:link>
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">
       		 <label  for="eventlabel" class="label"><g:message code="label.field.user"/>:</label>
          	 <link class="label" id="${event?.user.screenName}">${event?.user.screenName?.encodeAsHTML()}</link>
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">
            <label  for="eventlabel" class="label" ><g:message code="label.field.description"/>:</label>
          	<label class="label" id="${event.description}">${event.description?.encodeAsHTML()}</label>
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">   
           <label  for="eventlabel" class="label" ><g:message code="label.field.startdate"/>:</label>
              <%java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
			  <%String sStartDate = dateFormat.format(new Date().parse("yyyy-MM-dd", event.startDate?.toString()))%>
           <label class="label"  id="${event.startDate}">${sStartDate}</label> 
           <label  for="eventlabel" class="label" ><g:message code="label.field.time"/>:</label>
           <label class="label" id="${event.startTime}">${event.startTime?.toString().substring(0,5).encodeAsHTML()}</label>        
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">    
           <label  for="eventlabel" class="label" ><g:message code="label.field.enddate"/>:</label>
           <% String sEndDate;  if(event.endDate != null) {sEndDate = dateFormat.format(new Date().parse("yyyy-MM-dd", event.endDate?.toString()))}%>
           <label class="label"  id="${event.endDate}">${sEndDate}</label> 
           <label  for="eventlabel" class="label" ><g:message code="label.field.time"/>:</label>
           <label class="label" id="${event.endTime}">${event.endTime?.toString()?.substring(0,5)?.encodeAsHTML()}</label>     
       </p>
       <p class = "leftAlign" style="list-style: none outside none;">
            <label  for="eventlabel" class="label"><g:message code="label.field.place"/>:</label>
            <label class="label"  id="${event.loc}">${event.loc?.name.encodeAsHTML()}</label>
          	<label class="label"  id="${event.address}">${event.address?.encodeAsHTML()}</label>
       </p>
        <p class = "leftAlign" style="list-style: none outside none;">
            <label  for="eventlabel" class="label"><g:message code="label.field.city"/>:</label>
           	<label class="label"  id="${event.city}">${event.city?.encodeAsHTML()}</label>
       </p>
       </div>
    </td>
    </table>    
    </g:each>
    <div class='paginateButtons'>
    <g:if test="${results}">
    <g:paginate  controller="display" action="searchResults" params="${[dateIni:dateIni, dateLast: dateLast]}" offset="${offset}" total="${results?.totalCount}" max="3"  />
    </g:if>
    </div>
    </g:else>
	</g:if>
    <g:else>
        <%
		String forwardUri = request.forwardURI-request.contextPath;
		%>
            <g:link controller="twitterLogin" action="login" params="[forwardUri: forwardUri]">Signin with Twitter</g:link>
     </g:else>     
   </g:form>
 </div>
 
