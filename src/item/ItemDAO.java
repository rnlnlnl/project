package item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		return cnt;
	}
	
	public ArrayList getItemList(int startRow, int pageSize){
		
		ArrayList itemList = new ArrayList();
		
		try {
			
			conn = getConnection();
			
			sql = "select * from item order by re_ref desc, re_seq asc limit ?,?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, startRow-1);
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
				ibean.setAcheck(rs.getString("acheck"));
				
				itemList.add(ibean);
			}
			
		} catch (Exception e) {
			System.out.println("거래 게시판 가지고 오지 못함");
		}finally {
			closeAll(conn, pst, rs);
		}
		return itemList;
	}
	
	// 글 작성
	public void insertItem(ItemBean ibean){
		int num = 0;
		
		try {
			
			conn = getConnection();
			
			sql = "select max(num) from item";
			
			pst = conn.prepareStatement(sql);
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				
				num = rs.getInt(1)+1;
				
				sql = "insert into item(num,gname,nickname,title,content,readcount,re_ref,re_lev,"
						+ "re_seq,`date`,ip,`file`,`like`,price) values(?,?,?,?,?,?,?,?,?,now(),?,?,?,?)";
				
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
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버로드 실패");
		}catch (SQLException e) {
			System.out.println("DB연결 실패");
		}catch (Exception e) {
			System.out.println("글작성 실패");
		}finally {
			closeAll(conn, pst, rs);
		}
	}
	
	// 가격을 합쳐서 멤버십 등급 만들기
	public int updateMemberShip(int num){
		int memberShip = 0;
		try {
			
			conn = getConnection();
			
			sql = "select nickname from item where num = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, num);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				
				sql = "select sum(price) from item where nickname = ?";
				
				pst = conn.prepareStatement(sql);
				
				pst.setString(1, rs.getString("nickname"));
				
				rs = pst.executeQuery();
					if(rs.next()){
					memberShip = rs.getInt("sum(price)");
					}
			}
			System.out.println(rs.getInt("sum(price)"));
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
			
			conn = getConnection();
			
			sql = "select * from item where num = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, num);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				ibean = new ItemBean();
				
				ibean.setContent(rs.getString("content"));
				ibean.setDate(rs.getDate("date"));
				ibean.setFile(rs.getString("file"));
				ibean.setGname(rs.getString("gname"));
				ibean.setIp(rs.getString("ip"));
				ibean.setLike(rs.getInt("like"));
				ibean.setNickname(rs.getString("nickname"));
				ibean.setNum(rs.getInt("num"));
				ibean.setPrice(rs.getInt("price"));
				ibean.setRe_lev(rs.getInt("re_lev"));
				ibean.setRe_ref(rs.getInt("re_ref"));
				ibean.setRe_seq(rs.getInt("re_seq"));
				ibean.setReadcount(rs.getInt("readcount"));
				ibean.setTitle(rs.getString("title"));
				ibean.setAcheck(rs.getString("acheck"));
			}
			
			
		} catch (Exception e) {
			System.out.println("게시판 가져오기 실패");
		}finally {
			closeAll(conn, pst, rs);
		}
		return ibean; 
	}
	
	public int iupdateBoard(ItemBean ibean){
		
		int check = 0;
		
		try {
			
			conn = getConnection();
			
			sql = "select nickname from item where num = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, ibean.getNum());
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				
				if (ibean.getNickname().equals(rs.getString("nickname"))) {
					sql = "update item set file = ?, title = ?, gname = ?, price = ?, content = ?, nickname = ? where num = ?";
					
					pst = conn.prepareStatement(sql);
					
					pst.setString(1, ibean.getFile());
					pst.setString(2, ibean.getTitle());
					pst.setString(3, ibean.getGname());
					pst.setInt(4, ibean.getPrice());
					pst.setString(5, ibean.getContent());
					pst.setString(6, ibean.getNickname());
					pst.setInt(7, ibean.getNum());
					
					pst.executeUpdate();
					check = 1;
				}else{
					check = 0;
				}
			}else{
				check = -1;
			}
		} catch (Exception e) {
			System.out.println("아이템 등록 업데이트에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return check;
	}
	
	// 아이템 판매 게시판 삭제
	public int deleteItem(String nickname, int num){
		int check = 0;
		
		try {
			
			conn = getConnection();
			
			sql = "select nickname from item where num = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, num);
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				if (nickname.equals(rs.getString("nickname"))) {
					
					sql = "delete from item where num = ?";
					
					pst = conn.prepareStatement(sql);
					
					pst.setInt(1, num);
					
					pst.executeUpdate();
					check = 1;
				}else{
					check = 0;
				}
			}else{
				check = -1;
			}

		} catch (Exception e) {
			System.out.println("아이템 게시판 삭제에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return check;
	}
	
	public void reInsertBoard(ItemBean ibean){
		int num = 0;
		
		try {
			conn = getConnection();
			
			sql = "select max(num) from item";
			
			pst = conn.prepareStatement(sql);
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			
			sql = "update item set re_seq = re_seq + 1 "
					+"where re_ref=? and re_seq>?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, ibean.getRe_ref());
			pst.setInt(2, ibean.getRe_seq());
			
			pst.executeUpdate();
			
			sql = "insert into item values(?,?,?,?,?,?,?,?,?,now(),?,?,?,?,?)";
			
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, num);
			pst.setString(2, ibean.getGname());
			pst.setString(3, ibean.getNickname());
			pst.setString(4, ibean.getTitle());
			pst.setString(5, ibean.getContent());
			pst.setInt(6, ibean.getReadcount());
			pst.setInt(7, ibean.getRe_ref());
			pst.setInt(8, ibean.getRe_lev());
			pst.setInt(9, ibean.getRe_seq());
			pst.setString(10, ibean.getIp());
			pst.setString(11, ibean.getFile());
			pst.setInt(12, ibean.getLike());
			pst.setInt(13, ibean.getPrice());
			pst.setString(14, ibean.getAcheck());
			
			pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("댓글달기 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
	}
	
	
	public String adminCheck(String acheck, int num){
		String achecked = "";
		
		try {
			
			conn = getConnection();
			
			sql = "update item set acheck = ? where num = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, acheck);
			pst.setInt(2, num);
			
			pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("관리자 체크 에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return achecked;
	}
	
}
