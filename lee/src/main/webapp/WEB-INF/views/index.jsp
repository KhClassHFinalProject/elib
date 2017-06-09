<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/lee/resources/bootstrapk/css/bootstrap.min.css">
	<style type="text/css">
	</style>
    
	<script type="text/javascript" src="/lee/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="/lee/resources/bootstrapk/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	</script>
	
	<link rel="stylesheet" href="/lee/resources/index/index.css">

  <script>
  $(function(){
	  $("#search-input").focus( function() {
		  
	      $("#search-status").css("display","none");
	  });
	  $("#search-input").blur( function() {
		  
	      $("#search-status").css("display","inline");
	  });
  });
  </script>
</head>
<body>
<%@include file="header.jsp" %>
<!-- 검색 컨테이너 -->
<div class="jumbotron">
 <img id="imgg" src="/lee/resources/index/main.png" >
 <div class="container text-center">
		 <div id="searchbar" style="position: relative 50%;">   
			    <div class="input-group input-group-lg">
				 	 <span class="input-group-addon" id="sizing-addon1">
					 	 <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
					 	 </span>
				 	 <input id="search-input" type="text" class="form-control" placeholder="Username" aria-describedby="sizing-addon1">
				 	 <span id="search-statusBar">
				 	 	<span id="search-status" class="glyphicon glyphicon-search btn-lg"></span>
				 	 </span> 
				</div> 
		 </div>
 </div>
</div>
  
  <!-- 첫번째줄 -->
<div class="container-fluid bg-3 text-center" style="margin-top: 20%;">    
  <!-- <h3>Some of my Work</h3><br> -->
  
  <div class="row">
  
    <div id="notice-bbs" class="col-sm-9">
      <p>공지사항</p>
      <img src="/lee/resources/index/bbs.png" class="img-responsive" style="width:100%; height:100%;" alt="Image">
    </div>
    
    <div id="calen" class="col-sm-3 sidenav">
      <p>캘린더</p>
      <img src="/lee/resources/index/1.jpg" class="img-responsive" style="width:100%; height:100%;" alt="Image">
    </div>
  </div>
</div><br>


<!-- 두번째줄 -->
<div id="allbutton" class="container-fluid bg-3 text-center">

  <div class="row" style="width:100%;">
  <div class="indexbt1row">
	    <div class="col-sm-3">
	      <p>마이페이지</p>
	      <a href="changeMe.ju">
	      <img src="/lee/resources/index/button.gif" class="img-responsive" style="width:100%" alt="Image">
	      </a>
	    </div>
	    <div class="col-sm-3"> 
	      <p>버튼2</p>
	      <img src="/lee/resources/index/button.gif" class="img-responsive" style="width:100%" alt="Image">
	    </div>
   </div>
   <div class="indexbt2row">
	    <div class="col-sm-3"> 
	      <p>버튼3</p>
	      <img src="/lee/resources/index/button.gif" class="img-responsive" style="width:100%" alt="Image">
	    </div>
	    <div class="col-sm-3">
	      <p>버튼4</p>
	      <img src="/lee/resources/index/button.gif" class="img-responsive" style="width:100%" alt="Image">
	    </div>
	</div>
  </div>
</div><br><br>

<!-- <footer class="container-fluid text-center">
  
</footer> -->
<%-- <%@include file="footer.jsp" %> --%>
</body>

</html>