<!DOCTYPE html>
<%@page import="worldevents.Event"%>
<%@page import="worldevents.ParticipantsUtil"%>
<%@page import="org.springframework.context.i18n.LocaleContextHolder"%>
<g:javascript library="jquery"/>
<r:require module="jquery-ui"/>
<meta name="layout" content="main"/>
<r:layoutResources/>
<g:javascript src="timedatepicker.js" />
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
<link rel="stylesheet" href="${resource(dir:'css',file:'timedatepicker.css')}"/> 
<div>
  <g:form action = "searchResults" class="center" >
  <g:if test="${session.user}">
  <div class="headLabel">
        <img  src="${session.user.profileImg}"/>  <strong>${session.user.name}</strong>
  </div>
  <g:if  test="${params.mode == 'detail'}" >  
    <table>	 
     <tr>
	 <td  style= "vertical-align: top; width:40px;">	 
	 </td>
	 <td>
	 <div class="separator"></div>
     <div class="littlenav" role="navigation">
			<ul>
				<li> <img  src="${event?.user?.profileImg}" width="21px" height="21px" /> 
				 ${event?.user.name?.encodeAsHTML()}</li>
		   </ul>
	</div>
	<div class="separator"></div>
		<%String targetUris = (request.forwardURI - request.contextPath) %>
	<div class="toolnav" role="navigation">
	      <ul>				
				<li> <a> <g:link action="assist"  params="[id:event?.id, targetReturn:targetUris, params:params]">
            		<g:message code="default.igo.label"/>  </g:link></a>
         	    </li>
         	    <li><a>
         	      <g:link action="sendtwitdetail"  controller="display"  class="label" id="${event.id}" params="[id:event?.id, targetReturn:targetUris, params:params]">
            		<g:message code="default.sendtwit.label"/>
            	  </g:link>
         	    </a></li>
         	    <g:if test="${session?.user?.twitter_id == event?.user?.twitter_id }">
         	    <li><a>
         	    	<g:link action="modevent"  controller="edit"  class="label" id="${event.id}">
            		<g:message code="default.edit.label"/>
            	</g:link>    
         	    </a></li>
         	    <li><a>
         	   		 <g:link action="delevent"  controller="edit"  class="label" id="${event.id}">
           			 <g:message code="default.delete.label"/>
           			 </g:link>
         	    </a></li>   
         	    </g:if>
		 </ul>
	</div>
	<div class="separator3"></div>	
	<div class="blanknav" role="navigation">
	 <ul>
	   <li>
			<g:link action="showdetail"  controller="display"   id="${event.id}">${event.name?.encodeAsHTML()}</g:link>
	   </li>
	 </ul>
	</div>			
	<div class="separator3"></div>	
	<div class="itemlist" > 	         
       <p>
            <label class="label" ><g:message code="label.field.description"/>:</label>
          	${event.description?.encodeAsHTML()}
       </p>
       <div class="separator3"></div>
       <p>   
           <label  class="label" ><g:message code="label.field.startdate"/>:</label>
              <%java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
			  <%String sStartDate = dateFormat.format(new Date().parse("yyyy-MM-dd", event.startDate?.toString()))%>
           ${sStartDate}
           <label class="label" ><g:message code="label.field.time"/>:</label>
          ${event.startTime?.toString().substring(0,5).encodeAsHTML()}        
       </p>
       <div class="separator3"></div>
       <p>   
           <label><g:message code="label.field.enddate"/>:</label>
           <% String sEndDate;  if(event.endDate != null) {sEndDate = dateFormat.format(new Date().parse("yyyy-MM-dd", event.endDate?.toString()))}%>
           ${sEndDate}
           <label class="label" ><g:message code="label.field.time"/>:</label>
           ${event.endTime?.toString()?.substring(0,5)?.encodeAsHTML()} 
       </p>
       <div class="separator3"></div>
       <p>
            <label  for="eventlabel" class="label"><g:message code="label.field.place"/>:</label>
            ${event.loc?.name.encodeAsHTML()} ${event.address?.encodeAsHTML()}
       </p>
       <div class="separator3"></div>
        <p>
            <label class="label"><g:message code="label.field.city"/>:</label>
           	${event.city?.encodeAsHTML()}
       </p>
       <div class="separator3"></div>
       <p>
        <label class="label"><g:message code="default.participants.label"/></label>:  ${ParticipantsUtil.getParticipantsNumber(event.id)?.encodeAsHTML()}  
       </p>
       <div class="separator3"></div>
       <p class = "centerAlign" style="list-style: none outside none;"></p>
       	     <div class="leftAlign" id="map" style="width: 400px; height: 300px" >
       	      <script type="text/javascript">
             	  loadMap("${event.loc.name+' '+event.address+' '+ event.city}","map");
           	  </script>
      		 </div>      
     </div>
    </td>
    </tr>
    </table>          
  </g:if>
  <g:else>
  <div class="headLabel">
  <p>
  	<g:message   width="22px" code="label.filter.from"/>:
    <g:textField width="22px"  id="datepickerini${LocaleContextHolder.getLocale()?.toString()?.substring(0,2)}" name="dateIni" value="${dateIni}" />
   	<g:message width="22px" code="label.filter.to"/>: 
   	<g:textField width="22px"   id="datepickerlast${LocaleContextHolder.getLocale()?.toString().substring(0,2)}"  name="dateLast" value="${dateLast}" />
   	<g:actionSubmit class="buttons" name= "search" action="searchResults"  value ="${g.message(code: 'label.filter.search')}"  />
  </p>
	<div class="separator"></div>
  <p style="vertical-align:center; height:42px;">
  		 <g:message code="label.filter.followers"/>
  		 <g:checkBox name="followers" value="${followers}"/>
  </p> 		 
  </div>  
  <script>
  </script>
       <g:if test="${params.deletedevent}">
          <script>
         	 alert('${g.message(code: 'label.error.eventdelete')}')
          </script>
       </g:if>
    	 <g:each in="${results}" var="event" style="list-style: none outside none;">	   
	 <table>	 
	 <tr>
	 <td  style= "vertical-align: top; width:40px;">	 
	 </td>
	 <td>
	 <div class="separator"></div>
	  <div class="littlenav" role="navigation">
			<ul>
				<li> <img  src="${event?.user?.profileImg}" width="21px" height="21px" /> 
				 ${event?.user.name?.encodeAsHTML()}</li>
		   </ul>
	</div>
	<div class="separator"></div>
	<div class="toolnav" role="navigation">
	      <ul>
				<%String targetReturn = (request.forwardURI - request.contextPath) %>
				<li> <a> <g:link action="assistlist"   id="${participants}"  params="[id: event?.id,targetReturn:targetReturn,max:params.max,dateIni:params.dateIni,dateLast:params.dateLast,offset:params.offset,followers:params.followers ]">
            		<g:message code="default.igo.label"/>  </g:link></a>
         	    </li>
         	    <li><a>
         	      <g:link action="sendtwitlist"  controller="display"  class="label" id="${event.id}" params="[id: event?.id,targetReturn:targetReturn,max:params.max,dateIni:params.dateIni,dateLast:params.dateLast,offset:params.offset,followers:params.followers ]">
            		<g:message code="default.sendtwit.label"/>
            	  </g:link>
         	    </a></li>
         	    <g:if test="${session?.user?.twitter_id == event?.user?.twitter_id }">
         	    <li><a>
         	    	<g:link action="modevent"  controller="edit"  class="label" id="${event.id}">
            		<g:message code="default.edit.label"/>
            	</g:link>    
         	    </a></li>
         	    <li><a>
         	   		 <g:link action="delevent"  controller="edit"  class="label" id="${event.id}">
           			 <g:message code="default.delete.label"/>
           			 </g:link>
         	    </a></li>   
         	    </g:if>
		 </ul>
	</div>
	<div class="separator"></div>	
	<div class="blanknav" role="navigation">
	  <ul>
		<li>
		<g:link action="showdetail"  controller="display"   id="${event.id}">${event.name?.encodeAsHTML()}</g:link>
		</li>
	 </ul>
	</div>		
	<div class="separator3"></div>
	
	 <div class="itemlist" > 	   
      
       <p class = "leftAlign" style="list-style: none outside none;">
            <label  for="eventlabel" class="label" ><g:message code="label.field.description"/>:</label>
          	${event.description?.encodeAsHTML()}
       </p>
       <div class="separator3"></div>
       <p>   
           <label class="label" ><g:message code="label.field.startdate"/>:</label>
              <%java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
			  <%String sStartDate = dateFormat.format(new Date().parse("yyyy-MM-dd", event.startDate?.toString()))%>
           ${sStartDate}
           <label class="label" ><g:message code="label.field.time"/>:</label>
          ${event.startTime?.toString().substring(0,5).encodeAsHTML()}        
       </p>
       <div class="separator3"></div>
       <p>   
           <label ><g:message code="label.field.enddate"/>:</label>
           <% String sEndDate;  if(event.endDate != null) {sEndDate = dateFormat.format(new Date().parse("yyyy-MM-dd", event.endDate?.toString()))}%>
           ${sEndDate}
           <label class="label" ><g:message code="label.field.time"/>:</label>
           ${event.endTime?.toString()?.substring(0,5)?.encodeAsHTML()} 
       </p>
        <div class="separator3"></div>
       <p>
            <label  for="eventlabel" class="label"><g:message code="label.field.place"/>:</label>
            ${event.loc?.name.encodeAsHTML()} ${event.address?.encodeAsHTML()}
       </p>
       <div class="separator3"></div>
        <p>
            <label class="label"><g:message code="label.field.city"/>:</label>
           	${event.city?.encodeAsHTML()}
       </p>
        <div class="separator3"></div>
       <p>
        <label class="label"><g:message code="default.participants.label"/></label>:  ${ParticipantsUtil.getParticipantsNumber(event.id)?.encodeAsHTML()}  
       </p>
       </div>
    </td>
    </tr>
    </table>    
    </g:each>
    <g:if test="${results?.totalCount>2}">
    <div class='pagination'>
    <g:paginate  controller="display" action="searchResults" params="${[dateIni:dateIni, dateLast: dateLast, followers:followers]}" offset="${offset}" total="${results?.totalCount}" max="2"  />
    </div>
    </g:if>    
    </g:else>
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
 
