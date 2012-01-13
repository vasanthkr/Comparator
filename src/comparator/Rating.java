package comparator;

import javax.persistence.Id;
import javax.persistence.Transient;


public class Rating {
	 @Id
	private Long id;
	private int value;
	private String type;//binL binD binN stars xstars listL listD listN
	private long startDate;
	private long endDate;
	private int year;
	private String log;
	private long userId;
	private long movieId;
	@Transient
	private String movieName=" ";



	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getLog() {
		return log;
	}
	public void setLog(String log) {
		this.log = log;
	}
	public void setMovieId(long movieId) {
		this.movieId = movieId;
	}
	public long getMovieId() {
		return movieId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getUserId() {
		return userId;
	}
	public void setId(Long id) {
		if(id!=0)
			this.id = id;
	}
	public Long getId() {
		return id;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getMovieName() {
		DAO dao = new DAO();
		if(movieName.length()<2 && movieId!=0)
			movieName = dao.ofy().find(Movie.class, movieId).getName();
		return movieName;
	}

	public void setYear(int year) {
		this.year = year;
	}
	public int getYear() {
		return year;
	}
	public void setStartDate(long startDate) {
		this.startDate = startDate;
	}
	public long getStartDate() {
		return startDate;
	}
	public void setEndDate(long endDate) {
		this.endDate = endDate;
	}
	public long getEndDate() {
		return endDate;
	}
	
//	@Override
//	public boolean equals(Object o){
//		if(((Rating)o).id==id)
//			return true;
//		return false;
//	}
	
}
