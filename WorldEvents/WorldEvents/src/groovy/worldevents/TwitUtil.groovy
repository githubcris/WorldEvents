package worldevents
import java.util.List;
import org.codehaus.groovy.tools.shell.util.MessageSource
import org.springframework.context.i18n.LocaleContextHolder
import twitter4j.IDs
import twitter4j.Twitter
import twitter4j.TwitterException
import twitter4j.TwitterFactory


 class TwitUtil {
	
	public static List<Long> getFriends(Twitter twitter, long userid, long friendsCount)
	{
	
	try {
				
		List<Long> friendsList = new List<Long>[friendsCount+1]
		
		long cursor = -1
		
		IDs ids = twitter.getFriendsIDs(userid, cursor)
		
		for (long id : ids.getIDs()) {
			friendsList.addAll(id)
		}
		
		while ((cursor = ids.getNextCursor()) != 0) {
			
			ids = twitter.getFriendsIDs(cursor);
			
			for (long id : ids.getIDs()) {
				friendsList.addAll(id)
			}
		}

		friendsList.addAll(userid)
		return friendsList
	}
	catch (Exception te) {
		te.printStackTrace();
		System.out.println("Failed to get friends' ids: " + te.getMessage());
		System.exit(-1);
	}
	}
	
	
	public static void sendTwit(Twitter twitter, String message)
	{
		try
		{
			twitter.updateStatus(message)
		}
		catch(Exception ex)
		{

		}
	}
}
