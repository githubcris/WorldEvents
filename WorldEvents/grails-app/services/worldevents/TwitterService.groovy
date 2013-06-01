package worldevents

import org.codehaus.groovy.grails.commons.*
import twitter4j.*
import twitter4j.auth.*
//import winterwell.jtwitter.Twitter
import java.lang.Object.*

class TwitterService {

	static transactional = false
	static scope = 'session'


	 Twitter twitter


	RequestToken requestToken

	String authenticate(String returnUrl, String key, String secret) {
		
		twitter = new TwitterFactory().getInstance()		
	
		twitter.setOAuthConsumer(key, secret)
		
		requestToken = twitter.getOAuthRequestToken(returnUrl)	
	
		return requestToken.getAuthenticationURL()
	}
	
	Twitter myTwitter()
	{
			return twitter
	}

	Object verifyCredentials(String oauth_verifier) {
		AccessToken accessToken = twitter.getOAuthAccessToken(requestToken, oauth_verifier)
		return twitter.verifyCredentials()
	}
	
}