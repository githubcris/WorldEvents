package worldevents

class User {

    Long followersCount
	Long friendsCount
	String name
	String profileImg
	String screenName
	Long twitter_id
	static hasMany = [myevents: Myevent]

	static mapping = {
		twitter_id unique: true
	}
}

