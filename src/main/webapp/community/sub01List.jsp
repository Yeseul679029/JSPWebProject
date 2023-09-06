<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/global_head.jsp" %>


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
				<div class="top_title">
					<img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
				</div>
				<div>
<!-- 게시판 들어가는 부분start -->
<!-- 검색 폼 -->
    <form method="get">  
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

    <!-- 목록 테이블 -->
    <table class="table table-bordered table-hover"" width="90%">
        <tr>
            <th width="10%">번호</th>
            <th width="*">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
            <th width="8%">첨부</th>
        </tr>
<c:choose>
	<%-- 게시물이 없을 때 --%>
    <c:when test="${ empty boardLists }">
        <tr>
            <td colspan="6" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
    </c:when> 
    <%-- 게시물이 있을 때 --%>
    <c:otherwise>  
        <c:forEach items="${ boardLists }" var="row" varStatus="loop">    
    	<!-- 
    	확장 for문 형태로 List에 저장된 레코드를 반복 출력한다.  
    	items속성에는 반복가능한 객체를 기술하고, 순서대로 추출된 데이터는 
    	var속성에 지정한 변수로 저장된다. 
    	-->
        <tr align="center">
            <td>  <!-- 번호 -->
                ${ map.totalCount - (((map.pageNum-1) * map.pageSize) 
                	+ loop.index)}
            </td>
            <td align="left">  <!-- 제목(링크) -->
                <a href="../mvcboard/view.do?idx=${ row.idx }">${ row.title }</a> 
            </td> 
            <td>${ row.name }</td>  <!-- 작성자 -->
            <td>${ row.visitcount }</td>  <!-- 조회수 -->
            <td>${ row.postdate }</td>  <!-- 작성일 -->
            <td>  <!-- 첨부 파일 -->
            <!-- 첨부한 파일이 있는 경우에만 다운로드 링크를 출력한다. 
            해당 링크의 파라미터는 원본파일명, 저장된파일명, 일련번호 3개로 
            구성된다. 특히 일련번호는 다운로드 횟수 증가에 사용된다.  -->
            <c:if test="${ not empty row.ofile }">
                <a href="../mvcboard/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">[Down]</a>
            </c:if>
            </td>
        </tr>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
    </table>

    <!-- 하단 메뉴(바로가기, 글쓰기) -->
    <table class="table table-bordered" width="90%">
        <tr align="center">
            <td>
                ${ map.pagingImg }
            </td>
            <td width="100"><button type="button"
                onclick="location.href='../mvcboard/write.do';" class="btn btn-outline-dark btn-sm">글쓰기</button></td>
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
