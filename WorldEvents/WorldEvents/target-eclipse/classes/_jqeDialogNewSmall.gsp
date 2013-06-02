<div>
This is my NEW Dialog:
<jque:newShowDialog dialogId="myDialog3" buttonCaption="Show New Dialog"/>


<jque:newDialog controller='test' action="testCall" ajax="true" id='myDialog3' title="Test Dialog" success="s_div3" width="600">
<jque:dialogTrigger controller="test" action="computeSalesTax" target="message" name="tax" />
<jque:dialogTrigger controller="test" action="getZones" target="state" name="zones" />
<jque:dialogField name="country" from="${['US','Canada']}" trigger="zones" noSelection="${['':'-Select-']}" />
<jque:dialogField name="state" from="${[]}" trigger="tax" noSelection="${['':'-Select-']}" optionKey="id" optionValue="code" />
<jque:dialogField name="grossSaleAmount" value="45.0" trigger="tax" />
<jque:dialogField name="message" value="Are you still there?" />
</jque:newDialog>


<div id="s_div3" style="border:1px solid blue;">
Will this change???
</div>

</div>