package worldevents

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Formatter.DateTime
import org.springframework.context.ApplicationContext
import org.springframework.context.i18n.LocaleContextHolder
import twitter4j.Twitter

class NewEventController {
	
def twitterService
	
def index = {}

def sendtwit = {}

def modevent = {}

def delevent = {}

def saveevent = {}

def sendEventTwit = {}

def index()
{
	render view: "new"
}

def modevent()
{
	
	Myevent myevent =  Myevent.get(params.id)
	
	myevent?.getEventDate()
	
	if (myevent?.user?.twitter_id == session?.user?.twitter_id)
	{
		params.notauthorized = false
		render view: "new",    model: [myevent:myevent]
	}
	else
	{			
		params.notauthorized = true
		
	    render view: "new"
	}
}

def delevent()
{
	Myevent eventInstance = Myevent.get(params.id)
	
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
	redirect controller:'event', action:'index'
}

def sendtwit()
{
	Myevent eventInstance =  Myevent.get(params.id)
	
	eventInstance.getEventDate()
	
	if (eventInstance?.user?.twitter_id == session?.user?.twitter_id)
	{
				
		    sendEventTwit(eventInstance)	
		
			params.mode = 'detail'
			params.username = eventInstance.username
			redirect controller:"event", action:'showdetail', 'mode' : 'detail', 'id' : eventInstance.id
		
			
	}
	else
	{
		render view: "new"
	}
}

def saveevent()  {
	
	try
	{
		Myevent eventInstance
		
		if (params.id != null && params.id !="")
		{ 
			eventInstance = Myevent.get(params.id)
		}
		else
		{
		    eventInstance = new Myevent()
		}
		
		eventInstance.name = params.name
		
		eventInstance.place= params.place
		
		eventInstance.description = params.description
		
		eventInstance.user= session.user
 
		eventInstance.username = session.user.screenName
		
		if (params.eventtime != "")
		{
			java.sql.Time myTime = new java.sql.Time(new Date().parse("HH:mm", params.eventtime).fastTime)
			
			eventInstance.eventtime = myTime
		}
			
		eventInstance.sDate = params.sDate		
		
		eventInstance.setEventDate()
					
		eventInstance.createdate = new java.sql.Timestamp(new Date().fastTime)
		
		eventInstance.validate()
		
		if (eventInstance.hasErrors())
		{
		
			render view:"new",  model: [ myevent:eventInstance ]
		}
		else
		{
		
		if(eventInstance.save())
		{			
			
			params.mode = 'detail'
			params.username = eventInstance.username
			redirect controller:"event", action:'showdetail', 'mode' : 'detail', 'id' : eventInstance.id
		}
	  }
	}
	catch(Exception ex)
	{
		
	}
  }
def sendEventTwit(Myevent event)
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
	
	String url = grailsApplication.config.grails.serverURL + "/event/showdetail/" + event.id.toString()
	
	TwitUtil.sendTwit(twitter, url);
	
}
}