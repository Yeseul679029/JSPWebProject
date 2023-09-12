
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>

<%@ include file="../include/global_head.jsp" %>
<% 
String tname = request.getParameter("tname");
%>

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

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
			
			<!-- 타이틀 제목이미지 -->
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

<!-- 게시물 삭제를 위해 hidden 타입의 <input>태그를 하나 추가한다. 
삭제 버튼 클릭시 일련번호를 서버로 전송한다.   -->
<form name="writeFrm">
<input type="hidden" name="num" value="${dto.num}" />
<input type="hidden" name="tname" value="${dto.tname }" />
<input type="hidden" name="id" value="${dto.id }" />

    <table class="table table-bordered " width="90%">
        <colgroup>
	        <col width="15%"/> <col width="35%"/><col width="15%"/> <col width="*"/>
	    </colgroup>
	
	    <!-- 게시글 정보 -->
	    <tr>
	        <td>번호</td> <td>${ dto.num }</td>
	        <td>작성자</td> <td>${ dto.name }</td>
	    </tr>
	    <tr>
	        <td>작성일</td> <td>${ dto.postdate }</td>
	        <td>조회수</td> <td>${ dto.visitcount }</td>
	    </tr>
	    <tr>
	        <td>제목</td>
	        <td colspan="3">${ dto.title }</td>
	    </tr>
	    <tr>
	        <td>내용</td>
	        <td colspan="3" height="100">
	        	${ dto.content }
	        	<c:if test="${ not empty dto.ofile and isImage eq true }">
	        		<br><img src="../Uploads/${ dto.sfile }" style="max-width:100%;"/>
	        	</c:if>
	        </td>
	    </tr>
	
	    <!-- 첨부파일 -->
	    <tr>
	        <td>첨부파일</td>
	        <td colspan="3">
	            <c:if test="${ not empty dto.ofile }">
	            ${ dto.ofile }
	            <a href="../community/download.do?tname=${dto.tname }&ofile=${ dto.ofile }&sfile=${ dto.sfile }&num=${ dto.num }">
	                [다운로드]
	            </a>
	            </c:if>
	        </td>
	    </tr>	
        <tr>
           <td colspan="4" align="center">
				<!-- 내가 작성한 게시글일때 -->
				<%-- <c:if test="${ not empty UserId and dto.id eq true }"> --%>
				<c:if test="${ dto.id eq UserId }">
				     <button type="button" onclick="location.href='../community/edit.do?tname=${dto.tname }&num=${dto.num }';" 
				    	class="btn btn-outline-primary btn-sm"> 수정하기</button>
				   
				     <button type="button" onclick="location.href='../community/delete.do?tname=${dto.tname }&num=${dto.num }';" 
				     	class="btn btn-outline-danger btn-sm">삭제하기</button> 
				</c:if>
			
                <button type="button" onclick="location.href='List.do?tname=${dto.tname }';" 
               		class="btn btn-outline-dark btn-sm">목록 보기</button>
                
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