package comparator;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.Date;
import java.util.logging.Logger;

import javax.servlet.http.*;

import org.codehaus.jackson.map.ObjectMapper;

@SuppressWarnings("serial")
public class ExpressServlet extends HttpServlet {
	private static Logger logger = Logger.getLogger(ExpressServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
			String jsonRating = req.getParameter("jr");
			ObjectMapper mapper = new ObjectMapper();
			Rating rating = mapper.readValue(jsonRating, Rating.class);
			logger.info(rating.getMovieName()+rating.getValue()+rating.getType()+rating.getUserId()+rating.getLog());
			
	        DAO dao = new DAO();
	        dao.ofy().put(rating);
			User user = dao.ofy().find(User.class, rating.getUserId());
			if(rating.getType().startsWith("list")){
				Collection<Rating> ratings = dao.ofy().get(Rating.class, user.getSortedList()).values();
				for (Rating r:ratings){
					if(r.getMovieId()==rating.getMovieId())
						user.getSortedList().remove(Long.valueOf(r.getId()));
				}
				user.getSortedList().add(rating.getValue(), rating.getId());
			}
			else if(rating.getType().startsWith("bin")){
				Collection<Rating> ratings = dao.ofy().get(Rating.class, user.getBinaryList()).values();
				for (Rating r:ratings){
					if(r.getMovieId()==rating.getMovieId())
						user.getBinaryList().remove(Long.valueOf(r.getId()));
				}
				if(rating.getValue()>user.getBinaryList().size())
					user.getBinaryList().add(rating.getId());
				else
					user.getBinaryList().add(rating.getValue(), rating.getId());
			}
			else if(rating.getType().startsWith("xstars")){
				Collection<Rating> ratings = dao.ofy().get(Rating.class, user.getRatingsX()).values();
				for (Rating r:ratings){
					if(r.getMovieId()==rating.getMovieId())
						user.getRatingsX().remove(Long.valueOf(r.getId()));
				}
				user.getRatingsX().add(rating.getId());
			}
			else if(rating.getType().startsWith("stars")){
				Collection<Rating> ratings = dao.ofy().get(Rating.class, user.getRatings()).values();
				for (Rating r:ratings){
					if(r.getMovieId()==rating.getMovieId())
						user.getRatings().remove(Long.valueOf(r.getId()));
				}
				user.getRatings().add(rating.getId());
			}
			else if(rating.getType().startsWith("dist"))
				user.getDists().add(rating.getId());
			dao.ofy().put(user);	
	        
	        resp.setContentType("text/html");
	        PrintWriter out = resp.getWriter();      
			out.print(rating.getId()+":"+new Date().getTime());
			out.flush();    
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws IOException {
		doGet(request, response);
	}
}
