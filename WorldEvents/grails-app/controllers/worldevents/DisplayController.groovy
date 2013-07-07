package worldevents

import twitter4j.Twitter

import org.springframework.context.i18n.LocaleContextHolder

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
		
		params.participantsCount = ParticipantsUtil.getParticipantsNumber(new Long(params.id))	
		
		if (event!=null)
		{
			event.getStart()
		
			event.getEnd()
			
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
		
		if (params.followers == "")
		{
		   params.followers = null
		}
		def entryCriteria = Event.createCriteria()
	
		def friendList = session.userFriends
		
		def results = entryCriteria.list ([max:2,offset:params.offset]){
			
			 between("startDate", filterDateIni, filterDateLast)
			 
			 if (params.followers == "on" && friendList!=null)			 {
				 
				user {
					  inList("twitter_id", friendList)
				 }
				
			 }
	
			 order("startDate", "desc")
			 order("startTime", "desc")
		}
		 
		 render(view:'display', model:['results': results, 'mode' :'list', 'name': params?.name, 'dateIni': params.dateIni, 'dateLast': params.dateLast, 'followers':params.followers])

	}
	
	def sendtwitlist(){
		
		Event event =  Event.get(params.id)
		
		event.getStart()
				
		sendEventTwit(event)	
		
		searchResults()
			
	}
	
	def sendtwitdetail(){
		
		String targetReturn = params.targetReturn ? params.targetReturn : "/"
		
		Event event =  Event.get(params.id)
		
		event.getStart()
				
		sendEventTwit(event)
			
		redirect (uri:targetReturn)
	
	}
	
	private sendEventTwit(Event event)
	{
		String lblnewEvent;
		String lbldateEvent;
		String lblplaceEvent;
		
		if (LocaleContextHolder.getLocale().language == 'es')
		{
			lblnewEvent = "Nuevo evento: "
			lbldateEvent = "Fecha: "
			lblplaceEvent = "Lugar: "
		}
		else
		{
			lblnewEvent = "New event: "
			lbldateEvent = "Date: "
			lblplaceEvent = "Place: "
		}
			
		String mess =lblnewEvent+ event.name + " " + lbldateEvent + event.sStartDate + " " + event.startTime.toString() + " " + lblplaceEvent+ event.loc.name + " " + event.address + " " + event.city + ", "+ event.description
		
		if(mess.length()>140)
		{
			mess = mess.substring(0,139)
		}
		
		Twitter twitter = twitterService.getTwitter()
		
		TwitUtil.sendTwit(twitter, mess)
		
		String url = grailsApplication.config.grails.serverURL + "/display/showdetail/" + event.id.toString()
		
		TwitUtil.sendTwit(twitter, url)
	}
	
	def assist()
	{			
		String targetReturn = params.targetReturn ? params.targetReturn : "/"		
		
		doassist()
				
		redirect (uri:targetReturn)
	}

	
	def assistlist()
	{
		doassist()
		searchResults()
	}
	
	private doassist()
	{
				
		Long eventid = new Long(params.id)
		
		Long userid = new Long (session.user.id)

		if (!ParticipantsUtil.participant(eventid, userid))
		{
			ParticipantsUtil.goEvent(eventid, userid)
		}		
	}
}
