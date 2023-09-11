<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<div class="top_title">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
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
   
<!-- //////////////////////////////////////사진게시판///////////////////////////////////////////// -->   

<div class="container">
<div class="row center" id="productList">
    <%
//컬렉션에 입력된 데이터가 없는지 확인한다. 
if (boardLists.isEmpty()) {
%>
	<table class="table table-bordered table-hover"  width="100%">
        <tr>
            <td colspan="5" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
    </table>
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

	<div class="card m-2 mb-4" style="width:235px">
	<a href="sub01View.jsp?tname=<%=tname %>&num=<%= dto.getNum() %>">
		<img class="card-img-top" src="../Uploads/<%=dto.getSfile()%>" alt="Card image" style="width:100%; height: 200px;">
		<div class="card-body">
			<%-- <h6 class="card-title"><%= dto.getTitle() %></h4>
			<p class="card-text"><%= dto.getName() %></p>
			<p><%= dto.getPostdate() %> <span><%= dto.getVisitcount() %></span></p> --%>
			<ul class="img_board_list " style="padding: 0;">
				<li class="card-title text-truncate"><%= dto.getTitle() %></li>
				<li  class="card-text"><%= dto.getName() %></li>
				<li><%= dto.getPostdate() %> <span><%= dto.getVisitcount() %></span></li>
			</ul>
		</div>
	</a>
	</div>


<%
    }
}
%>
</div>
 </div>   
<!-- //////////////////////////////////////사진게시판///////////////////////////////////////////// -->   
    <!-- 페이지 네이션, 글쓰기버튼 -->
    <table  class="table "  width="90%">
    
        <tr align="right">
        	<td align="center">
        	<%= BoardPage.pagingStr(totalCount, pageSize,
                       blockPage,tname, pageNum, request.getRequestURI()) %>
        	</td>
			<td style="width: 11%">
	            <button type="button" onclick="location.href='sub01Write.jsp?tname=<%=tname %>';" 
	            	class="btn btn-outline-dark btn-sm">글쓰기</button>
            </td>
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
