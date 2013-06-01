<script type="text/javascript">
var jZones = ${jsonZones};

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

    populateTable(jZones);
});
</script>

<div>
JSON Data Centric Test
<table id="jsonTable" >
<thead>
<tr>
<th>Code</th><th>Name</th><th>Created</th>
</tr>
</thead>
<tbody>
<tr class="template"  style="display:none;">
<td class="code"></td>
<td class="name"></td>
<td class="createdAt"></td>
</tr>
</tbody>
</table>

<hr/><br/>

<g:remoteLink controller="test"  action="dataCentricCall" update="foo" onSuccess="updateObjects(data)">
    Update Book
</g:remoteLink>

<jque:newShowDialog dialogId="myDialog3" buttonCaption="Show New Dialog"/>


<jque:newDialog controller='test' action="dataCentricCall" ajax="true" id='myDialog3' 
	title="Data Centric" success="s_div3" width="600"  dataCentric="true" >
	<jque:dialogField name="message" value="Are you still there?" />
</jque:newDialog>


<jque:editDialog domainClass="Zone" width="600" labelWidth="20%" multiselect="true" >
<jque:dialogField name="code" sizeClass="tiny" />
<jque:dialogField name="name" />
<jque:checkBoxField name="domestic" />
<jque:dialogField name="extra" />
<jque:calendarField name="createdAt" />
</jque:editDialog>
<jque:deleteDialog domainClass="Zone" />

<table>
<g:each in="${zones}" var="zone" >
<jque:tr bean="${zone}" >
<jque:td bean="${zone}" field="code" />
<jque:td bean="${zone}" field="name" />
<jque:td bean="${zone}" field="domestic" />
<td>
<jque:editLauncher bean="${zone}"  />
<jque:deleteLauncher bean="${zone}" />
</td>
</jque:tr>
</g:each>
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