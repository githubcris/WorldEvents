package worldevents
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
class DateUtil
{
private static final DateFormat utilDateFormatter = new SimpleDateFormat("dd-MM-yyyy");
private static final DateFormat sqlDateFormatter = new SimpleDateFormat("yyyy-MM-dd");

public static java.sql.Date stringToSqlDate(String sDate) throws ParseException
{
	try
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String dateString = sdf.format(new Date().parse("dd/MM/yy", sDate))
		
        return new java.sql.Date(new Date().parse("yyyy-MM-dd", dateString).fastTime)
	}
	catch(Exception ex)
	{
		return null
	}	
}

public static Date stringToDate(String sDate) throws ParseException
{
	try
	{		
		return  new Date().parse("dd/MM/yy", sDate)
	}
	catch(Exception ex)
	{
		return null
	}	
}

public static String stringToday(Date date) throws ParseException
{
	Calendar calendar = Calendar.getInstance(); 	
	SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	String sDate = dateFormat.format(calendar.getTime());
	return sDate;
}

public static String dateToString(java.sql.Date date) throws ParseException
{
	SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	String sDate = dateFormat.format(new Date().parse("yyyy-MM-dd", date.toString()))
	return sDate;
}

public static java.sql.Date today()
{
	return new java.sql.Date(new Date().fastTime)
}

public static java.sql.Date minValue()
{
	return new java.sql.Date(0)
}

public static java.sql.Date maxValue()
{
	return new java.sql.Date(new Date().parse("yyyy-MM-dd", "9999-12-31").fastTime)
}
}


