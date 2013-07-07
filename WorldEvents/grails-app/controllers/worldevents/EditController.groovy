package worldevents

import twitter4j.Twitter

import org.springframework.context.i18n.LocaleContextHolder

class EditController {


def index = {}

def saveevent = {}

def modevent = {}

def index()
{
	String currentLang = LocaleContextHolder.getLocale().language.toString()	

	params.locationtypes =  LocationTypes.getlist(currentLang)

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
		
		event.description = params.description
		
		event.user= session.user
		 
		if (params.startTime != null && params.startTime != "")
		{
			java.sql.Time startTime = new java.sql.Time(new Date().parse("HH:mm", params.startTime).fastTime)
			
			event.startTime = startTime
		}
		
		if (params.endTime != null && params.endTime != "")
		{
			java.sql.Time endTime = new java.sql.Time(new Date().parse("HH:mm", params.endTime).fastTime)
			
			event.endTime = endTime
		}
			
		event.sStartDate = params.sStartDate		
			
		event.setStartDate()
		
		event.sEndDate = params.sEndDate
		
	    event.setEndDate()
		
		event.createdate = new java.sql.Timestamp(new Date().fastTime)
		
		event.loc= LocationType.get(params.loc)
		
		event.address = params.address
		
		event.city = params.city
		
		event.validate()
		
		if (event.hasErrors())
		{
			String currentLang = LocaleContextHolder.getLocale().language.toString()
			
			params.locationtypes =  LocationTypes.getlist(currentLang)
			
			render view: 'edit',  model: [ event:event ]
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
	String currentLang = LocaleContextHolder.getLocale().language.toString()
	
	params.locationtypes = LocationTypes.getlist(currentLang)
	
	Event event =  Event.get(params.id)
	
	event.getStart()
	
	event.getEnd()
	
	if (event.user?.twitter_id == session?.user?.twitter_id)
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
	Event event = Event.get(params.id)
	
	try
	{
	    if (event!=null)
		{
			if(event.delete(flush: true))
			{
			}
	    }
	}
	catch(Exception ex)
	{
		
	}
	
	redirect controller:'display', action:'index'
}



}
