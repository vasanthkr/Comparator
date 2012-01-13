import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class TestShuffling {
	public static void main(String[] strs){
	
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
		
		for(int i = 0; i<80; i++){
			if(i%20==0)
				System.out.println("\n\n NEXTDAY\n\n");
			System.out.println("m="+movies[i]+"&p="+interfaces[i]);
		}
		
		for(int i = 0; i<80; i++){
			if(i<20)
				today = day0sessions;
			else if (i<40)
				today = day1sessions;
			else if (i<60)
				today = day2sessions;
			else
				today = day3sessions;
			today.get((i%20)/4)[i%4] = "m="+movies[i]+"&p="+interfaces[i];
		}
		System.out.println("\n\n _________________________________________\n\n");
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
					if(today.get(j)[k].contains("p=1"))
						met1=k;
					if(today.get(j)[k].contains("p=0") && met1>-1){
						String tmp = today.get(j)[k];
						today.get(j)[k] = today.get(j)[met1];
						today.get(j)[met1]=tmp;
					}
				}
			}
		}

		for(int i=0; i<4; i++){
			System.out.println("\n\n NEXTDAY\n\n");
			if(i==0)
				today = day0sessions;
			else if (i==1)
				today = day1sessions;
			else if (i==2)
				today = day2sessions;
			else
				today = day3sessions;
			for(int j=0; j<5; j++){
				System.out.println("\n NEXT Session\n");
				for(int k=0; k<4; k++)	
					System.out.println(today.get(j)[k]);
				
			}
		}
	
	
	}
}