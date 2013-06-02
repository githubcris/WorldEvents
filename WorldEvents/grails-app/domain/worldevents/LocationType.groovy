package worldevents

class LocationType {

	String name
	String lang
	
	
    static constraints = {
		name(blank:false)
		lang(blank:false)
    }
		
}
