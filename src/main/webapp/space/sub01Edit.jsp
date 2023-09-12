<%@page import="model1.board.NoticeBoardDTO"%>
<%@page import="model1.board.NoticeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./EditCommon.jsp" %>
<%@ include file="./IsLoggedIn.jsp"%>
<%@ include file="../include/global_head.jsp" %>
<%

%>
<script type="text/javascript">
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
			<%}else if(tname.equals("imagesboard")){ %>
				<div class="top_title">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
			<%}else if(tname.equals("referenceboard")){ %>
				<div class="top_title">
					<img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
				</div>
			<%} %>
				
				
				<div>
<!-- 게시판 들어가는 부분start -->

<!-- 수정페이지는 일반적으로 쓰기페이지를 복사해서 제작하게 되므로 
action속성값을 반드시 수정해야 한다. 만약 수정하지 않으면 게시물이 
추가되는 헤프닝이 생기게된다.  -->
<form name="writeFrm" method="post" action="EditProcess.jsp"  enctype="multipart/form-data"
      onsubmit="return validateForm(this);">

<input type="hidden" name="num" value="<%= dto.getNum() %>" />
<input type="hidden" name="tname" value="<%= tname %>" />
<input type="hidden" name="prevOfile" value="<%= dto.getOfile() %>" />
<input type="hidden" name="prevSfile" value="<%= dto.getSfile() %>" />
      
    <table class="table table-bordered" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" 
                	value="<%= dto.getTitle() %>" />
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; 
                	height: 100px;"><%= dto.getContent() %></textarea>
            </td>
        </tr>
    <!-- 첨부파일 테이블 -->
    <% if(tname.equals("referenceboard")||tname.equals("imagesboard")){ %>
    	<script>
			/* 폼값을 submit(전송)할때 빈값에 대한 검증을 위한 JS 함수
			필수사항인 제목과 첨부파일에 대해서만 검증한다. */
			/* function validateForm(form) {
				if (form.ofile.value == ""){
					alert("첨부파일은 필수 입력입니다.");
					return false;
				}
			} */
		</script>
        <tr>
	        <td>첨부파일</td>
	        <td colspan="3">           
	        	<%= dto.getOfile()%>
	        	<input type="file" name="ofile" />
	        </td>
	    </tr>
	<%} %>	
        
        
        <tr>
            <td colspan="2" align="center">
                <button type="submit" class="btn btn-outline-primary btn-sm">작성 완료</button>
                <button type="reset" class="btn btn-outline-danger btn-sm">다시 입력</button>
                <% if(tname.equals("imagesboard")){ %>
                <button type="button" onclick="location.href='sub04List.jsp?tname=<%= tname%>';"class="btn btn-outline-dark btn-sm">
                    목록 보기</button>
                <%}else{ %>
                <button type="button" onclick="location.href='sub01List.jsp?tname=<%= tname%>';"class="btn btn-outline-dark btn-sm">
                    목록 보기</button>
                <%} %>
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