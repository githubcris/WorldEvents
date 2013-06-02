<div>
This is my NEW Dialog:
<jque:newShowDialog dialogId="myDialog" buttonCaption="Show New Dialog"/>


<jque:newDialog controller='test' action="redirectTest" ajax="true" id='myDialog' title="Redirect Test" newPage="${true}" width="600">
<jque:dialogField name="message" value="This should redirect!" />
</jque:newDialog>

</div>