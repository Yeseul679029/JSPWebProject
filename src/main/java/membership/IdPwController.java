package membership;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/membership/id_pw.do")
public class IdPwController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DB연결
		MemberShipDAO dao = new MemberShipDAO();
		
		//게시물의 구간 및 검색어 관련 파라미터 저장을 위한 Map컬렉션 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		//검색어 파라미터가 있는경우 req(request내장객체)를 통해 받는다.
		String searchUserName = req.getParameter("searchUserName");
		String searchEmail = req.getParameter("searchEmail");
		
		System.out.println(searchUserName + searchEmail);
		
		if(searchUserName != null && searchEmail != null){
			//검색어가 있는경우 Map에 추가
			map.put("searchUserName", searchUserName);
			map.put("searchEmail", searchEmail);
		}
		
		
		//해당 페이지에 출력할 게시물을 List컬렉션으로 얻어온다.
		//List<MemberShipDTO> memberLists = dao.getMemberId(map);
		dao.close();
		
		
		//View(JSP페이지)로 전달할 데이터를 request영역에 저장
		//req.setAttribute("memberLists", memberLists);
		req.setAttribute("map", map);
		//포워드
		req.getRequestDispatcher("/member/id_pw.jsp").forward(req, resp);
		
	}
}
