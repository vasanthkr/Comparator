package comparator;

import javax.persistence.Id;

public class Movie {
	 @Id
	 private long id;
	 private String name;
	 private int year;

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
	public void setYear(int year) {
		this.year = year;
	}
	public int getYear() {
		return year;
	}
	 
}
