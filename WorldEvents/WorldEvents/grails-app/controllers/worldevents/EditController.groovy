package worldevents

import twitter4j.Twitter
import org.springframework.context.i18n.LocaleContextHolder

class EditController {

def twitterService
	
def index = {}

def saveevent = {}

def modevent = {}

def delevent = {}

def sendtwit = {}

def sendEventTwit = {}

def index()
{
	render view: 'edit'
}

def saveevent()  {
	
	try
	{
		Event event
		
		if (params.id != null && params.id !="")
		{
			event = Event.get(params.id)
		}
		else
		{
			event = new Event()
		}
		
		event.name = params.name
		
		event.place= params.place
		
		event.description = params.description
		
		event.user= session.user
		 
		if (params.eventtime != "")
		{
			java.sql.Time myTime = new java.sql.Time(new Date().parse("HH:mm", params.eventtime).fastTime)
			
			event.eventtime = myTime
		}
			
		event.sDate = params.sDate
		
		event.setEventDate()
					
		event.createdate = new java.sql.Timestamp(new Date().fastTime)
		
		event.validate()
		
		if (event.hasErrors())
		{
			render view:"new",  model: [ event:event ]
		}
		else
		{
		
			if(event.save())
			{
				params.mode = 'detail'

				redirect controller: 'display', action:'showdetail', 'mode' : 'detail', 'id' : event.id
			}
	  }
	}
	catch(Exception ex)
	{
		
	}
 }

def modevent()
{
	
	Event event =  Event.get(params.id)
	
	event?.getEventDate()
	
	if (event?.user?.twitter_id == session?.user?.twitter_id)
	{
		params.notauthorized = false
		
		render view: 'edit', model: [event:event]
	}
	else
	{			
		params.notauthorized = true
		
	    render view: 'edit'
	}
}

def delevent()
{
	Event eventInstance = Event.get(params.id)
	
	try
	{
	    if (eventInstance!=null)	{
		if(eventInstance.delete(flush: true))
		{
			}
	    }
	}
	catch(Exception ex)
	{
		
	}
	redirect controller:'display', action:'index'
}

def sendtwit(){
	Event event =  Event.get(params.id)
	
	event.getEventDate()
	
	if (event?.user?.twitter_id == session?.user?.twitter_id)
	{
			
		    sendEventTwit(event)	
		
			params.mode = 'detail'
		
			redirect controller: 'display', action:'showdetail', 'mode' : 'detail', 'id' : event.id

	}
	else
	{
		render view: 'edit'
	}
}

def sendEventTwit(Event event)
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
		
	String mess =lblnewEvent+ event.name + " " + lbldateEvent + event.sDate + " " + event.eventtime.toString() + " " + lblplaceEvent+ event.place + ", "+ event.description
	
	if(mess.length()>140)
	{
		mess = mess.substring(0,139)
	}
	
	Twitter twitter = twitterService.getTwitter()
	
	TwitUtil.sendTwit(twitter, mess);
	
	String url = grailsApplication.config.grails.serverURL + "/display/showdetail/" + event.id.toString()
	
	TwitUtil.sendTwit(twitter, url);
	
}
}
