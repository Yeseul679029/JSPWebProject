<%@page import="model1.board.NoticeBoardDTO"%>
<%@page import="model1.board.NoticeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%@ include file="../include/global_head.jsp" %>

<%
//수정할 게시물의 일련번호를 파라미터로 받아온다. 
String num = request.getParameter("num");
//DAO객체 생성 및 DB연결
NoticeBoardDAO dao = new NoticeBoardDAO(application);
//기존 게시물의 내용을 읽어온다. 
NoticeBoardDTO dto = dao.selectView(num);
//세션영역에 저장된 회원 아이디를 가져와서 문자열로 변환한다. 
String sessionId = session.getAttribute("UserId").toString();
//로그인한 회원이 해당 게시물의 작성자인지 확인한다. 
if (!sessionId.equals(dto.getId())) {  
	//작성자가 아니라면 진입할 수 없도록 하고 뒤로 이동한다. 
    JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
    return;
}
//출력결과가 Console에 나온다.
//System.out.println(num+"+"+sessionId);
/*
URL의 패턴을 파악하면 내가 작성한 게시물이 아니어도 얼마든지
수정페이지로 진입할 수 있다. 따라서 수정페이지 자체에서도 작성자
본인이 맞는지 확인하는 절차가 필요하다. 
*/
dao.close();
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
				<div class="top_title">
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
				</div>
				<div>
<!-- 게시판 들어가는 부분start -->

<!-- 수정페이지는 일반적으로 쓰기페이지를 복사해서 제작하게 되므로 
action속성값을 반드시 수정해야 한다. 만약 수정하지 않으면 게시물이 
추가되는 헤프닝이 생기게된다.  -->
<form name="writeFrm" method="post" action="EditProcess.jsp"
      onsubmit="return validateForm(this);">

<input type="hidden" name="num" value="<%= dto.getNum() %>" />
      
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
        <tr>
            <td colspan="2" align="center">
                <button type="submit" class="btn btn-outline-primary btn-sm">작성 완료</button>
                <button type="reset" class="btn btn-outline-danger btn-sm">다시 입력</button>
                <button type="button" onclick="location.href='sub01List.jsp';"class="btn btn-outline-dark btn-sm">
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