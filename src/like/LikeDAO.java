package like;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LikeDAO {
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
			System.out.println("LikeDAO : closeAll(자원 반납 에러)"+e);
		}
	}
	
	public int like(String id, String title, String ip){
		
		try {
			conn = getConnection();
			
			sql = "insert into like values(?,?,?)";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, id);
			pst.setString(2, title);
			pst.setString(3, ip);
			
			pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("추천유저 정보에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return -1;
	}
	
	public int like(String title){
		try {
			
			conn = getConnection();
			
			sql = "update like set like = like+1 where title = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, title);
			
			pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("추천하기");
		}finally {
			closeAll(conn, pst, rs);
		}
		return -1;
	}
	
	
	
	
	
	
	
}
