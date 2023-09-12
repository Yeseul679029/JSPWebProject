<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<% 
String tname = request.getParameter("tname");
%>
<%@ include file="../space/IsLoggedIn.jsp"%> 

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

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
			
			<% if(tname.equals("empboard")){ %>
				<div class="top_title">
					<img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;직원자료실<p>
				</div>
			<%}else if(tname.equals("guardboard")){ %>
				<div class="top_title">
					<img src="../images/community/sub02_title.gif" alt="보호자게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;보호자게시판<p>
				</div>
			<%} %>
				
		
				<div>
<!-- 게시판 들어가는 부분start -->

<form name="writeFrm" method="post" action="../community/edit.do" enctype="multipart/form-data"
      onsubmit="return validateForm(this);">
    <input type="hidd-en" name="tname" value="<%= tname %>" />
    <input type="hidd-en" name="tname2" value="${dto.tname }" />
    <input type="hid-den" name="num" value="${dto.num }" />
    <input type="hidde-n" name="prevOfile" value="${dto.ofile }" />
    <input type="hidde-n" name="prevSfile" value="${dto.sfile }" />
    <table class="table table-bordered" width="100%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%; height: 20px; font-size: 15px"
                	value="${dto.title }" />
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;">${dto.content }</textarea>
            </td>
        </tr>
    <!-- 첨부파일 테이블 -->
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
	        	${dto.ofile }
	        	<input type="file" name="ofile"/>
	        </td>
	    </tr>
        
        
        
        <tr>
            <td colspan="2" align="center">
                <button type="submit" class="btn btn-outline-primary btn-sm">작성 완료</button>
                <button type="reset" class="btn btn-outline-danger btn-sm">다시 입력</button>
                
                <button type="button" onclick="location.href='../community/List.do?tname=<%=tname %>';" class="btn btn-outline-dark btn-sm">
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