package comparator;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.helper.DAOBase;

public class DAO extends DAOBase
{
	//static public ObjectifyService o= new ObjectifyService();
    static {
    	ObjectifyService.register(User.class);
    	ObjectifyService.register(Rating.class);
        ObjectifyService.register(Movie.class);
    }
    
}
