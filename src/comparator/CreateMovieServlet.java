package comparator;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.*;

import org.apache.tools.ant.Main;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import com.google.appengine.repackaged.org.json.JSONArray;
import com.googlecode.objectify.Key;

@SuppressWarnings("serial")
public class CreateMovieServlet extends HttpServlet {
	private static Logger logger = Logger.getLogger(CreateMovieServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
//		int id= 0;
//		DAO dao =  new DAO();
//		for(int i=101; i<118; i++){
//			User u = dao.ofy().get(User.class, i);
////			logger.info(u.getName());
//			//String out=u.getName()+":";
//			for(int j=0; j<u.getSequence().size(); j++){
//				String str = u.getSequence().get(j);
//				if(str.endsWith("p=d")){
////					System.out.println("after:"+u.getSequence().get(j));
//					id++;
//					u.getSequence().remove(j);
//					String sub = str.substring(str.indexOf("&m="), str.indexOf("&p=")); 
//					str = str.replace(sub, "&m="+id);
//					u.getSequence().add(j, str);
////					System.out.println("after:"+u.getSequence().get(j));
//				}
//			}
//			dao.ofy().put(u);
//		}
		ObjectMapper mapper = new ObjectMapper();
		try {
			List<Movie> movies = mapper.readValue(new File("movies.txt"), new TypeReference<List<Movie>>(){});
			logger.info("Size: "+movies.size());
			for(Movie m:movies){
				logger.info(m.getId()+" "+m.getName());
			}
			DAO dao = new DAO();
			dao.ofy().put(movies);
			int[] a={12, 7012, 52, 80, 87, 7011, 7013, 111, 2163, 124, 134, 139, 142, 3216, 148, 7014, 7015, 7, 51, 3217};
			User u = new User();
			u.setName("Alison");
			u.setId(118);
			for(int j=0; j<20; j++)
				u.getMovies().add(Long.valueOf(a[j]));
			
			
			CreateServlet c = new CreateServlet();
			c.createSessions(u);
			String out=u.getName()+":";
			for(String str:u.getSequence())
				out = out + str+" , ";
			logger.info(out);
			dao.ofy().put(u);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
  
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws IOException {
		doGet(request, response);
	}
	public static void main(String[] str){
		ObjectMapper mapper = new ObjectMapper();
		try {
			List<User> users = mapper.readValue(new File("users.txt"), new TypeReference<List<User>>(){});
			for(User u:users){
				System.out.println(u.getId()+" "+u.getName());
			}
			List<Movie> movies = mapper.readValue(new File("movies.txt"), new TypeReference<List<User>>(){});
			for(Movie m:movies){
				System.out.println(m.getId()+" "+m.getName());
			}
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
