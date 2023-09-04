<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function formValidate(frm){
    /*
    <form>에서 this를 통해 전달한 인수는 다음과 같다. 
    1. document.forms[0];
    2. document.myform;
    즉 <form> 태그의 DOM 객체이다. 
    */
    
    //아이디에 입력한 값이 있는지 확인한다. 
    if(frm.id.value==''){
        alert("아이디를 입력해주세요.");
        frm.id.focus();
        return false;
    }
    
    console.log('id=',frm.id.value);
    //아이디는 8~12자로 입력되었는지 검증
    if(!(frm.id.value.length>=8 && frm.id.value.length<=12)){
        //8~12자 사이가 아니라면..
        alert("아이디는 8~12자 사이만 가능합니다.");
        //입력된 값을 지우고 포커스를 이동한다. 
        frm.id.value = '';
        frm.id.focus();
        return false;
    }

    //아이디는 숫자로 시작할 수 없음
    /* 0과 9의 아스키코드값은 각각 48, 57이므로 아이디의 첫글자가
    만약 이 사이에 존재한다면 사용할 수 없는 아이디로 판단할 수 있다. */
    //입력한 아이디와 첫번째 문자, 아스키코드를 콘솔에서 확인한다. 
    console.log(frm.id.value, frm.id.value[0], 
        frm.id.value.charCodeAt(0));
    if(frm.id.value[0].charCodeAt(0)>=48 &&
            frm.id.value.charCodeAt(0)<=57){
        alert('아이디는 숫자로 시작할 수 없습니다.');
        frm.id.value = '';
        frm.id.focus();
        return false;
    }

    //아이디는 영문+숫자의 조합으로만 사용할 수 있다. 
    /* 아이디를 구성하는 각 문자가 소문자 a~z, 대문자 A~Z, 숫자 0~9
    사이가 아니라면 잘못된 문자가 포함된 경우이므로 전송을 중단한다.*/

    //아이디의 길이만큼 반복한다. 
    for(var i=0 ; i<frm.id.value.length ; i++){
        if(!((frm.id.value[i]>='a' && frm.id.value[i]<='z') ||
            (frm.id.value[i]>='A' && frm.id.value[i]<='Z') ||
            (frm.id.value[i]>='0' && frm.id.value[i]<='9'))){
            alert("아이디는 영문 및 숫자의 조합만 가능합니다.");
            frm.id.value='';
            frm.id.focus();
            return false; 
        }
    }


    //패스워드 입력 확인
    if(frm.pass1.value==''){
        alert("패스워드를 입력해주세요.");frm.pass1.focus();return false;
    }
    if(frm.pass2.value==''){
        alert("패스워드 확인을 입력해주세요.");frm.pass2.focus();return false;
    }
    //만약 입력한 패스워드가 일치하지 않는다면..
    if(frm.pass1.value!=frm.pass2.value){
        alert('패스워드가 일치하지 않습니다. 다시 입력해주세요.');
        //사용자가 입력한 패스워드를 지운다. 
        frm.pass1.value = '';
        frm.pass2.value = '';
        //입력상자로 포커싱 한다. 
        frm.pass1.focus();
        return false;
    }
    
    //이름입력확인
    if(frm.name.value==''){
        alert("이름을 입력해주세요.");
        frm.name.focus();
        return false;
    }
    //전화번호입력확인
    if((frm.tel1.value=='' || frm.tel2.value=='')&&(frm.tel1.value=='' || frm.tel3.value=='')){
    	alert("전화번호를 입력해주세요.");
    	frm.tel1.focus();
    	return false;
    }
    if(frm.tel3.value==''){
    	alert("전화번호를 입력해주세요.");
    	frm.tel3.focus();
    	return false;
    }
    
  	//휴대번호입력확인
    if((frm.mobile1.value=='' || frm.mobile2.value=='')&&(frm.mobile2.value=='' || frm.mobile3.value=='')){
    	alert("핸드폰번호를 입력해주세요.");
    	frm.mobile1.focus();
    	return false;
    }
    if(frm.mobile3.value==''){
    	alert("핸드폰번호를 입력해주세요.");
    	frm.mobile3.focus();
    	return false;
    }
    
  	//이메일 입력 확인
    if(frm.email1.value==''){
        alert("이메일을 입력해주세요.");
        frm.email1.focus();
        return false;
    }
    if(frm.email2.value==''){
        alert("도메인을 선택해주세요.");
        frm.email_domain.focus();
        return false;
    }
  	
  	//주소 입력 확인
    if(frm.zipcode.value==''){
        alert("우편번호를 입력해주세요.");
        frm.zipcode.focus();
        return false;
    }
    if(frm.addr2.value==''){
        alert("상세주소를 입력해주세요.");
        frm.addr2.focus();
        return false;
    }
    
   	//폼작성후 넘어가지않게해준다.
    //return false;
}

function inputEmail(frm){
    //이메일의 도메인을 선택한 경우의 value값 가져오기 
    var choiceDomain = frm.email_domain.value;
    if(choiceDomain==''){//--선택-- 부분을 선택한 경우..
        //입력한 모든 값을 지운다. 
        frm.email1.value = '';
        frm.email2.value = '';
        //아이디 입력란으로 포커싱한다.
        frm.email1.focus();
    }
    else if(choiceDomain=='직접입력'){//직접입력을 선택한 경우..
        //기존에 입력된 값을 지운다.
        frm.email2.value = '';
        //readonly 속성을 해제한다.
        frm.email2.readOnly = false;
        //포커스를 이동한다. 
        frm.email2.focus();
    }
    else{//포털 도메인을 선택한 경우..
        //선택한 도메인을 입력한다. 
        frm.email2.value = choiceDomain;
        //입력된 값을 수정할 수 없도록 readonly속성을 추가한다. 
        frm.email2.readOnly = true;
    }
}   
/* thisObj 입력상자에 inputLen 길이의 텍스트를 입력하면 nextName
엘리먼트로 포커스를 이동시킨다. */ 
function focusMove(thisObj, nextName, inputLen){
    //입력한 문자의 길이
    var strLen = thisObj.value.length;
    //제한 길이가 넘어가는지 확인 
    if(strLen >= inputLen){
        //alert("포커스 이동");
        /*
        eval() 함수는 문자열로 주어진 인수를 Javascript코드로 해석하여
        실행한다. 
        document.myform. => 문서객체를 이용한 DOM(form태그를 가리킴)
        nextName => 문자열이 전달된 매개변수
        객체와 문자열을 바로 연결하면 에러가 발생하므로 
        객체를 문자열로 변경한 후 eval()함수를 통해 JS코드로 재변환한다.
        */
        eval('document.membership.'+ nextName).focus();
    }  
} 

//아이디 중복확인 
function idCheck(fn){
	
	console.log('id=',fn.id.value);
    if(fn.id.value==''){
        alert("아이디를 입력후 중복확인 해주세요.");
        fn.id.focus();
    }
    else{
        //아이디 중복확인 창을 띄울때 입력한 아이디를 쿼리스트링으로 
        //넘겨준다. 
        window.open('RegiIdOverlap.jsp?id='+fn.id.value,
            'idOver', 
            'width=500,height=300');
        //입력한 아이디를 수정할 수 없도록 속성을 추가한다. 
        fn.id.readOnly = true;
    }
}

function postOpen(){    
    new daum.Postcode({
        oncomplete: function(data) {
            console.log(data);
            console.log(data.zonecode);
            console.log(data.address);
            
            let frm = document.membership;
            frm.zipcode.value = data.zonecode;
            frm.addr1.value = data.address;
            frm.addr2.focus();
        }
    }).open();
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
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				
				
				<span style="color: red; font-size: 1.2em;"> 
			        <%= request.getAttribute("MemberErrMsg") == null ?
			                "" : request.getAttribute("LoginErrMsg") %>
			    </span>
			    
			    <%
			    /* session영역에 해당 속성값이 있는지 확인한다. 즉, session영역에
			    데이터가 없다면 로그아웃 상태이므로 로그인 폼을 웹브라우저에 출력한다. */
			    if (session.getAttribute("UserId") == null) { 
			    %>
				<form name="membership" action="registAction.jsp" method="post" onsubmit="return formValidate(this);">
					<table cellpadding="0" cellspacing="0" border="0" class="join_box">
						<colgroup>
							<col width="80px;" />
							<col width="*" />
						</colgroup>
						<tr>
							<th><img src="../images/join_tit002.gif" alt="아이디"/></th>
							<td>
								<input type="text" name="id" value="" class="join_input" />&nbsp;
								<img src="../images/btn_idcheck.gif" alt="중복확인" onclick="idCheck(membership);" style="cursor:hand;"/>&nbsp;&nbsp;
<!-- 							<a onclick="idCheck(this.form);" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp; -->
								<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span>
							</td>
						</tr>
						<tr>
							<th><img src="../images/join_tit003.gif" alt="비밀번호"/></th>
							<td><input type="password" name="pass1" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td> 
						</tr>
						<tr>
							<th><img src="../images/join_tit04.gif" alt="비밀번호확인"/></th>
							<td><input type="password" name="pass2" value="" class="join_input" /></td>
						</tr>
						
						<tr>
							<th><img src="../images/join_tit001.gif" alt="이름"/></th>
							<td><input type="text" name="name" value="" class="join_input" /></td>
						</tr>
	
						<tr>
							<th><img src="../images/join_tit06.gif" alt="전화번호"/></th>
							<td>
								<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" onkeyup="focusMove(this,'tel2',3);"/> - 
								<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" onkeyup="focusMove(this,'tel3',4);"/> - 
								<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
							</td>
						</tr>
						<tr>
							<th><img src="../images/join_tit07.gif" alt="핸드폰번호"/></th>
							<td>
								<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" onkeyup="focusMove(this,'mobile2',3);"/> - 
								<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" onkeyup="focusMove(this,'mobile3',4);"/> - 
								<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th><img src="../images/join_tit08.gif" alt="이메일"/></th>
							<td>
	 							<!-- 이메일도메인 선택 -->
								<input type="text" name="email1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
								<input type="text" name="email2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly/>
								<select name="email_domain" onchange="inputEmail(this.form);" class="pass" id="email_domain" >
									<option value="" selected >선택해주세요</option>
									<option value="직접입력" >직접입력</option>
									<option value="naver.com" >naver.com</option>
									<option value="nate.com" >nate.com</option>
									<option value="hanmail.net" >hanmail.net</option>
									<option value="gmail.com" >gmail.com</option>
								</select>
		 
								<label><input type="checkbox" name="open_email" value="Y"><span>이메일 수신동의</span></label>
							</td>
						</tr>
						<tr>
							<th><img src="../images/join_tit09.gif" alt="주소"/></th>
							<td>
							<input type="text" name="zipcode" value=""  class="join_input" style="width:70px;" />
							<!--<input type="text" name="zipcode" maxlength="10" value="" class="userInput w50" />  -->
							<button type="button" style="width:110px;"
								class="btn_search" onClick="postOpen();" title="새 창으로 열림" >우편번호검색</button>
							<br/>
							
							<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
							<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
							
							</td>
						</tr>
					</table>
					
					<!-- 이미지 파일로 submit이 되어야한다. -->
					<p style="text-align:center; margin-bottom:20px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
					
				</form>
				
				<%
				/* 회원가입 성공했을때  */
			    } else {  
			    	//로그인이 된 상태에서는 회원의 이름과 로그아웃 버튼을 출력한다.
			    %>
			        <%= session.getAttribute("UserName") %>님 회원가입에 성공하셨습니다.<br />
			        <a href="login.jsp">[로그인하러가기]</a>
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
