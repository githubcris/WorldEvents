package worldevents
import twitter4j.*
import twitter4j.api.FriendsFollowersResources
import twitter4j.auth.Authorization
import twitter4j.internal.json.UserJSONImpl
import javax.servlet.http.HttpServletRequest
import org.springframework.context.i18n.LocaleContextHolder


class TwitterLoginController {

	def twitterService

	def newevent = {}
	
	def changelanguage = {}		
	
	def index = 
	{
		render view:'menu'
	}
	def login = {
				
		try
		{
			String key = grailsApplication.config.twitter.oauth.consumer_key
			String secret = grailsApplication.config.twitter.oauth.consumer_secret
			
			String url = request.getRequestURL() .toString()-"/grails/twitterLogin/login.dispatch"
	
			if (params.forwardUri==null)
			{
				redirect url: twitterService.authenticate(url + "/twitterLogin/callback", key, secret) // [1]
			}
			else
			{
				redirect url: twitterService.authenticate(url + "/twitterLogin/callback/?forwardUri=" + params.forwardUri, key, secret) // [1]
			}
		
		}
		catch(Exception e)
		{
			render "Se ha producido un error, vuelva a intentarlo pasado unos segundos"
		}
	}
	
	def demologin = {
		
		try
		{
	
		   User user = User.findByTwitter_id(1)

    	    if (!user) {
			 user = new User(twitter_id: 1)
		    }
			
			user.name = "World Events Demo"
			user.screenName = "World Events Demo"
			user.profileImg = resource(dir: 'images', file: 'worldevent.png')
			user.followersCount = 10
			user.friendsCount = 1
			user.twitter_id = 1
			user.save()
			
			session.user = user		
		
			List<Long> userFriends = new List<Long>[1]
			userFriends.addAll(1)
			session.userFriends = userFriends
							
		}
		catch(Exception e)
		{
			render "Se ha producido un error, vuelva a intentarlo pasado unos segundos"
		}
		
		redirect view: 'menu'
	}

	def callback = {
	
		try
		{
		if (params.denied){
			flash.message = "Permiso denegado"

		} else {
	
		    Object twitterUser = twitterService.verifyCredentials(params.oauth_verifier)		    
			
			User myUser = checkTwitterUser(twitterUser)
			
			session.user = myUser
		
			Twitter twitter = twitterService.getTwitter()
	
			session.userFriends = TwitUtil.getFriends(twitter, myUser.twitter_id, myUser.friendsCount)
			
			Locale.setDefault(new Locale('es'))
	        }
		}
		catch(Exception ex)
		{
		
		}
		
		if (params.forwardUri!="")
		{
		  redirect url: params.forwardUri
		}
		else
		{
			redirect view: 'menu'
		}
	}

	def newevent()
	{
		redirect controller:'edit'
	}
		
	private checkTwitterUser(Object twitterUser) {
			
		User user = User.findByTwitter_id(twitterUser.id)

    	if (!user) {
			user = new User(twitter_id: twitterUser.id)
		}

		user.name = twitterUser.name
		user.screenName = twitterUser.screenName
		user.profileImg = twitterUser.profileImageURL.toString()
		user.followersCount = twitterUser.followersCount
		user.friendsCount = twitterUser.friendsCount
	    user.save()		
	
	}

	def logout = {
		session.invalidate()
		redirect action: 'index'
	}
	
	def changelanguage()
	{
		String targetUri = params.targetUri ? params.targetUri : "/?lang=es"
		
        redirect(uri: targetUri)
	}
}