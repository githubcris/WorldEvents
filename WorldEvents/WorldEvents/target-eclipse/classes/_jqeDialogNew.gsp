<div>


<jque:newDialog controller='test' action="testCall" ajax="true" id='myDialog2' title="Test Dialog" 
	success="s_div2" width="1000" labelWidth="40%" columnWidths="${[40,60]}" >
<jque:dialogTab caption="Tab 1" >
<jque:dialogField name="hiddenfield" value="This field is hidden" type="hidden" />
<jque:dialogField name="message" value="Hello world" labelProperty="message.label" />
<jque:dialogField name="messageTwo" value="Wtf?" />
</jque:dialogTab>

<jque:dialogTab caption="Special Tab">
<jque:dialogField name="staticMessage" type="static" value="Static message" />
<jque:checkBoxField name="booleanField" type="checkbox" labelName="Boolean field"  checked="${false}" />
<jque:checkBoxField name="booleanField2" type="checkbox" labelName="2nd boolean field"  checked="${false}" />
<jque:calendarField name="reminder1" value="${new Date()}" />
<jque:calendarField name="reminder3" value="${new Date() + 7}" beginning="true"/>
<jque:calendarField name="reminder2" value="${new Date() + 14}" end="true" />
</jque:dialogTab>

<jque:dialogTab caption="Tab 2" >
<jque:dialogField name="hiddenfield2" value="This field is hidden" type="hidden" />
<jque:dialogField name="messageThree" value="Are you still there?" />
<jque:dialogField name="messageFour" value="Really?" />
</jque:dialogTab>

</jque:newDialog>

This is my NEW Dialog:
<jque:newShowDialog dialogId="myDialog2" buttonCaption="Show New Dialog" init="${[reminder:new Date() + 1]}" staticInit="${[staticMessage:'This is a successful Override!']}" /><br/>
<jque:newShowDialog dialogId="myDialog2" id="myDialog2_launch2" buttonCaption="2 days out both true" 
init="${[reminder:new Date() + 2,message:'Newly Initialized Message',booleanField:true,booleanField2:true]}" 
staticInit="${[staticMessage:'Another Override!']}"
/><br/>
<jque:newShowDialog dialogId="myDialog2" id="myDialog2_launch3" buttonCaption="Show New Dialog 3" 
init="${[reminder:new Date() + 3,booleanField:false]}" 
staticInit="${[staticMessage:'One more Override!']}"
/><br/>

<div id="s_div2" style="border:1px solid blue;">
Will this change???
</div>

<div id="s_div2a" >
This should change!
</div>

<div id="s_div2b" >
This Should change!
</div>

<label><input type="checkbox" id="c" name="a1" /> I'll be checked/unchecked.</label>
<label><input type="checkbox" id="d"  name="a2" /> I'll be checked/unchecked.</label>
<label><input type="checkbox" id="e"  name="a3" /> I'll be checked/unchecked.</label>
 <input type="button" value="Check" onclick='$("input[type=\"checkbox\"]").attr("checked","checked")'/>
 <input type="button" value="Uncheck" onclick='$("input[type=\"checkbox\"]").removeAttr("checked")'/>

</div>

<div>
Grails Form
<g:form controller="test" action="check">
  <g:checkBox name="hello" /> Hello World!
  <g:checkBox name="hello2" /> Hello World Again!
  <input type="submit" value="GO!" />
</g:form>

</div>