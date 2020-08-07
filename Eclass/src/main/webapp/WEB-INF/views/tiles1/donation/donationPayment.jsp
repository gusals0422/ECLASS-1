<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>donationPayment</title>
<style type="text/css">
    .Mycontainer{
        border: solid 1px #ccc;
        width: 1080px;
        margin: 0 auto;
        /*background-color: #E5E5E5;*/
        font-family : noto sans, sans-serif, malgun gothic;
    }     
    div.contentLine{
        padding-top: 10px;
        width: 1080px;
        border-bottom: solid 2px #00BCD4;         
    }
    
    div#header_div{
		text-align: center;
	    font-size : 14px;
    	color: #999999;  /* 회색 */
	}		
	
    /* == 결제 정보 == */
    #payment_table{
        width: 800px;
        border: solid 1px #ccc;
        margin: 0 auto;
    }
    #paymentTotal_table{
        width: 260px;
        text-align: center;
        border: solid 1px #ccc;
        margin: 10px 0;	
    }
    th, td{
		height : 50px;
		vertical-align: middle;	
		padding : 20px;		
	}
    th{
        border: solid 1px #ccc;
        width: 200px;	
        text-align: left;
    }
    td{
        /*border: solid 0px pink;*/
        border: solid 1px #ccc;
        font-size: 10pt;          
    }
    .pointUseInput{
        margin-bottom: 8px;
    }
    
    /* 항목 타이틀 */
	.payment_title{
		width:90px;
		text-align: left;
		padding-top : 60px;
        padding-left: 7px;
		padding-bottom : 3px;
		border-bottom: solid 2.3px #00BCD4; 
		font-weight: 700;
		font-size: 15pt;
        color: #00BCD4;
	}
    
	/* 결제안내 설명 관련 정보 */
    .paymentExp{
        font-size: 10pt;
        padding: 5px 0;
    }
    input[type=text]{
        width: 100px;
        border: solid 1px #bbb;
        border-radius: 2px;
    }
    input[type=checkbox]{
        width: 22px;
        border: solid 1px #bbb;
     	border-radius: 2px;
    }
    .smalltext{
        color: #333;
        font-size: 9pt;
        font-weight: 600
    }
    a{
		text-decoration: none !important;
	}
	a:hover {
		text-decoration: none !important;
        color: #00BCD4;
	}	
    #btn_payment{
		width: 200px;
		height: 48px;
    	background-color: #00BCD4;
	    color: #fff;
        border: none;
        font-size: 13pt;
        border-radius: 3px;
        margin-top: 40px;
        margin-bottom: 80px;
	}       
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
	var pointUseInput = false; //포인트 금액 확인 
	
    $(document).ready(function(){
       // == 포인트 기입시 유효성 검사   
       $("#pointUseInput").keyup(function(event){            
            //1) 숫자만 입력(숫자이외의 글자를 치면 아예 못치게 차단)
            var keycode = event.keyCode;
    	 
            if( !((48 <= keycode && keycode<=57) || (96<=keycode && keycode<=105)|| (keycode==8))){
               var word = $(this).val().length;
               var keyValue = $(this).val().substring(0,word-1);
               $(this).val(keyValue);
            }             
            pointUseInput = true;                        
       });// end of $("#pointUseInput").keyup(function(event){})--------

       //만약 현재 포인트보다 크게 기입 했을 시 (x) --> 유효성 검사로 !!!!!!!!!!!!            
       //1. 포인트 숫자 아닐 시 -> 알람 
       //2. 빈칸 입력 시 -> 알람 
       //3. 포인트보다 크게 기입 했을 시 (x) --> 알람
       
       $("#pointUseInput").blur(function(){// 포인트 input 태그에서 변화가 일어났을때
			
			$(this).val($(this).val().replace(/[^0-9]/g,"")); // 숫자만 입력
			
			var sumprice = $(".sumprice").text(); // 결제금액
			var allPoint = $(".allPoint").text(); // 사용가능 포인트			
			var point = $("#point").val(); // 사용하고 싶은 포인트
					
			if(allPoint-point<0){
				alert('사용가능한 적립금을 확인하세요.');
				point = 0;
				$(".point").text(0);
				$("#point").val(0);
				
				var lastPrice = $(".lastPrice").val();
				lastPrice = sumprice-point;
				$(".lastPrice").text(lastPrice);
				
				$("input:hidden[name=ordersumtotalPrice]").val(lastPrice);
				$("input:hidden[name=orderUsePoint]").val(point);
			}			 
			else {
				$(".point").text(point);
				 				
				var lastPrice = $(".lastPrice").val();
				lastPrice = sumprice-point;
				$(".lastPrice").text(lastPrice);
				
				$("input:hidden[name=ordersumtotalPrice]").val(lastPrice);
				$("input:hidden[name=orderUsePoint]").val(point);
			}
				 
			if(lastPrice<0){
				alert('총 결제금액 만큼만 적립금을 사용할 수 있습니다.')
				 
				point = 0;
				$(".point").text(0);
				$("#point").val(0);
					
				var lastPrice = $(".lastPrice").val();
				lastPrice = sumprice-point;
				$(".lastPrice").text(lastPrice);
						
				$("input:hidden[name=ordersumtotalPrice]").val(lastPrice);
				$("input:hidden[name=orderUsePoint]").val(point);
			}
			
		}); // end of $("#pointUseInput").blur(function(){}) -------------
		
       
       // == 후원금액 
       $("#paymentInput").keyup(function(event){            
           //1) 숫자만 입력(숫자이외의 글자를 치면 아예 못치게 차단)
           var keycode = event.keyCode;
   	 
           if( !((48 <= keycode && keycode<=57) || (96<=keycode && keycode<=105)|| (keycode==8))){
              var word = $(this).val().length;
              var keyValue = $(this).val().substring(0,word-1);  
              //콤마 추가!! 
              $(this).val(keyValue);  
           }   
           
       });// end of $("#paymentInput").keyup(function(event){})--------
           		
       addComma($("#paymentInput").val());
       
       
       
       
    });//end of  $(document).ready(function(){}) ---------
	
    //숫자에 콤마 붙이는 함수  
    function addComma(num) {
  	 	var regexp = /\B(?=(\d{3})+(?!\d))/g;
  	  	return num.toString().replace(regexp, ',');
  	}
    // 유효성 검사 
    function goCheck(){	
    	
    	//== 후원금액 기입여부 	
		if($("#paymentInput").val().trim()==""){
			alert("후원 금액을 기입해주세요");
			return;
		}						
		
    	//포인트 유효성검사 
		if(!pointUseInput){
			alert("포인트금액을 정확히 입력해주세요");
			return;
		}
		
		//약관 동의
		if(!($("input:checkbox[id=agreeCheck]").prop('checked'))){
			alert('약관에 동의해주세요.');			
			return;
	 	}		
		
		func_pop();		
	};
    
    // 아임포트 API 
	function func_pop(){
		
		window.name="parentFrm";
		sessionStorage.setItem("recieve", $("#totalPrice").val());	
		console.log(sessionStorage.getItem("recieve"));
		var win = window.open("<%=ctxPath%>/pay.do?pay="+pay,"childFrm","left=300px, top=100px, width=800px, height=700px");
	}
	//결제 완료시 
	function goSubmit(){
		
		 var frm = document.paymentFrm;
		 frm.method="POST";
		 frm.action= "<%= ctxPath%>/donation/donationPayment.up";
		 frm.submit();
	}
	
   //real 결제 -> 총금액에서 차감
   // 1. 결제테이블에 순결제금액(insert) 2. 멤버 테이블에 포인트 사용한거 (update) 3. 순결제금액 10% 포인트 add (update)
   //후원 금액보여줄 때 -> 결제금액 + 사용포인트(서포터에 보여줄 때) 
   
</script>
</head>
<body>
	<div class="Mycontainer">
        <h2  style="margin-bottom: 0.5px; color:#00BCD4; text-align: center; font-weight: 550;">후원결제 페이지</h2>
        <div id="header_div" style="margin-top: 8px; color: #999; text-align: center; font-size: 19.5pt">고아원 아이들을 위한 교육후원!</div>
        <div class="contentLine" style="padding-top: 10px;" align="center"></div>
                
        <!-- 결제 정보 -->
        <form name="paymentFrm">
        <div class="payment_title">결제정보</div>
        <table id="payment_table">
                <tr>
                    <th>포인트 금액</th>
                    <td> 
                        <div class="paymentExp">현재 포인트 보유액 <fmt:formatNumber value="${sessionScope.loginuser.point}" pattern="###,###"/>원</div>
                        <input class="pointUseInput" type="text" id="pointUseInput" name="pointUseInput" value="" required="required" maxlength="11">포인트를 사용하겠습니다
                    </td>
                </tr>
                <tr>
                    <th>후원 금액</th>
                    <td> 
                        <input type="text" id="paymentInput" name="paymentInput" value="" required="required" maxlength="11">원을 후원하겠습니다
                        <span class="smalltext">(후원금액의 10%는 포인트로 적립됩니다)</span>
                    </td>
                </tr>


                <tr>
                    <th>공개 여부</th>
                    <td> 
                        <div class="paymentExp">서포터 목록에 서포터 이름과 후원금액이 공개됩니다</div>
                        <input type="checkbox" id="nameCheck" name="nameCheck" value="1">이름 비공개 &nbsp;&nbsp;
                        <input type="checkbox" id="priceCheck" name="priceCheck" value="1">금액 비공개
                    </td>
                </tr>
                <tr style="height :50px;">
                    <th>결제 내역</th>
                    <td> 
                        <div>
                        <table id="paymentTotal_table">
                        <tr style="background-color: #f2f2f2">
                            <th style="text-align: center; height : 25px;">후원금액</th>
                            <th style="text-align: center; height : 25px;">포인트</th>
                            <th style="text-align: center; height : 25px;">총 결제금액</th>
                        </tr>
                        <tr>
                            <td style="height : 40px;">{payment}{10,000}원</td>
                            <td style="height : 40px;">{point}{3,000}점</td>
                            <td style="height : 40px;">{payment+point}{7,000}원</td>
                        </tr>                            
                        </table>
                        </div>
                    </td>
                </tr>
            </table>

            <div class="payment_title" style="margin-top:40px;">동의사항</div>
            <table id="payment_table">
            
                <tr>
                    <td colspan="2" style="height:25px;">
                        <label for="agreeCheck" style="margin:0;">	
                        <input type="checkbox" name="agreeCheck" id="agreeCheck" style="margin:10px 1px 10px 0;"> 결제 진행 필수 동의</label>	
                        <span style="padding-left:20px;">결제대행 서비스 약관 동의<span class="agree_sub">(필수)</span></span>
                        <div style="padding-left:6px; color:dimgrey; font-weight: 500;">※ 결제하신 금액은 별도 수수료 없이 후원을 진행하는 후원자에게 100% 전달됩니다.</div>
                    </td>
                </tr>
            </table>
            
            <input type="hidden" name="fk_donSeq" value="${donSeq}" />
			<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
			<input type="hidden" name="name" value="${sessionScope.loginuser.name}" />
				
        <!-- 7. 전송 버튼 -->					
        <div style="padding:30px 0 14px;" align="center">
            <input type="button" style="float:none" value="결제하기" id="btn_payment" onclick="goCheck()" >
        </div>	
		</form>        
    </div>
      
</body>
</html>