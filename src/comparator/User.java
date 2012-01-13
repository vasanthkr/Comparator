package comparator;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Id;
import com.googlecode.objectify.Key;
public class User {
	 @Id
	 private long id;
	 private String name;
	 private List<Long> dists = new ArrayList<Long>();
	 private List<Long> ratings = new ArrayList<Long>();
	 private List<Long> movies = new ArrayList<Long>();
	 private List<Long> ratingsX = new ArrayList<Long>();
	 private List<Long> sortedList = new ArrayList<Long>();
	 private List<Long> binaryList = new ArrayList<Long>();
	 private List<String> sequence = new ArrayList<String>();

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setRatings(List<Long> ratings) {
		this.ratings = ratings;
	}

	public List<Long> getRatings() {
		return ratings;
	}

	public void setRatingsX(List<Long> ratingsX) {
		this.ratingsX = ratingsX;
	}

	public List<Long> getRatingsX() {
		return ratingsX;
	}

	public void setSortedList(List<Long> sortedList) {
		this.sortedList = sortedList;
	}

	public List<Long> getSortedList() {
		return sortedList;
	}

	public void setBinaryList(List<Long> binaryList) {
		this.binaryList = binaryList;
	}

	public List<Long> getBinaryList() {
		return binaryList;
	}

	public void setSequence(List<String> sequence) {
		this.sequence = sequence;
	}

	public List<String> getSequence() {
		return sequence;
	}

	public void setMovies(List<Long> movies) {
		this.movies = movies;
	}

	public List<Long> getMovies() {
		return movies;
	}

	public void setDists(List<Long> dists) {
		this.dists = dists;
	}

	public List<Long> getDists() {
		return dists;
	}

	
	 
}

