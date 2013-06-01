package worldevents
import java.util.Date;

import grails.validation.Validateable
@Validateable
class Myevent {

	Date createdate
	String description
	java.sql.Date eventdate
	java.sql.Time eventtime
	String name
	String place
	User user
	String username
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
		username (blank: false)
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
