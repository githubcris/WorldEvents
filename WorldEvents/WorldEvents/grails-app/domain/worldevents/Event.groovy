package worldevents

import java.util.Date;
import grails.validation.Validateable

@Validateable
class Event {

    String name
	Date createdate
	String description
	java.sql.Date eventdate
	java.sql.Time eventtime
		String place
	User user
		String sDate
	
	void setEventDate() {
			this.eventdate = DateUtil.stringToSqlDate(sDate)
		}
	
	void getEventDate()
	{
		this.sDate = DateUtil.dateToString(this.eventdate)
	}
	
	static transients = ["sDate","setEventDate"]
	
	static constraints = {
		name(blank: false)
		description(blank:true)
		createdate(blank:false)
		eventdate(blank:false)
	    eventtime(blank:false)
		place(blank:false)
		sDate(blank:false)

	}
	
	static belongsTo = [User]
}
