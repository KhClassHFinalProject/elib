<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
	<link rel="stylesheet" href="/lee/resources/bootstrapk/css/bootstrap.min.css">
	<style type="text/css">
		#control{
			text-align: center;
			margin-top: 30px;
			margin-bottom: 30px;
		}
		#myiconmenu{
			z-index: 10;
		}
		#Inconfig{
			cursor: pointer;
		}
		#zoomDiv>button, #zoomDiv>button:HOVER{
			opacity: 1
		}
	</style>
    
	<script type="text/javascript" src="/lee/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="/lee/resources/bootstrapk/js/bootstrap.min.js"></script>
	
	<!-- booklet -->
	<link rel="stylesheet" href="/lee/resources/eViewer/booklet/jquery.booklet.latest.css" type="text/css" media="screen, projection, tv">
	<script type="text/javascript" src="/lee/resources/eViewer/booklet/jquery-ui-1.10.4.min.js"></script>
	<script type="text/javascript" src="/lee/resources/eViewer/booklet/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/lee/resources/eViewer/booklet/jquery.booklet.latest.js"></script>
	
	<!-- left -->
	<link rel="stylesheet" href="/lee/resources/eViewer/leftSide/font-awesome.css">
	<link rel="stylesheet" href="/lee/resources/eViewer/leftSide/iconmenu.css">
	<script type="text/javascript" src="/lee/resources/eViewer/leftSide/changeiconmenu.js"></script>
	
	<!-- right -->
	<link rel="stylesheet" href="/lee/resources/eViewer/jPushMenu/jPushMenu.css?v=2" type="text/css" >
	<script type="text/javascript" src="/lee/resources/eViewer/jPushMenu/jPushMenu.js"></script>
	
	<!-- zoom -->
	<script type="text/javascript" src="/lee/resources/eViewer/wheelzoom.js"></script>
	
	<script type="text/javascript">
		$(function() {
			//single book
			$('#mybook').booklet(
				{
					width: "1160px"
					, height: "760px"
					, closed: true 				/*표지 1장?*/
					, autoCenter: true		/*표지 일경우 중앙으로*/
					, arrows: true
					, arrowsHide: true
					, hash: true					/*#/page/1*/
					, name : "test"
					, next: "#customNext"
					, prev: "#customPrev"
					, menu: "#customMenu"
					, auto: true
					, play: "#customPlay"
					, pause: "#customPause"
					, delay: 1000
					/* , startingPage : 10 시작 페이지*/
				}
			);
			$("#customPause").click().css("display", "none");
			
			$("#customPause").click(
				function() {
					$("#customPlay").css("display", "inline-block");
					$("#customPause").css("display", "none");
				}
			);
			$("#customPlay").click(
				function() {
					$("#customPlay").css("display", "none");
					$("#customPause").css("display", "inline-block");
				}
			);
			
			$("#customStart").click(
				function() {
					location.replace("#/page/1");
				}
			);
			$("#customEnd").click(
				function() {
					alert("할수있음");
					location.href="#/page/3";
				}
			);
			
			/*북마크 만들기*/
			//ajax부분
			function bookMakerLi(endMaker) {
				$("#bookMarkUl").html("");
				var bookMarkerList="";
				for(var i=1 ; i<=endMaker ; i++){
					bookMarkerList+="<a class='btn btn-default'  href='#/bookmark/" + i + " role='button'>북마크 " + i +"</a>"
				}
				$("#bookMarkUl").html(bookMarkerList);
			}
			bookMakerLi(2);
			$("#bookmarker").click(
				function() {
					alert("아직 안되지롱!!");
					 var result = Math.floor(Math.random() * 10) + 1;
					bookMakerLi(result);
				}
			);
			
			/*휠 줌인 줌아웃*/
			wheelzoom(document.querySelectorAll("img"), {zoom:0.05});
			
			/*오른쪽 메뉴*/
			$(".toggle-menu").jPushMenu();
			
			/*오른쪽 메뉴 열렸을때 h3*/
			$("#Inconfig").click(
				function() {
					$("#config").click();
				}
			);
			
			/*오른쪽 메뉴 : 쪽수 입력 후 엔터시 이동*/
			$("#pagego").keypress(function(e) { 
			    if (e.keyCode == 13){
			    	$("#pagegoSub").click();
			    }
			});
			
			/*오른쪽 메뉴 : 쪽수 입력 후 클릭시 이동*/
			$("#pagegoSub").click(
				function() {
					var page=$("#pagego").val();
					if(page%2==0){
						page=parseInt(page)+1;
					}
					location.href="#/page/" + page; 
				}
			);
			
			/*시간설정*/
			$("#timeSelect>button").click(
				function() {
					$("#timeSelect>button").removeClass("btn-primary").addClass("btn-default");
					$(this).removeClass("btn-default").addClass("btn-primary");
					var settingTime=$(this).text().substr(0, 1)*1000;
					$('#mybook').booklet( "option", "delay", settingTime);
					var playDisplay=$("#customPlay").css("display");
					if(playDisplay=="inline-block"){
						/*일시정지*/
						$("#customPause").click();
					}
					else if (playDisplay=="none") {
						/*사용중*/
					}
				}
			);
			
		}); // 기본 함수
		
		/*왼쪽 메뉴바*/
		ddiconmenu.docinit(
			{
				menuid : "myiconmenu"
				, easing : "easeInOutCirc"
				, dur : 500
				, tigger : " mouseover"
			}
		);
		
	    $(window).on("beforeunload"
	    	, function(){
	        	$("#close").text("??");
	        	return null;
	    	}
	    );
	</script>
	
</head>
<body>
	<div id="control">
		<button type="button" class="btn btn-default" name="customStart" id="customStart">
			<span class="glyphicon glyphicon-step-backward" aria-hidden="true">맨앞</span>
		</button>
		<button type="button" class="btn btn-default" name="customPrev" id="customPrev">
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true">이전</span>
		</button>

		<button type="button" class="btn btn-default" name="customPlay" id="customPlay">
			<span class="glyphicon glyphicon-play" aria-hidden="true"></span>	<!-- 재생 -->
		</button>
		<button type="button" class="btn btn-default" name="customPause" id="customPause">
			<span class="glyphicon glyphicon-pause" aria-hidden="true"></span>	<!-- 일시정지 -->
		</button>
		<!-- 자동 -->
		
		<button type="button" class="btn btn-default" name="customNext" id="customNext">
			다음<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
		<button type="button" class="btn btn-default" name="customEnd" id="customEnd">
			맨뒤<span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>
		</button>
		
		<button type="button" class="btn btn-default toggle-menu menu-right" name="config" id="config">설정</button>
	</div>
	
	<div id="mybook">
		<div><img src="/lee/resources/ebook/testImg/pages/01.jpg"></div>
		<div><img src="/lee/resources/ebook/testImg/pages/02.jpg"></div>
		<div><img src="/lee/resources/ebook/testImg/pages/03.jpg"></div>
		<div><img src="/lee/resources/ebook/testImg/pages/04.jpg"></div>
		<div><img src="/lee/resources/ebook/testImg/pages/05.jpg"></div>
		<div><img src="/lee/resources/ebook/testImg/pages/06.jpg"></div>
		<div><img src="/lee/resources/ebook/testImg/pages/01.jpg"></div>
	</div>
	
	<!-- Main Icon Menu -->
	<!-- <ul id="myiconmenu" class="iconmenu">
		<li><a class="" href="#" rel="csslibrary" title="목록"><span class="glyphicon glyphicon-list" aria-hidden="true"></span></a></li>
		<li><a class="" href="#" rel="ddcontentarea" title="북마크"><span class="glyphicon glyphicon-bookmark" aria-hidden="true"></span></a></li>
	</ul>

	CSS Library sub menu
	<div id="csslibrary" class="iconsubmenu dropdownmenu">
		<ul class="ulmenu">
			<li><a href="#/page/1">시작페이지</a></li>
			<li><a href="#/chapter1">Chapter 1</a></li>
			<li><a href="#/chapter2">Chapter 2</a></li>
			<li><a href="#/chapter3">Chapter 3</a></li>
			<li><a href="#/chapter4">Chapter 4</a></li>
			<li><a href="#/chapter5">Chapter 5</a></li>
			<li><a href="#/page/7">마지막페이지</a></li>
		</ul>
	</div>

	General Content sub menu
	<div id="ddcontentarea" class="iconsubmenu mixedcontent">
		<p style="margin:5px 0 10px 0"><button class="btn btn-default" type="button" name="bookmarker" id="bookmarker">북마크 등록</button></p>
		
		<div class="column" id="bookMarkUl">
			<ul id="bookMarkUl">
				<li><a href="#/bookmark/1">북마크 1</a></li>
				<li><a href="#/bookmark/2">북마크 2</a></li>
				<li><a href="#/bookmark/3">북마크 3</a></li>
				<li><a href="#/bookmark/3">북마크 4</a></li>
				<li><a href="#/bookmark/3">북마크 5</a></li>
				<li><a href="#/bookmark/3">북마크 6</a></li>
				<li><a href="#/bookmark/3">북마크 7</a></li>
				<li><a href="#/bookmark/3">북마크 8</a></li>
			</ul>
		</div>
	</div> -->
	

	<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right">
		<h3 class="text-center" id="Inconfig">설정</h3>
		<div class="text-center" id="zoomDiv">
			<button class="btn btn-default" type="button" disabled="disabled"><span class="glyphicon glyphicon-zoom-in" aria-hidden="true"> : 휠 업</span></button>
			<button class="btn btn-default" type="button" disabled="disabled"><span class="glyphicon glyphicon-zoom-out" aria-hidden="true"> : 휠 다운</span></button>
		</div>
		<div class="text-center" id="timeSelect">
			<button class="btn btn-primary" type="button"><span class="glyphicon glyphicon-forward" aria-hidden="true">1초</span></button>
			<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-forward" aria-hidden="true">3초</span></button>
			<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-forward" aria-hidden="true">5초</span></button>
		</div>
		<div class="input-group text-center">
			<input type="text" class="form-control" name="pagego" id="pagego">
			<span class="input-group-btn">
				<button class="btn btn-default" type="button" name="pagegoSub" id="pagegoSub">이동</button>
			</span>
		 </div>
		 <div class="text-center" id="bookMarkUl">
		 </div>
	</nav>

</body>
</html>