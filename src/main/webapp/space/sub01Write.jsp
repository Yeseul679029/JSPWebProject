<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ include file="./IsLoggedIn.jsp"%> 

<% 
String tname = request.getParameter("tname");
%>

<%@ include file="../include/global_head.jsp" %>

<script type="text/javascript">
/* 글쓰기 페이지에서 제목과 내용이 입력되었는지 검증하는 JS코드 */
function validateForm(form) { 
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
			
			<% if(tname.equals("noticeboard")){ %>
				<div class="top_title">
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
				</div>
			<%}else if(tname.equals("freeboard")){ %>
				<div class="top_title">
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
				</div>
			<%}else if(tname.equals("referenceboard")){ %>
				<div class="top_title">
					<img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
				</div>
			<%} %>
				
		
				<div>
<!-- 게시판 들어가는 부분start -->

<form name="writeFrm" method="post" action="WriteProcess.jsp" 
      onsubmit="return validateForm(this);">
    <input type="hid-den" name="tname" value="<%= tname %>" />
    <table class="table table-bordered" width="100%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%; height: 20px; font-size: 15px" />
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
    <!-- 첨부파일 테이블 -->
    <% if(tname.equals("referenceboard")){ %>
    	<script>
			/* 폼값을 submit(전송)할때 빈값에 대한 검증을 위한 JS 함수
			필수사항인 제목과 첨부파일에 대해서만 검증한다. */
			function validateForm(form) {
				if (form.ofile.value == ""){
					alert("첨부파일은 필수 입력입니다.");
					return false;
				}
			}
		</script>
        <tr>
	        <td>첨부파일</td>
	        <td colspan="3">           
	        	<c:if test="${ not empty dto.ofile }">
	        	${ dto.ofile }
	        	<%-- <a href="../mvcboard/download.do?ofile=<%= dto.getOfile() %>&sfile=<%= dto.getSfile() %>&num=<%= dto.getNum() %>"> --%>
	                [다운로드]            
	        	</a>
	        	</c:if> 
	        </td>
	    </tr>
	<%} %>	
        
        
        
        
        <tr>
            <td colspan="2" align="center">
                <button type="submit" class="btn btn-outline-primary btn-sm">작성 완료</button>
                <button type="reset" class="btn btn-outline-danger btn-sm">다시 입력</button>
                <button type="button" onclick="location.href='sub01List.jsp?tname=<%=tname %>';" class="btn btn-outline-dark btn-sm">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>

<!-- 게시판 들어가는 부분end -->
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>