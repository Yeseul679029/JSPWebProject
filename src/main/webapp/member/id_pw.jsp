<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ include file="../include/global_head.jsp" %>

<script>
 /* 로그인 폼의 입력값을 검증하기 위한 함수로 빈값인지를 확인한다. */

 function memberIdForm(form) {
     if (!form.user_name.value) {
         alert("이름을 입력하세요.");
         form.user_name.focus();
         return false;
     }
     if (form.user_email.value == "") {
         alert("이메일을 입력하세요.");
         form.user_email.focus();
         return false;
     }
 }
 
 function memberPwForm(form) {
     if (!form.user_id.value) {
         alert("아이디를 입력하세요.");
         form.user_id.focus();
         return false;
     }
     if (!form.user_name.value) {
         alert("이름을 입력하세요.");
         form.user_name.focus();
         return false;
     }
     if (form.user_email.value == "") {
         alert("이메일을 입력하세요.");
         form.user_email.focus();
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
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>

				<%
			    if (request.getAttribute("UserName") == null) { 
			    %>
				<div class="idpw_box">
					<!-- 아이디 찾기 박스 -->
					<div class="id_box">
						<!-- 아이디찾기오류 -->
						<span style="color: red; font-size: 1.5em; padding-left: 15px;"> 
					        <%= request.getAttribute("IdErrMsg") == null ?
					                "" : request.getAttribute("IdErrMsg") %>
					    </span>
						<form action="IdProcess.jsp" method="get" name="idCheck" onsubmit="return memberIdForm(this);">
							<ul>
								<li><input type="text" name="user_name" value="" class="login_input01" /></li>
								<li><input type="text" name="user_email" value="" class="login_input01" /></li>
							</ul>
							<input type="image" src="../images/member/id_btn01.gif" class="id_btn" alt="확인버튼"/>
							
							<a href="join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" alt="회원가입버튼"/></a>
						</form>
					</div>
					
					<!-- 비밀번호 찾기 박스 -->
					<div class="pw_box">
						<!-- 비번찾기오류 -->
						<span style="color: red; font-size: 1.5em; padding-left: 15px;"> 
					        <%= request.getAttribute("PwErrMsg") == null ?
					                "" : request.getAttribute("PwErrMsg") %>
					    </span>
						<form action="PwProcess.jsp" method="get" name="pwCheck" onsubmit="return memberPwForm(this);">
							<ul>
								<li><input type="text" name="user_id" value="" class="login_input01" /></li>
								<li><input type="text" name="user_name" value="" class="login_input01" /></li>
								<li><input type="text" name="user_email" value="" class="login_input01" /></li>
							</ul>
							<input type="image" src="../images/member/id_btn01.gif" class="pw_btn" alt="확인버튼"/>
						</form>
					</div>
					
				</div>
				<%
			    } else if (request.getAttribute("UserPass") == null){  
			    %>
			        <%= request.getAttribute("UserName") %> 님의 아이디는 <br />
					<%= request.getAttribute("UserId") %> 입니다. <br />
			        <a href="login.jsp">[로그인하러가기]</a> &nbsp;&nbsp;
			        <a href="id_pw.jsp">[비밀번호찾기]</a>
			    <%
			    }else if (request.getAttribute("UserPass") != null){  
			    %>
			        <%= request.getAttribute("UserName") %> 님의 비밀번호는 <br />
					<%= request.getAttribute("UserPass") %> 입니다. <br />
			        <a href="login.jsp">[로그인하러가기]</a> &nbsp;&nbsp;
			    <%
			    }
			    %>
	    	
		
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
