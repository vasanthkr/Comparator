import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class Shuffling {
	public ArrayList<Integer> getList(){
		 ArrayList<Integer> list = new ArrayList<Integer>();
		 for(int i= 1; i<9; i++)
			 for(int j=0; j<i; j++)
				list.add(i);
		 boolean clean = false;
		 while(!clean){
			 Collections.shuffle(list);
			 clean = clear(list);
			 if(clean) 
				 System.out.println(list.toString());
		 }
		 return list;
	}
	
	public static boolean clear(ArrayList<Integer> list){
		boolean result = true;
		for(int i=0; i<35; i++){
			 if(list.get(i).equals(list.get(i+1))){
				 if(list.get(0)!=list.get(i)){
					 list.add(i+1, list.get(0));
					 list.remove(0);
				 }
				 else if(list.get(35)!=list.get(i)){
					 list.add(i+1, list.get(35));
					 list.remove(36);
				 }
				 else 
					 result = false;
			 }
		}
		return result;
	}
}