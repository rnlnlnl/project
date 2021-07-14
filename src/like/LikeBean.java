package like;

public class LikeBean {
	private String id;
	private String title;
	private String ip;
	private int like;
	
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
	@Override
	public String toString() {
		return "LikeBean [id=" + id + ", title=" + title + ", ip=" + ip + ", like=" + like + "]";
	}

}
