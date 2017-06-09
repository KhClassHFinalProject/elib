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
		.ebookIcon{
		 	font-size: xx-large;
		 	padding-top: 15%;
		 	padding-left: 20%;
		}
		.ebookIcon:nth-child(1) a:nth-child(2){
			margin-left: 30%;
		}
		.ebookIcon:nth-child(2) a:nth-child(2){
			margin-left: 32%;
		}
		.lineIcone{
		 	text-align: center;
		}
		.lineIcone, .moblieLine{
			color: #0bd392;
		}
		.lineIcone:HOVER, .moblieLine:HOVER{
			color: #1aa4ac;
		}
		@media (max-width: 768px) {
			.wideMenu{
				display: none;
			}
			.mobileMenu{
				padding-top: 5%;
			}
			.mobileIcon{
				font-size: medium;
				text-align: center;
			}
			.moblieLine{
				text-align: center;
			}
		}
		@media (min-width: 768px) {
			.mobileMenu{
				display: none;
			}
		}
	</style>
    
	<script type="text/javascript" src="/lee/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="/lee/resources/bootstrapk/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	$(function() {
		$("#ebList").removeClass("has-sub");
		$("#ebList>ul").remove();
		$("#emList").removeClass("has-sub");
		$("#emList>ul").remove();
		$("#abList").removeClass("has-sub");
		$("#abList>ul").remove();
		$("#eduList").removeClass("has-sub");
		$("#eduList>ul").remove();
	})
	</script>
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	<div class="row">
		<div class="col-md-3">
			<jsp:include page="/WEB-INF/views/ebook/elibSide.jsp"></jsp:include>
		</div>
		
		<div class="col-md-8 eContentClass">
			<div class="row wideMenu">
				<div class="col-md-12 ebookIcon">
					<a href="/lee/ebook.ju" class="lineIcone"><span class="glyphicon glyphicon-book" aria-hidden="true"><br>전자도서</span></a>
					<a href="/lee/eMagazine.ju" class="lineIcone"><span class="glyphicon glyphicon-leaf" aria-hidden="true"><br>전자잡지</span></a>
				</div>
				<div class="col-md-12 ebookIcon">
					<a href="/lee/eAudio.ju" class="lineIcone"><span class="glyphicon glyphicon-headphones" aria-hidden="true"><br>오디오북</span></a>
					<a href="/lee/eEdu.ju" class="lineIcone"><span class="glyphicon glyphicon-pencil" aria-hidden="true"><br>e-교육</span></a>
				</div>
			</div>
			<div class="row mobileMenu">
				<div class="col-md-12 mobileIcon">
					<a href="/lee/ebook.ju" class="moblieLine"><span class="glyphicon glyphicon-book" aria-hidden="true"><br>전자도서</span></a>
					<a href="/lee/eMagazine.ju" class="moblieLine"><span class="glyphicon glyphicon-leaf" aria-hidden="true"><br>전자잡지</span></a>
					<a href="/lee/eAudio.ju" class="moblieLine"><span class="glyphicon glyphicon-headphones" aria-hidden="true"><br>오디오북</span></a>
					<a href="/lee/eEdu.ju" class="moblieLine"><span class="glyphicon glyphicon-pencil" aria-hidden="true"><br>e-교육</span></a>
				</div>
			</div>
		</div> <!-- 컨테츠 끝 부분 -->
		
	</div>
	
</body>
</html>