package worldevents

import twitter4j.*
import twitter4j.internal.json.UserJSONImpl
import java.text.SimpleDateFormat

class EventController {

	def twitterService
	
	def newevent = {}
	
	def searchResults = {}
	
	def search = {}
	
	def searchToday = {}
	
	def showdetail = {}
		
	def index() { 
		
		 searchToday()
	}
	
	def showdetail()
	{
		params.mode = 'detail'
		
		Myevent myevent =  Myevent.get(params.id)
		
		if (myevent!=null)
		{
			myevent.getEventDate()
		
			render view: "display",  model: [ myevent: myevent]
		}
		else
		{
			params.mode = null
			params.deletedevent = true
			render  view: "display", action:"index"
		}
	}

	def newevent() 
	{
		
		redirect controller:"newEvent"
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
		
		java.sql.Date filterDateLast  = DateUtil.today()
		
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
		
		
		def entryCriteria = Myevent.createCriteria()
	
		def friendList = session.userFriends
		
		def results = entryCriteria.list {
			
			 between("eventdate", filterDateIni, filterDateLast)
			 
			 if(params.followers == "on")			 {
				 
				user {
					  inList("twitter_id", friendList)
				 }
				
			 }
		}

		 render(view:'display', model:['results':results, 'mode' : 'list', 'name':params?.name, 'dateIni':params.dateIni, 'dateLast':params.dateLast])

	}
}
	

