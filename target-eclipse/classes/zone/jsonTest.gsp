<html>
    <head>
        <title>Welcome to Grails</title>
        <meta name="layout" content="main" />
   <g:javascript plugin="jquery" library="jquery" />
   <g:javascript library="application" />
   <jqui:resources />
   <g:javascript plugin="jquery-ui-extensions" library="jquery-extensions" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">

     </head>
    <body>

  
<script type="text/javascript"> 
var myObjects = ${jsonObjects};
	
$.each(myObjects, function(index, value) { 
	  var clzNames = value.class.split('.');
	  var clz = clzNames[clzNames.length-1];
});
</script> 

<div class="demo-container">
  <div class="demo-box">Demonstration Box</div>
  <ul>
  <li>list item 1</li>
  <li>list <strong>item</strong> 2</li>
  </ul>
  </div>
  
<script type="text/javascript"> 
$('div.demo-container').append(myObjects['Zone2'].code);
</script>


        
    </body>
</html>
