<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>GYM CARRY : SNS회원가입</title>

<%@ include file="/WEB-INF/views/frame/metaheader.jsp"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="/gym/css/joinlogin/regform.css">
<link rel="stylesheet" href="/gym/css/payment/payment.css">

</head>
<body>
  
	<!-- header -->
	<%@ include file="/WEB-INF/views/frame/header.jsp"%>

	   <!-- Contents -->
   <div class="container_fix container payment_wrap">
      <h1>SNS 회원가입</h1>
      
      <!-- Form 시작 -->
      <form action = <c:url value="" /> method="post">
		
            <div>
			<c:if test="${email eq null}">
               <h3>이메일</h3>
               <p>
                  	이메일 <span style="color: blue">*</span>
               </p>
               <input type="text" class="input_box" placeholder="이메일을 입력해주세요."
                  name="mememail" id = "mememail" required>
			</c:if>	
               
               
               <h3>연락처</h3>
               <p>
                  연락처 <span style="color: blue">*</span>
               </p>
               <input type="text" class="input_box" placeholder="'-'없이 번호만 11자리 형식으로 입력해주세요."
                  name="payphone" id="memphone" required> <br> <br> <br> <br>
               
               
               <h3>닉네임</h3>
               <p>
                  닉네임 <span style="color: blue">*</span>
               </p>
               <input type="text" class="input_box" placeholder="닉네임을 입력해주세요."
                  name="memnick" id = "memnick" required>
               
            <br>
            
            <div class="btn_wrap">
               <input type="submit" value="회원가입">
               <input type="button" value="취소" onclick="kakaoLogout()" id="btn">
            </div>
      </div>
      
      </form>
      <!-- Form 끝 -->
      
      
   </div>

   <!-- Contents end -->


	<%@ include file="/WEB-INF/views/frame/footer.jsp"%>

</body>


<script>

	//모든 공백 체크 정규식
	var empJ = /\s/g;

	// 이름, 이메일, 비밀번호, 비밀번호 확인, 닉네임, 휴대폰 번호, 생일, 성별 순
	
	// 이름에 특수문자 들어가지 않도록 설정
	console.log('이름 도달');
	// 이름 정규식 : 영어, 한글로만 2~6글자 이내 
	var nameJ = /^[가-힣a-zA-Z]{2,6}$/;
	$("#memname").focusout(function() {
		if (nameJ.test($('#memname').val())) {
				console.log(nameJ.test($('#memname').val()));
				$("#namecheck").text('');
		} else {
			$('#namecheck').text('2~6글자의 한글, 영어만 사용 가능합니다.');
			$('#namecheck').css('color', 'red');
		}
		error : console.log('이름 실패');
	});
	
	// 이메일 -> DB다녀와야함 
	console.log('이메일 도달');
	// 이메일 검사 정규식 : 이메일 형식(ㅇㅇㅇ@ㅇㅇㅇ.ㅇㅇ)
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	$("#mememail").focusout(function() {
		if (mailJ.test($('#mememail').val())) {
				console.log(mailJ.test($('#mememail').val()));
				$("#emailcheck").text('');
		// 이메일 이맞으면 ajax 실행		
		$.ajax({
			type : 'POST',
			url : '<c:url value="/member/emailCheck"/>',
			data : { 
				mememail : $(this).val()
			},
			success : function(data) {
				if(data == 0){
					$('#msg').html('사용가능');
					$('#msg').addClass('color_blue');
					$('#msg').removeClass('display_none');
				} else {
					$('#msg').html('사용 불가능');
					$('#msg').addClass('color_red');
					$('#msg').removeClass('display_none');
					$('#mememail').val('');
				}
			}
		});
				
		} else {
			$('#emailcheck').text('이메일 형식으로 입력해주세요.');
			$('#emailcheck').css('color', 'red');
		}
		error : console.log('이메일 실패');
	});
	
	
	// 비밀번호 
	console.log('비번 도달');
	// 비밀번호 정규식 : 영어 대소문자, 숫자로 4~15글자 이내 
	var pwJ = /^[A-Za-z0-9]{4,15}$/;
	$("#mempw").focusout(function() {
		if (pwJ.test($('#mempw').val())) {
				console.log(pwJ.test($('#mempw').val()));
				$("#pwcheck").text('');
		} else {
			$('#pwcheck').text('영어 대, 소문자, 숫자로  4~15글자로 작성해주세요 .');
			$('#pwcheck').css('color', 'red');
		}
		error : console.log('비밀번호 실패');
	});
	
	// 비밀번호 확인 
	$("#mempw2").focusout(function() {
		if ($('#mempw2').val() != $('#mempw').val()) {
				console.log($('#mempw2').val(),$('#mempw').val());
				$("#pwcheck").text('비밀번호가 다릅니다. 다시 입력해주세요.');
				$('#pwcheck').css('color', 'red');
		} else {
			$('#pwcheck').text('');
		} 
		error : console.log('비밀번호 확인 실패');
	});
	
	// 휴대폰 번호
	// 휴대폰 번호 정규식 : 010(필수)+ 숫자로만 8글자
	var phoneJ = /^010([0-9]{8})$/;
	$('#memphone').focusout(function(){
		if(phoneJ.test($('#memphone').val())){
			console.log(phoneJ.test($('#memphone').val()));
			$("#phonecheck").text('');
			// 번호가 맞으면 ajax 실행
			$.ajax({
				type : 'POST',
				url : '<c:url value="/member/phoneCheck"/>',
				data : { 
					memphone : $(this).val()
				},
				success : function(data) {
					if(data == 0){
						$('#msg_phone').html('사용가능');
						$('#msg_phone').addClass('color_blue');
						$('#msg_phone').removeClass('display_none');
					} else {
						$('#msg_phone').html('사용 불가능');
						$('#msg_phone').addClass('color_red');
						$('#msg_phone').removeClass('display_none');
						$('#memphone').val('');
					}
				}
			});
		} else {
			$('#phonecheck').text('휴대폰번호를 확인해주세요.');
			$('#phonecheck').css('color', 'red');
		}
		error : console.log('휴대폰 번호 실패');
	});
	
	
	// 생년월일
	// 생일 정규식 : 숫자로만 8글자 
	var birthJ = /^[0-9]{8}$/;
	$('#membirth').focusout(function(){
		var dateStr = $('#membirth').val();		
	    var year = Number(dateStr.substr(0,4)); // 입력한 값의 0~4자리까지 (연)
	    var month = Number(dateStr.substr(4,2)); // 입력한 값의 4번째 자리부터 2자리 숫자 (월)
	    var day = Number(dateStr.substr(6,2)); // 입력한 값 6번째 자리부터 2자리 숫자 (일)
	    var today = new Date(); // 날짜 변수 선언
	    var yearNow = today.getFullYear(); // 올해 연도 가져옴
	    
	    if (dateStr.length <=8) {
	    	
			// 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환
		    if (1900 > year || year > yearNow){
		    	
		    	$('#birthcheck').text('태어난 연도를 정확하게 입력해주세요.');
				$('#birthcheck').css('color', 'red');
		    	
		    }else if (month < 1 || month > 12) {
		    		
		    	$('#birthcheck').text('태어난 월을 정확하게 입력해주세요.');
				$('#birthcheck').css('color', 'red'); 
		    
		    }else if (day < 1 || day > 31) {
		    	
		    	$('#birthcheck').text('태어난 날짜를 정확하게 입력해주세요.');
				$('#birthcheck').css('color', 'red'); 
		    	
		    }else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
		    	 
		    	$('#birthcheck').text('생년월일을 정확하게 입력해주세요.');
				$('#birthcheck').css('color', 'red'); 
		    	 
		    }else if (month == 2) {
		    	 
		       	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		       	
		     	if (day>29 || (day==29 && !isleap)) {
		     		
		     		$('#birthcheck').text('생년월일을 정확하게 입력해주세요.');
					$('#birthcheck').css('color', 'red'); 
		    	
				}else{
					$('#birthcheck').text('');
					birthJ = true;
				}//end of if (day>29 || (day==29 && !isleap))
		     	
		    }else{
		    	
		    	$('#birthcheck').text(''); 
				birthJ = true;
			}//end of if
			
			}else{
				//1.입력된 생년월일이 8자 초과할때 :  auth:false
				$('#birthcheck').text('8자리 숫자형식으로 정확하게 입력해주세요.');
				$('#birthcheck').css('color', 'red');  
			}
	    
		}); //End of method /*
	
	// 성별 
	$(document).ready(function(){
		$('#gendercheck').focusout(function(){
			invalidItem();
		});
		function invalidItem(){
			if($("input[name=memgender]:radio:checked").length < 1){
				$('#gendercheck').text('성별을 선택해주세요.');
				$('#gendercheck').css('color', 'red');  
			} else {
				$('#gendercheck').text('');
			}
		}
	});

	var nickJ = /^[가-힣a-zA-Z]{2,6}$/;
	$("#memnick").focusout(function() {
		if (nickJ.test($('#memnick').val())) {
				console.log(nickJ.test($('#memnick').val()));
				$("#nickcheck").text('');
				// 닉네임이맞으면 ajax 실행
				$.ajax({
					type : 'POST',
					url : '<c:url value="/member/nickCheck"/>',
					data : { 
						memnick : $(this).val()
					},
					success : function(data) {
						if(data == 0){
							$('#msg_nick').html('사용가능');
							$('#msg_nick').addClass('color_blue');
							$('#msg_nick').removeClass('display_none');
						} else {
							$('#msg_nick').html('사용 불가능');
							$('#msg_nick').addClass('color_red');
							$('#msg_nick').removeClass('display_none');
							$('#memnick').val('');
						}
						
					}
				});
				
		} else {
			$('#nickcheck').text('2~6글자의 한글, 영어만 사용 가능합니다.');
			$('#nickcheck').css('color', 'red');
		}
		error : console.log('닉 실패');
	});	
		
</script>
<!-- alert('입력해주신 이메일로 인증 메일이 발송되었습니다. 이메일 인증을 완료해주세요.') -->

<!-- 회원가입 이메일,닉네임,핸드폰 중복체크 ajax -->
<script>
$('#mememail, #memnick, #memphone').focusin(function() {
	$('#msg').addClass('display_none');
	$('#msg').removeClass('color_blue');
	$('#msg').removeClass('color_red');
	$('#msg').val('');
	$('#msg_nick').addClass('display_none');
	$('#msg_nick').removeClass('color_blue');
	$('#msg_nick').removeClass('color_red');
	$('#msg_phone').addClass('display_none');
	$('#msg_phone').removeClass('color_blue');
	$('#msg_phone').removeClass('color_red');
});
	
</script>

</html>





