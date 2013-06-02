package worldevents

class DisplayController {

   	def twitterService
	
	def index = {}
	   
	def showdetail = {}
	   
	def newevent = {}
	
	def searchResults = {}
	
	def searchToday = {}
	
	def search = {}	
	
		
	def index() { 
		
		 searchToday()
	}
	
	def showdetail()
	{
		Event event =  Event.get(params.id)
		
		if (event!=null)
		{
			event.getEventDate()
		
			params.mode = 'detail'
			
			render view: "display",  model: [ event: event]
		}
		else
		{
			params.deletedevent = true
			
			render  view: 'display', action: 'index'
		}
	}

	def newevent() 
	{		
		redirect controller : 'edit'
	}
	
	def searchResults () {
		
		java.sql.Date filterDateIni

		java.sql.Date filterDateLast
		
		
		try
		{		
			filterDateIni = DateUtil.stringToSqlDate(params.dateIni)
		
			filterDateLast =  DateUtil.stringToSqlDate(params.dateLast)		 
			
			search(filterDateIni, filterDateLast)

		}	
		catch(Exception ex)
		{
		}
	 
	}
	
    def searchToday()
	{
		java.sql.Date filterDateIni = DateUtil.today()
		
		java.sql.Date filterDateLast  = null
		
		params.dateIni = DateUtil.stringToday()
		params.dateLast = DateUtil.stringToday()
		
		search(filterDateIni, filterDateLast)	
	}
	
	def search(java.sql.Date filterDateIni, java.sql.Date filterDateLast)
	{
		
		if (filterDateIni == null)
		{
			filterDateIni =  DateUtil.minValue()
			
			params.dateIni = ""
		}
	
		if (filterDateLast == null)
		{
			filterDateLast =  DateUtil.maxValue()
			
			params.dateLast = ""
		}
		
		
		def entryCriteria = Event.createCriteria()
	
		def friendList = session.userFriends
		
		def results = entryCriteria.list ([max:10,offset:params.offset]){
			
			 between("eventdate", filterDateIni, filterDateLast)
			 
			 if(params.followers == "on")			 {
				 
				user {
					  inList("twitter_id", friendList)
				 }
				
			 }
	
			 order("eventdate", "desc")
			 order("eventtime", "desc")
		}
		 
		 render(view:'display', model:['results': results, 'mode' :'list', 'name': params?.name, 'dateIni': params.dateIni, 'dateLast': params.dateLast])

	}
	def list()  {
		[event: Event.list(params), eventCount: Event.count()]
	}
}
