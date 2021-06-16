package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
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
			if(pst != null){
				pst.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("MemberDAO : closeAll(자원 반납 작업)에서 에러" + e);
		}
		
	}
	
	public int userCheck(String id, String pw){
		
		int check = 1;	// 1->아이디 , 비밀번호 DB에 존재
						// 0->아이디 맞음 , 비밀번호 틀림
						// -1->아이디 틀림 
		try {
			//커넥션플로 부터 커넥션얻기(DB접속)
			conn = getConnection();
			//SELECT 문장 만들기 id에 해당하는 레코드 검색
			sql = "select * from member where id = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, id);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				if (pw.equals(rs.getString("pw"))) {
					check = 1; // 로그인
				}else{
					check = 0; // 비번 틀림
				}
			}else{
				check = -1; // 둘다틀림
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeAll(conn, pst, rs);
		}
		return check;
	}
	
	public String nickname(String id, String pw){
		
		String nickname = "";
		
		try {
			//커넥션플로 부터 커넥션얻기(DB접속)
			conn = getConnection();
			//SELECT 문장 만들기 id에 해당하는 레코드 검색
			sql = "select * from member where id = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, id);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				if (pw.equals(rs.getString("pw"))) {
					nickname = rs.getString("nickname"); // 로그인
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeAll(conn, pst, rs);
		}
		
		return nickname;
	}
	
	public String memberInsert(){
		
		try {
			
			conn = getConnection();
			
			sql = "insert into member values(?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, "id");
			pst.setString(2, "pw");
			pst.setString(3, "name");
			pst.setString(4, "nickname");
			pst.setString(5, "");
			pst.setString(6, "");
			pst.setString(7, "");
			pst.setString(8, "");
			pst.setString(9, "");
			pst.setString(10, "");
			pst.setString(11, "");
			pst.setString(12, "");
			
		} catch (Exception e) {
			
		}finally {
			closeAll(conn, pst, rs);
		}
		
		
		
		
		
		return null;
	}
	
	

}
