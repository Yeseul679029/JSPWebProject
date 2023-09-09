<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 페이지에 오랫동안 머물러 세션이 삭제되는 경우가 있으므로
글쓰기 처리 페이지에서도 반드시 로그인을 확인해야한다.  -->    
 
<%
	
     //클라이언트가 작성한 폼값을 받아온다. 
     String title = request.getParameter("title");
     String content = request.getParameter("content");
     String tname = request.getParameter("tname");
     //System.out.println("tname="+tname);
     //파일업로드
     //업로드 디렉토리의 물리적 경로 확인
     String sDirectory = application.getRealPath("/Uploads");
     /* 파일 첨부를 위한 <input> 태그의 name속성값을 이용해서 Part객체를
	 생성한다. 해당 객체를 통해 파일을 서버에 저장할 수 있다. */
	 Part part = request.getPart("ofile");
     
     
     //DTO 생성
     BoardDTO dto = new BoardDTO();
     
     String partHeader = "";
     String[] phArr;
     String originalFileName="";
//part가 null이 아닐경우 (첨부파일게시판일경우)
if(part != null ){

	 /* Part객체에서 아래 헤더값을 읽어오면 전송된 파일의 원본명을
	 알수있다.(콘솔에서 확인할것) */
	 partHeader = part.getHeader("content-disposition");
	 System.out.println("partHeader="+ partHeader);
	 
	 /* "filename=" 를 구분자로 헤더값을 split()하면 String타입의 배열로
	반환된다. */
	phArr = partHeader.split("filename=");
	originalFileName = phArr[1].trim().replace("\"", "");
	if (!originalFileName.isEmpty()) {				
		part.write(sDirectory+ File.separator +originalFileName);
		//System.out.println("sDirectory="+sDirectory+", originalFileName="+originalFileName);
		//System.out.println(sDirectory+ File.separator +originalFileName);
	}
	

     
   //첨부파일이 정상적으로 등록되어 원본파일명이 반환되었다면
	if (originalFileName != "") {
		
		String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		
		String newFileName = now + ext;
		
		//원본파일명과 새로운파일명을 통해 File객체를 생성한다. 
		File oldFile = new File(sDirectory + File.separator + originalFileName);
		File newFile = new File(sDirectory + File.separator + newFileName);
		//파일명을 변경한다.
		oldFile.renameTo(newFile);
		
		
		//파일명을 "날짜_시간.확장자"형식으로 변경한다.
		String savedFileName = newFileName;
		
		//원본과 변경된 파일명을 DTO에 저장한다.
		dto.setOfile(originalFileName); //원래 파일 이름
		dto.setSfile(savedFileName); //서버에 저장된 파일 이름
	}
     
}  
     //폼값을 DTO객체에 저장한다. 
     dto.setTitle(title);
     dto.setContent(content);
     /* 특히 아이디의 경우 로그인 후 작성페이지에 진입할 수 있으므로 
     세션영역에 저장된 회원아이디를 가져와서 저장한다. */
     dto.setId(session.getAttribute("UserId").toString());
     
	//DAO를 통해 DB에 게시 내용 저장
     BoardDAO dao = new BoardDAO(application);

     int iResult = 0;
     
     if(originalFileName == ""){
	     //기존과 같이 게시물 1개를 등록할때 사용..
	     iResult = dao.insertWrite(tname,dto);
     }
     else if(originalFileName != ""){
    	 iResult = dao.FileWrite(tname,dto);
     }

     //페이징 테스트를 위해 100개의 게시물을 한번에 입력..
   /*   int iResult = 0;
     for(int i=1 ; i<=100 ; i++){
     	
     	//만약 제목을 "안녕하세요"로 입력했다면...
     	//"..세요1", "..세요2" 와 같이 설정된다.  
     	
     	dto.setTitle(title + i);
     	iResult = dao.insertWrite(dto);
     } */

     dao.close();

     if (iResult == 1) {
     	//글쓰기에 성공했다면 목록으로 이동한다. 
         response.sendRedirect("sub01List.jsp?tname="+tname);
     } 
     else {
     	//실패했다면 경고창(alert)을 띄우고, 뒤로(history) 이동한다. 
         JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
     }
     %>



