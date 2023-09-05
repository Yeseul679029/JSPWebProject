package membership;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

//쿼리문 실행하기 위한 용도
public class MemberShipDAO extends JDBConnect {
	
	//기본생성자
	public MemberShipDAO() {
	}
	
	//매개변수가 4개인 부모의 생성자를 호출하여 DB연결
	public MemberShipDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}

	//DB연결 인수생성자 정의
	public MemberShipDAO(ServletContext app) {
		super(app);
	}
	
	
	/* 사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 select한 후
	존재하는 회원정보인 경우 DTO객체에 레코드를 담아 반환한다. */
	public MemberShipDTO getMemberDTO(String uid, String upass) {
		
		MemberShipDTO dto = new MemberShipDTO();

		String query = "SELECT * FROM membership WHERE id=? AND pass=?";
		
		try {
			//쿼리문 실행을 위한 prepared객체 생성
			psmt = con.prepareStatement(query);
			//인파라미터를 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리문을 실행한 후 ResultSet객체를 통해 결과 반환
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				//회원정보가 있다면 DTO객체에 저장한다.
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	

	//회원가입 입력 메서드
	public int memberInsert(MemberShipDTO dto) {
		
		int result = 0;
		String query = "INSERT INTO membership VALUES( "
			    + " ? , ?, ?, ?, ? , "
			    +" ?, ?, ?, ?, ? ) ";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getTel());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getOpen_email());
			psmt.setString(8, dto.getZipcode());
			psmt.setString(9, dto.getAddr1());
			psmt.setString(10, dto.getAddr2());
			
			result = psmt.executeUpdate();
			
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//아이디 중복확인 메서드
	public boolean idOverlap(String id) {
		
		boolean retValue = true;
		//중복 아이디 확인 
		String sql = "SELECT COUNT(*) FROM membership WHERE id= ?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			rs.next();
			int result = rs.getInt(1);
			
			//중복아이디 1반환되면 false반환
			if(result ==1) {
				retValue = false;
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return retValue;
	}
	
	
	/* 아이디 찾기 */
	public MemberShipDTO getMemberId(String uname, String uemail) {
		
		MemberShipDTO dto = new MemberShipDTO();

		String query = "SELECT * FROM membership WHERE name=? AND email=?";
		
		try {
			//쿼리문 실행을 위한 prepared객체 생성
			psmt = con.prepareStatement(query);
			//인파라미터를 설정
			psmt.setString(1, uname);
			psmt.setString(2, uemail);
			//쿼리문을 실행한 후 ResultSet객체를 통해 결과 반환
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				//회원정보가 있다면 DTO객체에 저장한다.
				dto.setId(rs.getString("id"));
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	/* 비밀번호 찾기 */
	public MemberShipDTO getMemberPw(String uid, String uname, String uemail) {
		
		MemberShipDTO dto = new MemberShipDTO();
		
		String query = "SELECT * FROM membership WHERE id=? AND name=? AND email=?";
		
		try {
			//쿼리문 실행을 위한 prepared객체 생성
			psmt = con.prepareStatement(query);
			//인파라미터를 설정
			psmt.setString(1, uid);
			psmt.setString(2, uname);
			psmt.setString(3, uemail);
			//쿼리문을 실행한 후 ResultSet객체를 통해 결과 반환
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				//회원정보가 있다면 DTO객체에 저장한다.
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPass(rs.getString("pass"));
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
	
	
	
	
	
	
}
