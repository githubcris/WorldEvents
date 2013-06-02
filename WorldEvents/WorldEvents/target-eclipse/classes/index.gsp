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
        <div id="pageBody">
            <h1>Welcome!</h1>
    Css Test:
    
    <div class="myclass">Hello world!</div>      
      
            </div>
<br/><br/>


<br/><br/>
         
<g:render template="dataCentric" />
        
    </body>
</html>
