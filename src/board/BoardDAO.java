package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	Connection conn = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	DataSource ds = null;
	
	String sql;	
	
	private Connection getConnection() throws Exception{
		
		Connection conn = null;
		Context init = new InitialContext();
		
		DataSource ds = (DataSource)init.lookup("java:comp/evn/jdbc/power");
		
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
	
	// 글 개수 확인 
	public int getBoardCount(){
		
		int cnt = 0;
		
		try {
			
			conn = getConnection();
			
			sql = "select count(num) from board";
			
			pst = conn.prepareStatement(sql);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("글 개수 확인 에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return cnt;
	}
	
	// 모든 글 가져오기
	public ArrayList getBoardList(int startRow, int pageSize){
		
		ArrayList boardList = new ArrayList();
		
		try {
			
			conn = getConnection();
			
			sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			
			pst = conn.prepareStatement(sql);
			pst.setInt(1, startRow-1);
			pst.setInt(2, pageSize);
			
			rs = pst.executeQuery();
			
			while (rs.next()) {
				BoardBean bbean = new BoardBean();
				bbean.setContent(rs.getString("content"));
				bbean.setDate(rs.getDate("date"));
				bbean.setFile(rs.getString("file"));
				bbean.setIp(rs.getString("ip"));
				bbean.setNickname(rs.getString("nickname"));
				bbean.setNum(rs.getInt("num"));
				bbean.setPw(rs.getString("pw"));
				bbean.setRe_lev(rs.getInt("re_lev"));
				bbean.setRe_ref(rs.getInt("re_ref"));
				bbean.setRe_seq(rs.getInt("re_seq"));
				bbean.setReadcount(rs.getInt("readcount"));
				bbean.setTitle(rs.getString("title"));
				
				boardList.add(bbean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("글 가져오기 실패"+e);
		}finally {
			closeAll(conn, pst, rs);
		}
		return boardList;
	}
	
	// 조회수 카운트
	public void updateReadcount(int num){
		
		try {
			conn = getConnection();
			
			sql = "update board set readcount = readcount+1 where num = ?";
			
			pst = conn.prepareStatement(sql);
			pst.setInt(1, num);
			pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("조회수에서 오류"+e);
		}finally {
			closeAll(conn, pst, rs);
		}
	}
	
	// 선택한 계시판 보여주기
	public BoardBean getBoard(int num){
		BoardBean bbean = null;
		try {
			
			conn = getConnection();
			
			sql = "select * from board where num = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, num);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				bbean.setContent(rs.getString("content"));
				bbean.setDate(rs.getDate("date"));
				bbean.setFile(rs.getString("file"));
				bbean.setIp(rs.getString("ip"));
				bbean.setNickname(rs.getString("nickname"));
				bbean.setNum(rs.getInt("num"));
				bbean.setPw(rs.getString("pw"));
				bbean.setRe_lev(rs.getInt("re_lev"));
				bbean.setRe_ref(rs.getInt("re_ref"));
				bbean.setRe_seq(rs.getInt("re_seq"));
				bbean.setReadcount(rs.getInt("readcount"));
				bbean.setTitle(rs.getString("title"));

			}
		} catch (Exception e) {
			System.out.println("계시판 num가져오기 실패");
		}finally {
			closeAll(conn, pst, rs);
		}
		return bbean;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
