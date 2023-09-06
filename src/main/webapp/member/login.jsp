<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
/* 로그인 폼의 입력값을 검증하기 위한 함수로 빈값인지를 확인한다. */
function validateForm(form) {
    if (!form.user_id.value) {
        alert("아이디를 입력하세요.");
        form.user_id.focus();
        return false;
    }
    if (form.user_pw.value == "") {
        alert("패스워드를 입력하세요.");
        form.user_pw.focus();
        return false;
    }
}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
				
				<div class="login_box01">

					<%
				    /* session영역에 해당 속성값이 있는지 확인한다. 즉, session영역에
				    데이터가 없다면 로그아웃 상태이므로 로그인 폼을 웹브라우저에 출력한다. */
				    if (session.getAttribute("UserId") == null) { 
				    %>
				    
				    <form action="LoginProcess.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this);">
						<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
						<!-- 로그인오류 -->
						<span style="color: red; font-size: 1.2em; padding-left: 10px"> 
					        <%= request.getAttribute("LoginErrMsg") == null ?
					                "" : request.getAttribute("LoginErrMsg") %>
					    </span>
						<ul>
							<li>
								<img src="../images/login_tit001.gif" alt="아이디" style="margin-right:12px;" />
								<input type="text" name="user_id" value="" class="login_input01" />
							</li>
							<li>
								<img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:12px;" />
								<input type="password" name="user_pw" value="" class="login_input01" />
							</li>
						</ul>
						<input type="image" src="../images/login_btn.gif" class="login_btn01" />
					</form>
					<%
				    } else {  
				    	//로그인이 된 상태에서는 회원의 이름과 로그아웃 버튼을 출력한다.
				    %>
				        <%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br />
				        <a href="Logout.jsp">[로그아웃]</a>
				    <%
				    }
				    %>
				
				</div>
				<p style="text-align:center; margin-bottom:50px;margin-left:-110px;"><a href="id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href="join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
