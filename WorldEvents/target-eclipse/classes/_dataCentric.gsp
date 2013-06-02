<script type="text/javascript">
$(document).ready(function() {
    //check all checkboxes
    $("#check_all_boxes").click(function() {
        $($('input[name*="oid"]')).each(function(i){
            $(this).attr("checked","checked");
        });
    });
 
    //uncheck all checkboxes
    $("#uncheck_all_boxes").click(function() {
        $($('input[name*="oid"]')).each(function(i){
            $(this).removeAttr("checked");
        });
    }); 
});
</script>

<div>
JSON Data Centric Test

<g:javascript>
</g:javascript>

<g:remoteLink controller="test"  action="dataCentricCall" update="foo" onSuccess="updateObjects(data)">
    Update Book
</g:remoteLink>

<jque:newShowDialog dialogId="myDialog3" buttonCaption="Show New Dialog"/>


<jque:newDialog controller='test' action="dataCentricCall" ajax="true" id='myDialog3' 
	title="Data Centric" success="s_div3" width="600"  dataCentric="true" >
	<jque:dialogField name="message" value="Are you still there?" />
</jque:newDialog>


<g:set var="zone1" value="${new com.webcleats.test.Zone (id:1, code:'ON', name:'Onterio')}" />
<g:set var="zone2" value="${new com.webcleats.test.Zone (id:2, code:'VN', name:'Vancuver')}" />
<jque:editDialog domainClass="Zone" width="600" labelWidth="20%" multiselect="true" >
<jque:dialogField name="code" sizeClass="tiny" />
<jque:dialogField name="name" />
<jque:checkBoxField name="domestic" />
<jque:dialogField name="extra" />
</jque:editDialog>
<jque:deleteDialog domainClass="Zone" />

<table>
<jque:tr bean="${zone1}" >
Zone 1:
<jque:td bean="${zone1}" field="code" />
<jque:td bean="${zone1}" field="name" />
<jque:td bean="${zone1}" field="domestic" />
<td>
<jque:editLauncher bean="${zone1}"  />
<jque:deleteLauncher bean="${zone1}" />
</td>
</jque:tr>
<jque:tr bean="${zone2}" >
Zone 2:
<jque:td bean="${zone2}" field="code" />
<jque:td bean="${zone2}" field="name" />
<jque:td bean="${zone2}" field="domestic" />
<td>
<jque:editLauncher bean="${zone2}"  init="${[extra:'This is an Extra message override']}" />
<jque:deleteLauncher bean="${zone2}" />
</td>
</jque:tr>
</table>
</div>

<div>
Multi-select
				<input type="button" id="check_all_boxes" value="Check All" /> 
				<input type="button" id="uncheck_all_boxes" value="Uncheck All" /> 				
<br/>
<g:checkBox name="oid" value="123" checked="false"/> Object 1 <br/>
<g:checkBox name="oid" value="232" checked="false" /> Object 2 <br/>
<g:checkBox name="oid" value="434" /> Object 3





</div>