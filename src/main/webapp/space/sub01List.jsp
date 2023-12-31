<%@page import="utils.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/*tname을 변수로 테이블명을 넘겨준다.
String tname = "Noticeboard";
좀더 효율적으로는 request.getParameter를 사용해 넘겨받는다*/

//String tname = request.getParameter("tname");
%>

<%@ include file="../include/global_head.jsp" %>
<%@ include file="ListCommon.jsp" %>


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

<!-- 검색폼 -->
    <form method="get">  
    <input type="hidden" name="tname" value="<%= tname%>"/>
    <table class="table" width="90%">
    <tr>
        <td align="center">
        <div class="input-group mb-3">
            <select name="searchField" style="width: 100px; text-align: center;"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" class="form-control" placeholder="Search"/>
            <input type="submit" value="검색하기"  class="btn btn-outline-primary btn-sm"/>
       	</div>
        </td>
    </tr>   
    </table>
    </form>
    
    <table class="table table-bordered table-hover"  width="100%">
    <colgroup> 
	    <col width="10%">
	    <col width="50%">
	    <col width="15%">
	    <col width="10%">
	    <col width="12%"> 
    </colgroup>
        <tr class="text-center ">
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>작성일</th>
        </tr>
<%
//컬렉션에 입력된 데이터가 없는지 확인한다. 
if (boardLists.isEmpty()) {
%>
        <tr>
            <td colspan="5" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
<%
}
else {
	/* 출력할 게시물이 있는 경우에는 확장 for문으로 List컬렉션에 저장된
	레코드의 갯수만큼 반복하여 출력한다. */
    int virtualNum = 0;  
  
	
    int countNum = 0;  
    for (BoardDTO dto : boardLists)
    {
    	/* 현재 출력할 게시물의 갯수에 따라 번호가 달라지게 되므로 
    	totalCount를 사용하여 가상번호를 부여한다. */
        //virtualNum = totalCount--;  
    	
    	virtualNum = totalCount - (((pageNum - 1) * pageSize) 
    			+ countNum++);
%>
<tr align="center">
    <td><%= virtualNum %></td>
    <td align="left"> 
    <div class="text-truncate" style="width: 340px; ">
<!--     white-space: nowrap; overflow: hidden; text-overflow: ellipsis; -->
       <a href="sub01View.jsp?tname=<%=tname %>&num=<%= dto.getNum() %>">
        	<%= dto.getTitle() %></a>
    </div>
    </td>
    <td align="center"><%= dto.getName() %></td>
    <td align="center"><%= dto.getVisitcount() %></td>
    <td align="center"><%= dto.getPostdate() %></td>  
</tr>
<%
    }
}
%>
    </table>
    <table  class="table "  width="90%">
    
        <tr align="right">
        	<td align="center">
        	<%= BoardPage.pagingStr(totalCount, pageSize,
                       blockPage,tname, pageNum, request.getRequestURI()) %>
        	</td>
        	<!-- 공지사항게시판일때  -->
        	<% if (tname.equals("noticeboard")){ 
        			/* 로그인되어있고, 관리자아이디로 접속했을때 버튼이 보임 */
        			if (session.getAttribute("UserId") !=null && session.getAttribute("UserId").equals("admin")) { 
        	%>
	        		<td style="width: 11%">
		            	<button type="button" onclick="location.href='sub01Write.jsp?tname=<%=tname %>';" 
		            	class="btn btn-outline-dark btn-sm">글쓰기</button>
	            	</td>
					<%}
       		}else{ %>
			<td style="width: 11%">
	            <button type="button" onclick="location.href='sub01Write.jsp?tname=<%=tname %>';" 
	            	class="btn btn-outline-dark btn-sm">글쓰기</button>
            </td>
			<%} %>
            
        </tr>
    </table>

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