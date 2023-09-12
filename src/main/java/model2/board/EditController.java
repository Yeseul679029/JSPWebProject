package model2.board;

import java.io.IOException;

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

//요청명에 대한 매핑
@WebServlet("/community/edit.do")
//수정페이지에서도 파일을 등록할 수 있으므로  멀티파트 설정
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
)
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//수정페이지로 진입하면 기존의 내용을 가져와서 쓰기폼에 세팅한다.
	//단순한 페이지 이동이므로 get방식 요청이다.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//일련번호를 받는다.
		String num = req.getParameter("num");
		String tname = req.getParameter("tname");
		//DAO객체를 생성한 후 기존 게시물의 내용을 가져온다.
		BoardDAO dao = new BoardDAO();
		
		//가져온걸 DTO에 저장
		BoardDTO dto = dao.selectView(tname,num);
		//DTO객체를 request영역에 저장한 후 포워드한다.
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/community/sub01Edit.jsp").forward(req, resp);
	}
	
	/* 수정할 내용을 입력한 후 전송된 폼값을 update 쿼리문으로 갱신한다.
	게시판은 post방식으로 전송되므로 doPost()를 오버라이딩 한다. */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//1.파일 업로드 처리===============================
		//업로드 디렉토리의 물리적 경로 가져온다.
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		//파일 업로드
		String originalFileName = "";
		try {
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		} 
		catch (Exception e) {
			e.printStackTrace();
			JSFunction.alertLocation(resp, "파일 업로드 오류입니다.", "../community/edit.do");
			
			return;
		}
		
		
		//2. 파일 업로드 외 처리 ===========================
		/* 수정을 위해 hidden박스에 저장된 내용도 함께 받아온다. 게시물의
		일련번호와 기존 등록된 파일명이 함께 전송된다.*/
		
		//아이디 session에서 가져옴
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("UserId");
		
		String num = req.getParameter("num");
		String tname = req.getParameter("tname");
		String prevOfile = req.getParameter("prevOfile");
		String prevSfile = req.getParameter("prevSfile");
		
		//String name = req.getParameter("name");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		
		//첨부파일 이외의 폼값을 DTO에 저장
		BoardDTO dto = new BoardDTO();
		dto.setNum(num);
		//dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setId(id);
		dto.setTname(tname);
		
		if (originalFileName != "") {
			/* 수정페이지에서 새롭게 등록한 파일이 있다면 기존 내용을
			수정해야 한다. 파일명의 이름을 변경한 후 원본파일명과 저장된
			파일명을 DTO에 저장한다.*/
			String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
			
			dto.setOfile(originalFileName); //원래 파일 이름
			dto.setSfile(savedFileName); //서버에 저장된 파일 이름
			
			FileUtil.deleteFile(req, "/Uploads", prevSfile);
		}
		else {
			//첨부파일이 없으면 기존 이름 유지
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		
		//DB에 수정 내용 반영
		BoardDAO dao = new BoardDAO();
		int result = 0;
		
		if(prevOfile != null) {
			result = dao.updateFileEdit(dto,tname);
		}
		else {
			result = dao.updateEdit(dto, tname);
		}
		dao.close();
		
		//성공 or 실패?
		if (result == 1) {	//수정 성공
			//세션영역에 저장된 패스워드를 삭제한다.
			//session.removeAttribute("pass");
			resp.sendRedirect("../community/view.do?tname="+tname+"&num="+num);
		}
		else {	//수정 실패
			JSFunction.alertLocation(resp, "본인인증 다시해주세요.", "../mvcboard/view.do?tname="+tname+"&num="+ num);
		}
	}
	
}
