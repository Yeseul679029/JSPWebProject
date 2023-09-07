package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model1.board.BoardDAO;
import model1.board.BoardDTO;

@WebServlet("/main/main.do")
public class MainCtrl extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//DB연결 application 객체를 getServletContext로 불러올수있음
		BoardDAO dao = new BoardDAO(getServletContext());
		//DAO로 전달할 파라미터를 저장하기위한 Map컬렉션 생성
		Map<String, Object> param = new HashMap<>();
		param.put("start", 1);
		param.put("end", 4);
		
		//페이징쪽에서 쓰던 start와 end를 사용한다
		//공지사항 최근 게시물 4개 추출(noticeboard)
		param.put("tname", "noticeboard");
		//게시물이 여러개니까 List타입이고 boarDTO를 담아서 반환해줄것
		List<BoardDTO> notice = dao.selectListPage(param);
		
		
		//자유게시판 최근 게시물 4개 추출(freeboard)
		/*중복 키인데 괜찮나요? 어차피 덮어씌워지면 noticeboard는 없어지고 
		freeboard로 다시전달되고 freeboard를 가지고오게된다*/
		param.put("tname", "freeboard");
		List<BoardDTO> free = dao.selectListPage(param);
		
		//reqest 영역에 저장
		req.setAttribute("notice", notice);
		req.setAttribute("free", free);
		
		//매핑된주소를 요청하면 jsp를 찾아서 포워드
		req.getRequestDispatcher("../main/main.jsp").forward(req, resp);
	
	}
}
