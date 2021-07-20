package itemboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReviewDAO {
	
	Connection conn = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	DataSource ds = null;
	
	String sql;	
	
private Connection getConnection() throws Exception{
		
		Connection conn = null;
		Context init = new InitialContext();
		//커넥션플 얻기
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/power");
		//커넥션플로부터 커넥션 객체 얻기
		conn = ds.getConnection();
		
		return conn;
	}
		
	private void closeAll(Connection conn, PreparedStatement pst, ResultSet rs){
		try {
			if (conn != null) {
				conn.close();
			}
			if (pst != null) {
				pst.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("BoardDAO : closeAll(자원 반납 에러)"+e);
		}
	}
	//댓글 수파악
	public int getReviewCount(){
		int rcnt = 0;
		
		try {
			conn = getConnection();
			
			sql = "select count(num) from review";
			
			pst = conn.prepareStatement(sql);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				rcnt = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("댓글개수 가져오기 실패");
		}finally {
			closeAll(conn, pst, rs);
		}
		return rcnt;
	}
	
	
	
	// 댓글 작성
	public void reInsertBoard(ReviewBean rbean){
		int renum = 0;
		
		try {
			conn = getConnection();
			
			sql = "select max(renum) from review where num = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, rbean.getNum());
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				renum = rs.getInt(1)+1;
			}
			
			sql = "update review set re_seq = re_seq + 1 "
					+"where re_ref=? and re_seq>?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, rbean.getRe_ref());
			pst.setInt(2, rbean.getRe_seq());
			
			pst.executeUpdate();
			
			sql = "insert into review values(?,?,?,?,?,now(),?,?,?)";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, renum);
			pst.setInt(2, rbean.getNum());
			pst.setInt(3, rbean.getRe_ref());
			pst.setInt(4, rbean.getRe_lev());
			pst.setInt(5, rbean.getRe_seq());
			pst.setString(6, rbean.getNickname());
			pst.setString(7, rbean.getTitle());
			pst.setString(8, rbean.getContent());
			
			pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("댓글달기 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
	}
	
	// item게시판에서 번호를 가져와 그번호에있는 글 가져오기
	public ArrayList getReview(int num){
		ArrayList rbean = new ArrayList();
		
		try {
			conn = getConnection();
			
			sql = "select * from review where num = ? order by renum";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, num);
			rs = pst.executeQuery();
			
			if (rs.next()) {
				
				ReviewBean rebean = new ReviewBean();
				
				rebean.setContent(rs.getString("content"));
				rebean.setIp(rs.getString("ip"));
				rebean.setNickname(rs.getString("nickname"));
				rebean.setNum(rs.getInt("num"));
				rebean.setRe_lev(rs.getInt("re_lev"));
				rebean.setRe_ref(rs.getInt("re_ref"));
				rebean.setRe_seq(rs.getInt("re_seq"));
				rebean.setRenum(rs.getInt("renum"));
				rebean.setTitle(rs.getString("title"));
				
				rbean.add(rebean);
			}
			
		} catch (Exception e) {
			System.out.println("댓글 가겨오기 실패");
		}finally {
			closeAll(conn, pst, rs);
		}
		
		return rbean;
	}
	
	
	
}
