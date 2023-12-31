package model2.board;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model1.board.BoardDAO;
import model1.board.BoardDTO;

/* 내용보기의 매핑은 web.xml이 아닌 어노테이션을 통해 설정한다. */
@WebServlet("/community/view.do")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/* 서블릿의 수명주기 메서드 중 전송방식에 상관없이 요청을 처리하고 
	싶을때는 service()메서드를 오버라이딩 하면된다. 해당 메서드의 역할은
	요청을 분석한 후 doGet() 혹은 doPost()를 호출하는 것이다. */
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
    	
        // 게시물 불러오기
        BoardDAO dao = new BoardDAO();
        //파라미터로 전달된 일련번호를 받는다. 
        String num = req.getParameter("num");
        String tname = req.getParameter("tname");
        //조회수 1 증가
        dao.updateVisitCount(tname,num);
        //게시물을 인출한다. 
        BoardDTO dto = dao.selectView(tname,num);
        dao.close();

        /* 내용의 경우 Enter를 통해 줄바꿈을 하게 되므로 웹브라우저 출력시
        <br>로 변경해야 한다. */
        dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
        
        //첨부파일 확장자 추출 및 이미지 타입 확인
        String ext = null, fileName = dto.getSfile();
        if(fileName!=null) {
        	ext = fileName.substring(fileName.lastIndexOf(".")+1);
        }
        String[] mimeStr = {"png","jpg","gif"};
        List<String> mimeList = Arrays.asList(mimeStr);
        boolean isImage = false;
        if(mimeList.contains(ext)) {
        	isImage = true;
        }
        
//        System.out.println("tname="+dto.getTname());
//        System.out.println("num="+dto.getNum());
//        System.out.println("tname="+tname);
                
        // 게시물(dto)을 request영역에 저장한 후 뷰로 포워드한다. 
        req.setAttribute("dto", dto);
        req.setAttribute("isImage", isImage);
        req.getRequestDispatcher("/community/sub01View.jsp").forward(req, resp);
    }
}




