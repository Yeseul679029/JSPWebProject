package model2.board;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model1.board.BoardDAO;
import model1.board.BoardDTO;
import utils.JSFunction;

@WebServlet("/community/delete.do")
public class DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//매개변수 저장
		String num = req.getParameter("num");
		String tname = req.getParameter("tname");
		String id = req.getParameter("id");
		
		
		
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO();
   	 	dto = dao.selectView(tname, num);
   	 	
		/*아이디 불러오기 */
        HttpSession session = req.getSession();
        String UserId = (String) session.getAttribute("UserId");
        
        System.out.println("UserId="+ UserId+", dto.id="+dto.getId());
        
        
        
        if(UserId.equals(dto.getId())) {
        	
        	int result = dao.deletePost(tname, dto);
        	dao.close();
        	if(result ==1) {
        		String saveFileName = dto.getSfile();
        		FileUtil.deleteFile(req, "/Uploads", saveFileName);
        	}
        	//게시물 삭제가 완료되면 목록으로 이동한다.
        	JSFunction.alertLocation(resp, "삭제되었습니다.", "../community/List.do?tname="+tname);
        	
        }
        else {
        	//일치하지않음
        	JSFunction.alertBack(resp, "본인이 아닙니다.");
        }
        
        
		
	}

}
