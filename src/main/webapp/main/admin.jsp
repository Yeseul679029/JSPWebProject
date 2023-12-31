<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- request 영역에 저장한것을 getAttribute로 가져다쓰는게 
	불편하니까 EL, JSTL사용 -->
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
</style>

<script>
/* 로그인 폼의 입력값을 검증하기 위한 함수로 빈값인지를 확인한다. */
function validateForm(form) {
	//입력값이 공백인지 확인후 경고창, 포커스이동, 폼값전송 중단처리를 한다.
    if (!form.userId.value) {
        alert("아이디를 입력하세요.");
        form.userId.focus();
        //여기서 false를 전하는 이유 공부하기 문제가있다면 
        //submit으로 전송되지않게끔 false를 전달
        return false;
    }
    if (form.userPw.value == "") {
        alert("패스워드를 입력하세요.");
        form.userPw.focus();
        return false;
    }
}
</script>
</head>
<body>

<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		
		<div id="main_visual">
		<a href="/product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title01.gif" alt="로그인 LOGIN" /></p>
				<div class="login_box">
				
	<%
	
	//페이지가 실행되면 loginId라는 쿠키를 읽어온다.
	String loginId = CookieManager.readCookie(request, "loginId");

	//'아이디저장' 체크박스에 체크를 하기위한 변수 생성
	String cookieCheck = "";
	if(!loginId.equals("")){
		/* 앞에서 읽은 쿠키값이 있다면 체크박스에 checked 속성을 부여한다.
		그러면 체크된 상태로 로드된다. */
		cookieCheck = "checked";
	}
	
	
	if (session.getAttribute("UserId") == null) { 
	%>
	
					<form action="../member/LoginProcess.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this);">
						<table cellpadding="0" cellspacing="0" border="0">
							<colgroup>
								<col width="45px" /><col width="120px" /><col width="55px" />
							</colgroup>
							<tr>
								<th><img src="../images/login_tit01.gif" alt="아이디"/></th>
								<td><input type="text" name="user_id" value="<%= loginId %>" class="login_input" tabindex="1"/></td>
								<td rowspan="2"><input type="image" src="../images/login_btn01.gif" alt="로그인" tabindex="3"/></td>
							</tr>
							<tr>
								<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
								<td><input type="password" name="user_pw" value="" class="login_input" tabindex="2"/></td>
							</tr>
						</table>
					<p>
						<input type="checkbox" name="save_check" value="Y" <%= cookieCheck %> /><img src="../images/login_tit03.gif" alt="아이디저장" />
						<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
					</p>
					</form>
					
					
<%
} else {
%>					 
					<!-- 로그인 후 -->
					<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;"><%= session.getAttribute("UserName") %>님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
					<p style="text-align:right; padding-right:10px;">
						<a href=""><img src="../images/login_btn04.gif" alt="회원정보수정"/></a>
						<a href="../member/Logout.jsp"><img src="../images/login_btn05.gif" alt="로그아웃"/></a>
					</p> 
<%
}
%>			 
				</div>
			</div>
			<div class="main_con_center">
				<p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="../space/sub01List.jsp?tname=noticeboard"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
			<!-- 공지사항 게시물4개 -->
				<ul class="main_board_list ">
				<!-- 확장 for문으로 게시글을 인출 -->
					<c:forEach items="${notice }" var="row" >
						<li><p style="width: 230px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="../space/sub01View.jsp?tname=noticeboard&num=${row.num}">${row.title }</a><span>${row.postdate }</span></p></li>
					</c:forEach>
				</ul>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="../space/sub01List.jsp?tname=freeboard"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
			<!-- 자유게시판 게시물4개 -->
				<ul class="main_board_list">
				<!-- 확장 for문으로 게시글을 인출 -->
					<c:forEach items="${free }" var="free">
						<li><p style="width: 230px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="../space/sub01View.jsp?tname=freeboard&num=${free.num}">${free.title }</a><span>${free.postdate }</span></p></li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="../images/main_tel.gif" />
			</div>
			<div class="main_con_center">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
				<div class="cal_top">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="13px;" />
							<col width="*" />
							<col width="13px;" />
						</colgroup>
						<tr>
							<td><a href=""><img src="../images/cal_a01.gif" style="margin-top:3px;" /></a></td>
							<td><img src="../images/calender_2012.gif" />&nbsp;&nbsp;<img src="../images/calender_m1.gif" /></td>
							<td><a href=""><img src="../images/cal_a02.gif" style="margin-top:3px;" /></a></td>
						</tr>
					</table>
				</div>
				<div class="cal_bottom">
					<table cellpadding="0" cellspacing="0" border="0" class="calendar">
						<colgroup>
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="*" />
						</colgroup>
						<tr>
							<th><img src="../images/day01.gif" alt="S" /></th>
							<th><img src="../images/day02.gif" alt="M" /></th>
							<th><img src="../images/day03.gif" alt="T" /></th>
							<th><img src="../images/day04.gif" alt="W" /></th>
							<th><img src="../images/day05.gif" alt="T" /></th>
							<th><img src="../images/day06.gif" alt="F" /></th>
							<th><img src="../images/day07.gif" alt="S" /></th>
						</tr>
						<tr>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">1</a></td>
							<td><a href="">2</a></td>
							<td><a href="">3</a></td>
						</tr>
						<tr>
							<td><a href="">4</a></td>
							<td><a href="">5</a></td>
							<td><a href="">6</a></td>
							<td><a href="">7</a></td>
							<td><a href="">8</a></td>
							<td><a href="">9</a></td>
							<td><a href="">10</a></td>
						</tr>
						<tr>
							<td><a href="">11</a></td>
							<td><a href="">12</a></td>
							<td><a href="">13</a></td>
							<td><a href="">14</a></td>
							<td><a href="">15</a></td>
							<td><a href="">16</a></td>
							<td><a href="">17</a></td>
						</tr>
						<tr>
							<td><a href="">18</a></td>
							<td><a href="">19</a></td>
							<td><a href="">20</a></td>
							<td><a href="">21</a></td>
							<td><a href="">22</a></td>
							<td><a href="">23</a></td>
							<td><a href="">24</a></td>
						</tr>
						<tr>
							<td><a href="">25</a></td>
							<td><a href="">26</a></td>
							<td><a href="">27</a></td>
							<td><a href="">28</a></td>
							<td><a href="">29</a></td>
							<td><a href="">30</a></td>
							<td><a href="">31</a></td>
						</tr>
						<tr>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="../space/sub04List.jsp?tname=imagesboard">
						<img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<!-- 사진게시판 게시물6개 -->
				<ul class="main_photo_list">
					<c:forEach items="${images }" var="photo">
						<li class="text-truncate">
							<dl>
								<dt><a href="../space/sub01View.jsp?tname=imagesboard&num=${photo.num}"><img src="../Uploads/${photo.sfile }" /></a></dt>
								<dd style="width: 85px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="../space/sub01View.jsp?tname=imagesboard&num=${photo.num}">${photo.title}</a></dd>
							</dl>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div> 
		<%@ include file="../include/quick.jsp"%>
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>