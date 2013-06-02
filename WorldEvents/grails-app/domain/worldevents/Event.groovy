package worldevents

import java.util.Date;
import grails.validation.Validateable

@Validateable
class Event {

    String name
	Date createdate
	String description
	java.sql.Date startDate
	java.sql.Time startTime
	java.sql.Date endDate
	java.sql.Time endTime
	User user
	String sStartDate
	String sEndDate
	LocationType loc
	String address
	String city
	
	void setStartDate() {
			this.startDate = DateUtil.stringToSqlDate(sStartDate)
		}
	
	void setEndDate() {
		this.endDate = DateUtil.stringToSqlDate(sEndDate)
	}
	
	void getStart()
	{
		this.sStartDate = DateUtil.dateToString(this.startDate)
	}
	
	void getEnd()
	{
		if (this.endDate != null)
		{
			this.sEndDate = DateUtil.dateToString(this.endDate)
		}
	}
	
	static transients = ["sStartDate","sEndDate","setStartDate","setEndDate"]
	
	static constraints = {
		name(blank: false)
		description(blank:true)
		createdate(blank:false)
		startDate(blank:false)
		sStartDate(blank:false)
		sEndDate(blank:true)
	    startTime(blank:false)
		address(blank:false)
		city(blank:false)
		endDate(nullable: true)
		endTime(nullable: true)
	}
	
	static belongsTo = [User,LocationType]	

}
