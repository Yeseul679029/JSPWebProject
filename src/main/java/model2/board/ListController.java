package model2.board;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model1.board.BoardDAO;
import model1.board.BoardDTO;
import utils.BoardPage;

@WebServlet("/community/List.do")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DB연결
		BoardDAO dao =new BoardDAO();
		
		//게시물의 구간 및 검색어 관련 파라미터 저장을 위한 Map컬렉션 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		//게시판 테이블 받아오기
		String tname = req.getParameter("tname");
		//테이블명 map에 저장
        map.put("tname", tname);
		
		//검색어 파라미터가 있는경우 req(request내장객체)를 통해 받는다.
		String searchField = req.getParameter("searchField");
        String searchWord = req.getParameter("searchWord");
        if (searchWord != null) {
        	//검색어가 있는경우 Map에 추가 
            map.put("searchField", searchField);
            map.put("searchWord", searchWord);
        }
        //게시물의 갯수를 카운트(검색어가 있다면 where절 추가)
        int totalCount = dao.selectCount(map); 

        /* 페이지 처리 start */
        /* 모델2 방식의 게시판에서는 요청을 서블릿이 먼저 받으므로 내장객체
        사용을 위해서 반드시 아래와 같이 메서드를 통해 객체를 얻어온 후 
        사용해야한다. */
        ServletContext application = getServletContext();
        //한 페이지에 출력할 게시물의 갯수 
        int pageSize = 
        		Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
        //한 블럭당 출력할 페이지번호의 갯수
        int blockPage = 
        		Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

        // 현재 페이지 확인
        int pageNum = 1; 
        String pageTemp = req.getParameter("pageNum");
        if (pageTemp != null && !pageTemp.equals(""))
            pageNum = Integer.parseInt(pageTemp); 

        // 목록에 출력할 게시물 범위 계산
        int start = (pageNum - 1) * pageSize + 1;  
        int end = pageNum * pageSize; 
        //계산된 페이지의 범위는 Map에 추가함 
        map.put("start", start);
        map.put("end", end);
        /* 페이지 처리 end */
        
        //해당 페이지에 출력할 게시물을 List컬렉션으로 얻어온다. 
        List<BoardDTO> boardLists = dao.selectListPage(map);  
        dao.close();  

        // 뷰에 전달할 매개변수 추가
        String pagingImg = BoardPage.pagingStr(totalCount, pageSize,
                blockPage,tname, pageNum, "../community/list.do");
        
       
        //페이지 번호
        map.put("pagingImg", pagingImg);
        //전체 게시물의 갯수
        map.put("totalCount", totalCount);
        //한페이지에 출력할 갯수
        map.put("pageSize", pageSize);
        //현재 페이지 번호 
        map.put("pageNum", pageNum);

        //View(JSP페이지)로 전달할 데이터를 request영역에 저장
        req.setAttribute("boardLists", boardLists);
        req.setAttribute("map", map);
        //포워드 
        req.getRequestDispatcher("/community/sub01List.jsp").forward(req, resp);
		
		
	}
	
}
