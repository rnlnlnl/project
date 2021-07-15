package item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ItemDAO {
	
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
	// 글 개수 확인 
	public int getitemCount(){
		int cnt = 0;
		
		try {
			
			conn = getConnection();
			
			sql = "select count(num) from item";
			
			pst = conn.prepareStatement(sql);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("거래소 계시판 가지고오는데 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return 0;
	}
	
	public ArrayList getItemList(int startRow, int pageSize){
		
		ArrayList itemList = new ArrayList();
		
		try {
			
			conn = getConnection();
			
			sql = "select * from item order by re_ref desc, asc limit ?,?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, startRow);
			pst.setInt(2, pageSize);
			
			rs = pst.executeQuery();
			
			while (rs.next()) {
				ItemBean ibean = new ItemBean();
				ibean.setContent(rs.getString("content"));
				ibean.setGname(rs.getString("gname"));
				ibean.setDate(rs.getDate("date"));
				ibean.setFile(rs.getString("file"));
				ibean.setIp(rs.getString("ip"));
				ibean.setNickname(rs.getString("nickname"));
				ibean.setNum(rs.getInt("num"));
				ibean.setRe_lev(rs.getInt("re_lev"));
				ibean.setRe_ref(rs.getInt("re_ref"));
				ibean.setRe_seq(rs.getInt("re_seq"));
				ibean.setReadcount(rs.getInt("readcount"));
				ibean.setTitle(rs.getString("title"));
				ibean.setLike(rs.getInt("like"));
				ibean.setPrice(rs.getInt("price"));
				
				itemList.add(ibean);
			}
			
		} catch (Exception e) {
			System.out.println("거래 게시판 가지고 오지 못함");
		}finally {
			closeAll(conn, pst, rs);
		}
		
		return itemList;
	}
	
	public void insertItem(ItemBean ibean){
		int num = 0;
		
		try {
			
			conn = getConnection();
			
			sql = "select max(num) from item";
			
			pst = conn.prepareStatement(sql);
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				
				num = rs.getInt(1)+1;
				
				sql = "insert into item (num, gname, nickname, title, content, readcount, re_ref,re_lev,"
						+ "re_seq, date,ip,file,like,price) values(?,?,?,?,?,?,?,?,?,now(),?,?,?,?) ";
				
				pst = conn.prepareStatement(sql);
				
				pst.setInt(1, num);
				pst.setString(2, ibean.getGname());
				pst.setString(3, ibean.getNickname());
				pst.setString(4, ibean.getTitle());
				pst.setString(5, ibean.getContent());
				pst.setInt(6, 0);
				pst.setInt(7, num);
				pst.setInt(8, 0);
				pst.setInt(9, 0);
				pst.setString(10, ibean.getIp());
				pst.setString(11, ibean.getFile());
				pst.setInt(12, 0);
				pst.setInt(13, ibean.getPrice());
				
				pst.executeUpdate();
				
			}
		} catch (Exception e) {
			System.out.println("판매물품 등록에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
	}
	
	public int updateMemberShip(String nickname){
		int memberShip = 0;
		try {
			
			conn = getConnection();
			
			sql = "select sum(price) from item where nickname = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, nickname);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				memberShip = rs.getInt("sum(price)");
			}
			
		} catch (Exception e) {
			System.out.println("멤버쉽 가지고 오는데에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return memberShip;
	}
	
	public ItemBean getBoard(int num){
		ItemBean ibean = null;
		
		try {
			
		} catch (Exception e) {
			System.out.println("게시판 가져오기 실패");
		}finally {
			closeAll(conn, pst, rs);
		}
		return ibean; 
	}
	
	
	
	
	
	
}
