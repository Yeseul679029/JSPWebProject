<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>

<%@ include file="../include/global_head.jsp" %>

<%@ include file="ViewCommon.jsp" %>


<script>
//게시물 삭제를 위한 Javascript 함수
function deletePost() {
	//confirm() 함수는 대화창에서 '예'를 누를때 true가 반환된다. 
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
    	//<form> 태그의 name속성을 통해 DOM을 얻어온다.
        var form = document.writeFrm;      
    	//전송방식과 전송할경로를 지정한다. 
        form.method = "post";  
        form.action = "DeleteProcess.jsp";
        //submit() 함수를 통해 폼값을 전송한다. 
        form.submit();  
        //<form>태그 하위의 hidden박스에 설정된 일련번호를 전송한다. 
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
			
			<!-- 타이틀 제목이미지 -->
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

<!-- 게시물 삭제를 위해 hidden 타입의 <input>태그를 하나 추가한다. 
삭제 버튼 클릭시 일련번호를 서버로 전송한다.   -->
<form name="writeFrm">
<input type="hidden" name="num" value="<%= num %>" />
<input type="hidden" name="tname" value="<%= tname %>" />

	<!-- DTO에 저장된 내용을 getter를 통해 웹브라우저에 출력한다. -->  
    <table class="table table-bordered " width="90%">
        <tr>
            <td>번호</td>
            <td><%= dto.getNum() %></td>
            <td>작성자</td>
            <td><%= dto.getName() %></td>
        </tr>
        <tr>
            <td>작성일</td>
            <td><%= dto.getPostdate() %></td>
            <td>조회수</td>
            <td><%= dto.getVisitcount() %></td>
        </tr>
        <tr>
            <td>제목</td>
            <td colspan="3"><%= dto.getTitle() %></td>
        </tr>
        <tr>
            <td>내용</td>
            <td colspan="3" height="100">
            	<!-- 입력시 줄바꿈을 위한 엔터는 \r\n으로 입력되므로 
            	웹	브라우저에 출력시에는 <br>태그로 변경해야한다. -->
                <%= dto.getContent().replace("\r\n", "<br/>") %>
            </td> 
        </tr>
        <!-- 첨부파일 테이블 -->
        <% if(tname.equals("referenceboard")){ %>
        <tr><td>asdfasdfasd</td></tr>
        <%-- <tr>
	        <td>첨부파일</td>
	        <td colspan="3">           
	        	<c:if test="${ not empty dto.ofile }">
	        	${ dto.ofile }
	        	<a href="../mvcboard/download.do?ofile=<%= dto.getOfile() %>&sfile=<%= dto.getSfile() %>&num=<%= dto.getNum() %>">
	                [다운로드]            
	        	</a>
	        	</c:if> 
	        </td>
	    </tr>   --%>
	    <%} %>	
        <tr>
            <td colspan="4" align="center">
<%
/* 로그인이 된 상태에서 세션영역에 저장된 아이디가 해당 게시물을 
작성한 아이디와 일치하면 수정, 삭제 버튼을 보이게 처리한다. 
즉, 작성자 본인이 해당 게시물을 조회했을때만 수정, 삭제 버튼이 보이게
처리한다. */
if(session.getAttribute("UserId")!=null &&  
	dto.getId().equals(session.getAttribute("UserId").toString())){
%>
     <button type="button"
             onclick="location.href='sub01Edit.jsp?tname=<%=tname%>&num=<%= dto.getNum() %>';" class="btn btn-outline-primary btn-sm">
         수정하기</button>
         
     <!-- 삭제하기 버튼을 누르면 JS의 함수를 호출한다. 해당 함수는 
     submit()을 통해 폼값을 서버로 전송한다.  -->
     <button type="button" onclick="deletePost();" class="btn btn-outline-danger btn-sm">삭제하기</button> 
<%
}
%>
                <button type="button" onclick="location.href='sub01List.jsp?tname=<%=tname %>'"+";" class="btn btn-outline-dark btn-sm">
                    목록 보기
                </button>
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