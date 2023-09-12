package model2.board;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model1.board.BoardDAO;
import model1.board.BoardDTO;
import utils.JSFunction;

@WebServlet("/community/write.do")
@MultipartConfig(
	maxFileSize = 1024 * 1024 *1,
	maxRequestSize = 1024 * 1024 * 10
)
public class WriteController extends HttpServlet{
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
		
		req.getRequestDispatcher("/community/sub01Write.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 1. 파일 업로드 처리 =============================
        // 업로드 디렉터리의 물리적 경로 확인
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");
                
        // 파일 업로드
        String originalFileName = "";
        try {
        	//업로드가 정상적으로 완료되면 원본 파일명을 반환한다. 
        	originalFileName = FileUtil.uploadFile(req, saveDirectory);
        }
        catch (Exception e) {
        	/* 파일업로드 시 오류가 발생되면 경고창을 띄운후 작성페이지로 
        	이동한다. 예외 발생의 이유를 확인하기 위해 printStackTrace()메서드를 
        	사용하는것이 좋다. */
        	e.printStackTrace();
        	JSFunction.alertLocation(resp, "파일 업로드 오류입니다.",
                    "../community/write.do");
        	return;
		}
     // 2. 파일 업로드 외 처리 =============================
        
        /*아이디 불러오기 */
        HttpSession session = req.getSession();
        String id = (String) session.getAttribute("UserId");
        
        // 첨부파일 이외의 폼값을 DTO에 저장
        BoardDTO dto = new BoardDTO(); 
        dto.setTname(req.getParameter("tname"));
        dto.setName(req.getParameter("name"));
        dto.setTitle(req.getParameter("title"));
        dto.setContent(req.getParameter("content"));
        dto.setId(id);

        // 첨부파일이 정상적으로 등록되어 원본파일명이 반환되었다면
        if (originalFileName != "") { 
        	// 파일명을 "날짜_시간.확장자"형식으로 변경한다. 
        	String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
        	
        	//원본과 변경된 파일명을 DTO에 저장한다.
            dto.setOfile(originalFileName);  // 원래 파일 이름
            dto.setSfile(savedFileName);  // 서버에 저장된 파일 이름
        }

        // DAO를 통해 DB에 게시 내용 저장
        BoardDAO dao = new BoardDAO();
        int result = dao.FileWrite(dto.getTname(),dto);
        dao.close();

        // 성공 or 실패?
        if (result == 1) {  
        	// 글쓰기 성공시 목록 페이지로 이동
            resp.sendRedirect("../community/List.do?tname="+dto.getTname());
        }
        else {  
        	// 글쓰기 실패시 쓰기 페이지로 이동 
        	 JSFunction.alertLocation(resp, "글쓰기에 실패했습니다.",
                     "../community/write.do?tname="+dto.getTname());
        }
		
	}
	
}
