package like;

public class LikeBean {
	private String id;
	private String title;
	private String ip;
	private int like;
	private String acheck;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getLike() {
		return like;
	}
	public void setLike(int like) {
		this.like = like;
	}
	
	public String getAcheck() {
		return acheck;
	}
	public void setAcheck(String acheck) {
		this.acheck = acheck;
	}
	@Override
	public String toString() {
		return "LikeBean [id=" + id + ", title=" + title + ", ip=" + ip + ", like=" + like + ", acheck=" + acheck + "]";
	}
	

}
