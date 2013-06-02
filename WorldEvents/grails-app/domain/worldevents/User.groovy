package worldevents
import grails.validation.Validateable

@Validateable
class User {

    Long followersCount
	Long friendsCount
	String name
	String profileImg
	String screenName
	Long twitter_id

	static mapping = {
		twitter_id unique: true
	}
}

