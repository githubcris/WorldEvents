package worldevents

import groovy.swing.factory.ColumnFactory

class LocationTypes {
	
	public static getlist(String lang){		
		
		def entryCriteria = LocationType.createCriteria()
		
		def locationTypes = entryCriteria.list (){
			eq("lang",lang)	
		}
		 return locationTypes
	
	}
}
