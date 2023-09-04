package membership;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

//쿼리문 실행하기 위한 용도
public class MemberShipDAO extends JDBConnect {
	
	//DB연결 인수생성자 정의
	public MemberShipDAO(ServletContext app) {
		super(app);
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
	
	
	
	
	
	
	
	
}
