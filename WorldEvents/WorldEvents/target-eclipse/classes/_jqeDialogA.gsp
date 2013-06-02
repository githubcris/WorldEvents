<div>
This is my NEW Dialog:
<jque:showDialog dialogId="myDialog" buttonCaption="Show Dialog"/>
<jque:dialog controller='test' action="testCall" ajax="true" fields="${[[name: 'message', value:'Hello World']]}" id='myDialog' title="Test Dialog" success="s_div" width="400" />

<div id="s_div" style="border:1px solid blue;">
HTML borders are best created with CSS.
</div>

</div>