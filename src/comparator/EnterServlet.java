package comparator;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.googlecode.objectify.Key;



@SuppressWarnings("serial")
public class EnterServlet extends HttpServlet {
	private static Logger logger = Logger.getLogger(EnterServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws IOException {
		String nextJSP = "";
		DAO dao = new DAO();
		String prototype = req.getParameter("p");
		User user = dao.ofy().find(User.class, Long.valueOf(req.getParameter("u")));
		Movie movie = null;
		Long mid = Long.valueOf(req.getParameter("m"));
		if (mid!=0)
			movie = dao.ofy().find(Movie.class, mid);
		
		Rating newRating = new Rating();
		newRating.setMovieId(mid);
		newRating.setMovieName("A Movie");
		if(movie!= null){
			newRating.setMovieName(movie.getName());
		}
		newRating.setUserId(user.getId());
		req.setAttribute("newrating", newRating);
		String next = "u=9&p=l&m=39";
		int state= user.getSequence().indexOf("u="+user.getId()+"&m="+mid+"&p="+prototype);
		logger.info("Step:"+state+" u="+user.getId()+"&p="+prototype+"&m="+mid);
		if(state>-1 && !prototype.equals("t")){
			next = user.getSequence().get(state+1);
			req.setAttribute("nexturl", "Enter?"+next);
		}
		
		if(prototype.equals("s")){ //stars
			nextJSP = "/stars.jsp";
		} 
		else if(prototype.equals("x")){ //stars+examples
			List<Rating> ratings = new ArrayList<Rating>();
			
			for(int i=0; i<10; i++){
				Rating empty = new Rating();
				empty.setValue(i+1);
				empty.setMovieName("--");
				ratings.add(empty);
			}
			for(long id : user.getRatingsX()){
				Rating r = dao.ofy().find(Rating.class, id);
				ratings.remove(r.getValue()-1);
				ratings.add(r.getValue()-1, r);
			}
			req.setAttribute("ratings", ratings);
			nextJSP = "/xstars.jsp";
		}
		else if(prototype.equals("l")){ //sorted list
			List<Rating> ratings = new ArrayList<Rating>();
			for(long id : user.getSortedList())
				ratings.add(dao.ofy().find(Rating.class, id));
			req.setAttribute("ratings", ratings);
			nextJSP = "/list.jsp";
			}
		else if(prototype.equals("b")){ //binary search
			List<Rating> ratings = new ArrayList<Rating>();
			for(long id : user.getBinaryList())
				ratings.add(dao.ofy().find(Rating.class, id));
			req.setAttribute("ratings", ratings);	
			nextJSP = "/bin.jsp";
		}
		else if(prototype.equals("t")){ //binary search
			nextJSP = "/index.html";
		}
		else if(prototype.equals("d")){ //distractor
			List<Rating> ratings = new ArrayList<Rating>();
			Rating r;
			Movie m;
			int order[];
			int order1[]= {1, 18, 3, 4, 3, 2, 5, 2, 6, 7, 8, 6, 9, 8, 9, 10, 11, 12, 11, 3, 13, 11, 14, 15, 16, 15, 17, 18, 17, 19, 0};
			int order2[]= {9, 2, 3, 1, 4, 1, 5, 2, 6, 7, 8, 6, 1, 6, 8, 10, 11, 10, 11, 3, 12, 11, 12, 14, 16, 14, 18, 17, 18, 19, 0};
			int order3[]= {2, 7, 9, 4, 3, 4, 5, 2, 5, 9, 8, 6, 7, 8, 7, 11, 10, 12, 10, 3, 15, 16, 14, 15, 16, 13, 16, 13, 0, 19, 0};
			double rand = Math.random();
			order = order1;
			if(rand>0.33)
				order = order2;
			if(rand>0.67)
				order = order3;
			for(int o:order){
				r = new Rating();
				m= dao.ofy().find(Movie.class, user.getMovies().get(o));
				r.setMovieId(m.getId());
				r.setMovieName(m.getName());
				ratings.add(r);
			}
			req.setAttribute("ratings", ratings);	
			nextJSP = "/distract.jsp";
		} else if(prototype.equals("c")){ //consent
			nextJSP = "/consent.jsp";
			logger.info(user.getName()+" signed the consent form.");
//		}else if(prototype.equals("z")){ //seqs
//			logger.info("in Z");
//			for(int i=101; i<119; i++){
//				User u = dao.ofy().get(User.class, i);
//				logger.info(u.getName());
//				String out=u.getName()+":";
//				for(String str:u.getSequence())
//					out = out + str+" , ";
//				logger.info(out);
//			}
//			nextJSP = "/index.html";
		}else if(prototype.equals("z")){ //seqs
//			logger.info("in Z");
//			for(int i=101; i<119; i++){
				User u = user;
				List<Rating> ratings = new ArrayList<Rating>();
				for(long id : u.getSortedList())
					ratings.add(dao.ofy().find(Rating.class, id));
				Collections.reverse(ratings);
				req.setAttribute("list", ratings);
				
				ratings = new ArrayList<Rating>();
				for(long id : u.getBinaryList())
					ratings.add(dao.ofy().find(Rating.class, id));
				Collections.reverse(ratings);
				req.setAttribute("bin", ratings);
				
				ratings = new ArrayList<Rating>();
				for(long id : u.getRatings())
					ratings.add(dao.ofy().find(Rating.class, id));
				Collections.sort(ratings, new Comp());
				Collections.reverse(ratings);
				req.setAttribute("ratings", ratings);
				
				ratings = new ArrayList<Rating>();
				for(long id : u.getRatingsX())
					ratings.add(dao.ofy().find(Rating.class, id));
				Collections.sort(ratings, new Comp());
				Collections.reverse(ratings);
				req.setAttribute("xratings", ratings);
//			}
			nextJSP = "/present.jsp";
		}else if(prototype.equals("a")){ //binary search
			req.setAttribute("D1", dao.ofy().find(Rating.class, user.getSortedList().get(3)));
			req.setAttribute("D2", dao.ofy().find(Rating.class, user.getSortedList().get(4)));
			req.setAttribute("N1", dao.ofy().find(Rating.class, user.getSortedList().get(8)));
			req.setAttribute("N2", dao.ofy().find(Rating.class, user.getSortedList().get(9)));
			req.setAttribute("L1", dao.ofy().find(Rating.class, user.getSortedList().get(15)));
			req.setAttribute("L2", dao.ofy().find(Rating.class, user.getSortedList().get(16)));
			
			ArrayList<Rating> ratings = new ArrayList<Rating>();
			for(long id : user.getRatingsX())
				ratings.add(dao.ofy().find(Rating.class, id));
			Collections.sort(ratings, new Comp());
			req.setAttribute("V1", ratings.get(3).getValue()
			+ ratings.get(4).getValue());
			req.setAttribute("V2", ratings.get(8).getValue()
			+ ratings.get(9).getValue());
			req.setAttribute("V3", ratings.get(15).getValue()
			+ ratings.get(16).getValue());
			
			nextJSP = "/reco.jsp";
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
		try {
			dispatcher.forward(req,resp);
		} catch (ServletException e) {
			
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws IOException {
		doGet(request, response);
	}
}
class Comp implements Comparator<Rating> {
    @Override
    public int compare(Rating o1, Rating o2) {
        return o1.getValue() - o2.getValue();
    }
}


/*			for(int i=0; i<25; i++){
Rating r = new Rating();
r.setMovieName(i+" mov");
r.setValue(i);
r.setType("listL");
ratings.add(r);
}
ratings.get(0).setType("listD");
*/
//logger.warning("value: "+rating.getValue());
//JSONArray array = new JSONArray();
//
//resp.setContentType("text/html");
//String str = mapper.writeValueAsString(rating);
//array.put(str);
//rating.setValue(8);
//str = mapper.writeValueAsString(rating);
//array.put(str);
//rating.setValue(9);
//rating.setM
//str = mapper.writeValueAsString(rating);
//array.put(str);
////logger.warning(str);
//PrintWriter out = resp.getWriter();      
//out.print(array);
//out.flush();    