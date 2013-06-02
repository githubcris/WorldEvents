<!--  Start my plugin -->

<div class="demo-container">
  <div class="demo-box">Demonstration Box</div>
  <ul>
  <li>list item 1</li>
  <li>list <strong>item</strong> 2</li>
  </ul>
  </div>
  
<script type="text/javascript"> 
var myObjects = [{"class":"com.webcleats.ecommerce.Customer","id":2,"accountExpired":false,"accountLocked":false,"addresses":[],"cellPhone":null,"dateCreated":"2012-02-20T16:59:11Z","defaultAddress":null,"email":"sherree@webcleats.com","enabled":true,"fax":null,"firstName":null,"homePhone":null,"lastName":null,"lastUpdated":"2012-02-20T16:59:11Z","okToContact":true,"password":"f8229a6bff4d149e0f92d2a19759c74d4a621a8d4cc7ecb77cc925f430e8d853","passwordExpired":false,"paymentProfiles":[],"username":"sherreep","workPhone":null},{"class":"com.webcleats.ecommerce.Customer","id":3,"accountExpired":false,"accountLocked":false,"addresses":[],"cellPhone":null,"dateCreated":"2012-02-20T16:59:11Z","defaultAddress":null,"email":"zach@webcleats.com","enabled":true,"fax":null,"firstName":null,"homePhone":null,"lastName":null,"lastUpdated":"2012-02-20T16:59:11Z","okToContact":true,"password":"f8229a6bff4d149e0f92d2a19759c74d4a621a8d4cc7ecb77cc925f430e8d853","passwordExpired":false,"paymentProfiles":[],"username":"zachp","workPhone":null},{"class":"com.webcleats.ecommerce.Customer","id":4,"accountExpired":false,"accountLocked":false,"addresses":[],"cellPhone":null,"dateCreated":"2012-02-20T16:59:11Z","defaultAddress":null,"email":"ben@webcleats.com","enabled":true,"fax":null,"firstName":null,"homePhone":null,"lastName":null,"lastUpdated":"2012-02-20T16:59:11Z","okToContact":true,"password":"f8229a6bff4d149e0f92d2a19759c74d4a621a8d4cc7ecb77cc925f430e8d853","passwordExpired":false,"paymentProfiles":[],"username":"benp","workPhone":null}]	

$.each(myObjects, function(index, value) { 
	  var clzNames = value.class.split('.');
	  var clz = clzNames[clzNames.length-1];
	  $('div.demo-container').append(index + ':' + value.name + '<br/>');
});

</script> 

  !--  End My Plugin -->

