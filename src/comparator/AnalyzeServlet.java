package comparator;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
public class AnalyzeServlet extends HttpServlet {
	private static Logger logger = Logger.getLogger(AnalyzeServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		String command = req.getParameter("c");
		DAO dao = new DAO();
		
		if(command.equals("t")){ //time 
			String out = "uid, s, x, l, b\n";
			for(int uid = 101; uid<119; uid++){
				out += uid + ", ";
				User u = dao.ofy().find(User.class, uid);
				List<String> practice = new ArrayList<String>(); 
				for(String str:u.getSequence()){
					if(str.endsWith("p=t"))
						break;
					practice.add(str);
				}
				Collection<Rating> ratings = dao.ofy().get(Rating.class, u.getRatings()).values();
				List<Long> sTimes = new ArrayList<Long>();
				for(Rating r:ratings){
					String str = "u="+"&m="+r.getMovieId()+"&p=s";
					if(!practice.contains(str))
						sTimes.add(r.getEndDate()-r.getStartDate());
				}
				long sTime = 0;
				for (Long l:sTimes) sTime+=l;
				sTime = sTime/sTimes.size();
				out += sTime + ", ";
				
				Collection<Rating> xratings = dao.ofy().get(Rating.class, u.getRatingsX()).values();
				List<Long> xTimes = new ArrayList<Long>();
				for(Rating r:xratings){
					String str = "u="+"&m="+r.getMovieId()+"&p=s";
					if(!practice.contains(str))
						xTimes.add(r.getEndDate()-r.getStartDate());
				}
				long xTime = 0;
				for (Long l:xTimes) xTime+=l;
				xTime = xTime/xTimes.size();
				out += xTime + ", ";
				
				Collection<Rating> lratings = dao.ofy().get(Rating.class, u.getSortedList()).values();
				List<Long> lTimes = new ArrayList<Long>();
				for(Rating r:lratings){
					String str = "u="+"&m="+r.getMovieId()+"&p=s";
					if(!practice.contains(str))
						lTimes.add(r.getEndDate()-r.getStartDate());
				}
				long lTime = 0;
				for (Long l:lTimes) lTime+=l;
				lTime = lTime/lTimes.size();
				out += lTime + ", ";
				
				Collection<Rating> bratings = dao.ofy().get(Rating.class, u.getBinaryList()).values();
				List<Long> bTimes = new ArrayList<Long>();
				for(Rating r:bratings){
					String str = "u="+"&m="+r.getMovieId()+"&p=s";
					if(!practice.contains(str))
						bTimes.add(r.getEndDate()-r.getStartDate());
				}
				long bTime = 0;
				for (Long l:bTimes) bTime+=l;
				bTime = bTime/bTimes.size();
				out += bTime;
				out+="\n";
			}
			logger.info(out);
		}
//		if(command.equals("u")){ //create users
//			ObjectMapper mapper = new ObjectMapper();
//			try {
//				List<User> users = mapper.readValue(new File("users.txt"), new TypeReference<List<User>>(){});
//				for(User u:users){
//					logger.info(u.getId()+" "+u.getName());
//				}
//				dao.ofy().put(users);			
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} 
//		} 
//		
//		else if(command.equals("s")){ //create session sequences 
//			for(int i = 101; i<117; i++){
//				User u = dao.ofy().find(User.class, i);
//				createSessions(u);
//				dao.ofy().put(u);
//			}
//		}
//		else if(command.equals("m")){ //assign movies 
////			for(int i = 101; i<117; i++){
////				User u = dao.ofy().find(User.class, i);
//				setMap();
////				dao.ofy().put(u);
////			}
//		}
//		else if(command.equals("v")){ //clean 
//				User u = dao.ofy().find(User.class, 112);
//				u.getBinaryList().remove(2);
//				dao.ofy().put(u);
//				u = dao.ofy().find(User.class, 104);
//				u.getRatingsX().remove(2);
//				dao.ofy().put(u);
//				}
   
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws IOException {
		doGet(request, response);
	}
	
	
	
	
	
	
	public void createSessions(User u){
		// for the tasks (interface+movie assignment)
		int[] movies = new int[80];
		int[] interfaces = new int[80];
		String[] prototypes = {"s", "x", "l", "b"};
		// Create initial tasks
		int counter = 0;
		for(int i = 0; i < 80; i++) {
			int offset = (int) Math.floor(i / 20.0);
			movies[counter] = i % 20;
			interfaces[counter] = (i + offset) % 4;
			counter++;	
		}

		// Randomize
		for(int j = 0; j < 80; j+=4) {
			// Shuffle from j to j+3

			// Create copy of arrays
			int[] tempMovies     = new int[4];
			int[] tempInterfaces = new int[4];

			
			for(int i =0; i < 4; i++) {
				tempMovies[i] = movies[j + i];
				tempInterfaces[i] = interfaces[j + i];
			}

			// Randomly swap 15 times
			for(int i = 0; i < 15; i++)	{
				int index1 = (int) Math.floor(Math.random()*4 ); // random number between 0-3
				int index2 = (int) Math.floor(Math.random()*4 );
				int tempMovie = tempMovies[index1];
				int tempInterface = tempInterfaces[index1];
				tempMovies[index1] = tempMovies[index2];
				tempInterfaces[index1] = tempInterfaces[index2];
				tempMovies[index2] = tempMovie;
				tempInterfaces[index2] = tempInterface;
			}

			// Put randomized group of 4 back into array
			for(int i = 0; i < 4; i++) {
				movies[j + i] = tempMovies[i];
				interfaces[j +i] = tempInterfaces[i];
			}	
		}

			List<String[]> day0sessions = new ArrayList<String[]>();
			List<String[]> day1sessions = new ArrayList<String[]>();
			List<String[]> day2sessions = new ArrayList<String[]>();
			List<String[]> day3sessions = new ArrayList<String[]>();
			List<String[]> today;
			for(int i=0; i<5; i++){
				day0sessions.add(new String[4]);
				day1sessions.add(new String[4]);
				day2sessions.add(new String[4]);
				day3sessions.add(new String[4]);
			}
			
//			for(int i = 0; i<80; i++){
//				if(i%20==0)
//					System.out.println("\n\n NEXTDAY\n\n");
//				System.out.println("u="+u.getId()+"&m="+u.getMovies().get(movies[i])+"&p="+prototypes[interfaces[i]]);
//			}
			
			for(int i = 0; i<80; i++){
				if(i<20)
					today = day0sessions;
				else if (i<40)
					today = day1sessions;
				else if (i<60)
					today = day2sessions;
				else
					today = day3sessions;
				today.get((i%20)/4)[i%4] = "u="+u.getId()+"&m="+u.getMovies().get(movies[i])+"&p="+prototypes[interfaces[i]];
			}
//			System.out.println("\n\n _________________________________________\n\n");
			Collections.shuffle(day0sessions);
			Collections.shuffle(day1sessions);
			Collections.shuffle(day2sessions);
			Collections.shuffle(day3sessions);
			for(int i=0; i<4; i++){
				if(i==0)
					today = day0sessions;
				else if (i==1)
					today = day1sessions;
				else if (i==2)
					today = day2sessions;
				else
					today = day3sessions;
				for(int j=0; j<5; j++){
					int met1=-1;
					for(int k=0; k<4; k++){
						if(today.get(j)[k].contains("p=x"))
							met1=k;
						if(today.get(j)[k].contains("p=s") && met1>-1){
							String tmp = today.get(j)[k];
							today.get(j)[k] = today.get(j)[met1];
							today.get(j)[met1]=tmp;
						}
					}
				}
			}
			u.getSequence().add("u="+u.getId()+"&m=0&p="+"c");
			int x=400;
			for(int i=0; i<4; i++){
				if(i!=0)
					u.getSequence().add("NextDay");
				
				if(i==0)
					today = day0sessions;
				else if (i==1)
					today = day1sessions;
				else if (i==2)
					today = day2sessions;
				else
					today = day3sessions;
				for(int j=0; j<5; j++){
//					String str = today.get(j)[0];
//					int index = str.indexOf("p=");
					if(j!=0){
						x++;
						u.getSequence().add("u="+u.getId()+"&m="+x+"&p=d");
					}
//					System.out.println("\n NEXT Session\n");
					for(int k=0; k<4; k++){	
//						System.out.println(today.get(j)[k]);
						u.getSequence().add(today.get(j)[k]);
					}
				}
				u.getSequence().add("u="+u.getId()+"&m="+i+"&p="+"t");
			}
			
	}
	
	
	
	
	
	
	
/*	public static void main(String[] str){
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
	*/
	
	public void setMap(){
		List<int[]> list = new ArrayList<int[]>();	
	
		int[] a101={58, 95, 34, 149, 14, 116, 89, 81, 70, 91, 138, 83, 32, 97, 86, 53, 144, 55, 120, 9};
		int[] a102={129, 101, 100, 113, 8, 73, 61, 131, 5, 146, 13, 96, 39, 58, 94, 78, 46, 84, 133, 90};
		int[] a103={27, 43, 79, 75, 141, 10, 127, 65, 64, 143, 71, 31, 148, 21, 120, 150, 67, 95, 139, 147};
		int[] a104={115, 15, 103, 92, 135, 154, 6, 57, 124, 12, 7, 23, 30, 44, 53, 69, 125, 93, 85, 153};
		int[] a105={56, 1, 109, 29, 44, 38, 50, 45, 49, 47, 8, 121, 51, 108, 37, 4, 66, 58, 136, 112};
		int[] a106={106, 104, 46, 48, 88, 30, 42, 17, 7, 8, 58, 56, 80, 22, 139, 145, 12, 4, 117, 18};
		int[] a107={35, 85, 137, 53, 139, 25, 62, 95, 58, 141, 88, 124, 142, 107, 122, 63, 140, 148, 77, 20};
		int[] a108={11, 123, 68, 119, 82, 46, 28, 107, 126, 19, 36, 118, 114, 24, 16, 65, 41, 99, 125, 87};
		int[] a109={116, 132, 128, 130, 129, 151, 52, 96, 60, 72, 86, 54, 76, 3, 98, 8, 155, 156, 32, 152};
		int[] a110={12, 40, 74, 105, 2, 59, 87, 134, 139, 157, 110, 14, 33, 34, 26, 43, 80, 111, 102, 124};
		int[] a111={4, 2158, 2159, 116, 2160, 2161, 2162, 79, 2163, 2164, 151, 2165, 2166, 2167, 2168, 2169, 2170, 2171, 2172, 2173};
		int[] a112={12, 2174, 2175, 107, 2176, 58, 8, 25, 2177, 2178, 2179, 95, 2180, 2181, 87, 2182, 70, 34, 138, 2183};
		int[] a113={2184, 2185, 2186, 2187, 2188, 2189, 2190, 2191, 2192, 2193, 71, 2194, 2195, 2196, 2197, 2198, 2199, 58, 2200, 142};
		int[] a114={2201, 40, 70, 2202, 3, 2203, 2204, 128, 130, 129, 50, 45, 49, 47, 46, 48, 2205, 101, 2206, 2207};
		int[] a115={3208, 12, 3209, 8, 58, 3210, 46, 48, 3211, 3212, 3213, 3214, 124, 129, 3215, 148, 3216, 3217, 3218, 3219};
		int[] a116={3220, 142, 58, 143, 2170, 62, 3221, 8, 25, 3222, 65, 139, 141, 3223, 3224, 53, 95, 3225, 145, 29};
		list.add(a101);
		list.add(a102);
		list.add(a103);
		list.add(a104);
		list.add(a105);
		list.add(a106);
		list.add(a107);
		list.add(a108);
		list.add(a109);
		list.add(a110);
		list.add(a111);
		list.add(a112);
		list.add(a113);
		list.add(a114);
		list.add(a115);
		list.add(a116);
		DAO dao = new DAO();
		for(int i = 101; i<117; i++){
			User u = dao.ofy().find(User.class, i);
			for(int j=0; j<20; j++)
				u.getMovies().add(Long.valueOf(list.get(i-101)[j]));
			dao.ofy().put(u);
		}
	}
	
}
