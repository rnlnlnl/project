package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.fabric.Response;

import board.BoardBean;

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
	
	// 아이디와 비밀번호가 DB에있을때 로그인
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
	// 로그인 했을때 nickname 리턴 해서 로그인 유지
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
	// 회원가입
	public void memberInsert(MemberBean mbeen){
	
		try {
			
			conn = getConnection();
			
			sql = "insert into member values(?,?,?,?,?,?,?,?,?,?,?,now())";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, mbeen.getId());
			pst.setString(2, mbeen.getPw());
			pst.setString(3, mbeen.getName());
			pst.setString(4, mbeen.getNickname());
			pst.setInt(5, mbeen.getAge());
			pst.setString(6, mbeen.getGender());
			pst.setString(7, mbeen.getEmail());
			pst.setString(8, mbeen.getAddr1());
			pst.setString(9, mbeen.getAddr2());
			pst.setString(10, mbeen.getAddr3());
			pst.setString(11, mbeen.getTel());
			
			pst.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("회원가입 에러!"+e);
			
		}finally {
			closeAll(conn, pst, rs);
		}
	}
	
	//아이디 중복 검사
	public int idCheck(String id){
		int check = 1;
		try {
			conn = getConnection();
			
			sql = "select id from member where id = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, id);
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				check = 1;
			}else{
				check = 0;
			}
			
		} catch (Exception e) {
			System.out.println("아이디 중복검사에서 오류");
		}
		
		return check;
	}
	
	//nickname중복 검사
	public int nickCheck(String nickname){
		int check = 1;
		try {
			conn = getConnection();
			
			sql = "select nickname from member where nickname = ?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickname);
			rs = pst.executeQuery();
			
			if(rs.next()){
				check = 1;
			}else{
				check = 0;
			}
			
		} catch (Exception e) {
			System.out.println("nickname중복검사 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return check;
	}
	
	//이메일 중복검사
	public int emailCheck(String email){
		int echeck = 1;
		try {
			conn = getConnection();
			sql = "select email from member where email = ?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, email);
			rs = pst.executeQuery();
			
			if(rs.next()){
				echeck = 1;
			}else{
				echeck = 0;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeAll(conn, pst, rs);
		}
		return echeck;
	}
	
	// 전화번호 중복 검사
	public int telCheck(String tel){
		int tcheck = 1;
		try {
			
			conn = getConnection();
			sql = "select tel from member where tel = ?";
			
			pst = conn.prepareStatement(sql);
			pst.setString(1, tel);
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				tcheck = 1;
			}else{
				tcheck = 0;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("전화번호 중복 검사 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return tcheck;
	}
	
	
	// 내정보 가지고 오기
	public ArrayList getMyPage(String id){
		
		ArrayList list = new ArrayList();
		
		try {
			
			conn = getConnection();
			
			sql = "select * from member where id = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, id);
			
			rs = pst.executeQuery();
			
			while (rs.next()) {
				MemberBean beanList = new MemberBean();
				
				beanList.setId(rs.getString("id"));
				beanList.setName(rs.getString("name"));
				beanList.setNickname(rs.getString("nickname"));
				beanList.setAge(rs.getInt("age"));
				beanList.setEmail(rs.getString("email"));
				beanList.setAddr1(rs.getString("add1"));
				beanList.setAddr2(rs.getString("add2"));
				beanList.setAddr3(rs.getString("add3"));
				beanList.setTel(rs.getString("tel"));
				
				list.add(beanList);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("내정보변경에서 오류.");
		}finally{
			closeAll(conn, pst, rs);
		}

		return list;
	}
	
	// 내정보 바꾸기
	public void myPageUpdate(MemberBean mbean){
		System.out.println(mbean.getId());
		try {
			
			conn = getConnection();
			
			sql = "select id, pw, name, nickname, age, email , add1 , add2, add3, tel from member where id =?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, mbean.getId());
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				
				sql = "update member set nickname = ?, pass = ?, age = ?, add1 = ?, add2=?, add3=?, tel=? where id = ?";
				
				pst = conn.prepareStatement(sql);
				
				pst.setString(1, mbean.getNickname());
				pst.setString(2, mbean.getPw());
				pst.setInt(3, mbean.getAge());
				pst.setString(4, mbean.getAddr1());
				pst.setString(5, mbean.getAddr2());
				pst.setString(6, mbean.getAddr3());
				pst.setString(7, mbean.getTel());
				pst.setString(8, mbean.getId());
				
				pst.executeUpdate();
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("내정보변경에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}

	}
	
	// 랜덤 비밀번호 생성
	public String creatPw(){
		String randomPw = UUID.randomUUID().toString().replaceAll("-", "");
		randomPw = randomPw.substring(0, 8);
		
		return randomPw;
	}
	
	// 이메일 이용한 비밀번호 찾기
	public String findPw(String id, String email){
		 String randomPw = creatPw();
		try {
			
			conn = getConnection();
			
			sql = "select pw from member where id = ? and email = ?";
			
			pst = conn.prepareStatement(sql);
			

			pst.setString(1, id);
			pst.setString(2, email);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {
				
				sql = "update member set pw = ? where id = ? and email = ?";
				
				pst = conn.prepareStatement(sql);
				
				pst.setString(1, randomPw);
				pst.setString(2, id);
				pst.setString(3, email);
				
				pst.executeUpdate();
			}
		} catch (Exception e) {
			System.out.println("비밀번호 찾기에서 오류"+e);
		}finally {
			closeAll(conn, pst, rs);
		}
		return randomPw;
	}
	
	// 이메일을 이용한 아이디 찾기
	public String findId(String email){
		String id ="";
		
		try {
			conn = getConnection();
			
			sql = "select id from member where email = ?";
			
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, email);
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				id = rs.getString("id");
			}else{
				id = "";
			}
			
		} catch (Exception e) {
			System.out.println("아이디 찾기에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return id;
	}
	
	//회원탈퇴
	public int deleteMember(String nickname, String pw){
		int check = 0;
		try {
			conn = getConnection();
			sql = "select pw from member where nickname = ?";
			
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickname);
			
			rs = pst.executeQuery();
			
			if(rs.next()){
				if (pw.equals(rs.getString("pw"))) {
					sql = "delete from member where nickname = ?";
					
					pst = conn.prepareStatement(sql);
					pst.setString(1, nickname);
					
					pst.executeUpdate();
					
					check = 1;
				}else{
					check = 0;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원탈퇴에서 오류");
		}finally {
			closeAll(conn, pst, rs);
		}
		return check;
	}
}
