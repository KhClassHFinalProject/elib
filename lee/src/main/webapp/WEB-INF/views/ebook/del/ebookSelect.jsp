<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
	<link rel="stylesheet" href="/lee/resources/bootstrapk/css/bootstrap.min.css">
	<style type="text/css">
		.panel{
			padding:10px;
		}
	</style>
    
	<script type="text/javascript" src="/lee/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="/lee/resources/bootstrapk/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function ebookRefresh(num_idx) {
			$.ajax({
				type : "GET"
				, url : "ebookRefresh.ju"
				, data : {num_idx : num_idx}
				, dataType : "json"
				, success: function(data){
					$("#refreshSpan_"+num_idx).text(data.msg);
				}
			})
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
<div class="row">

	<div class="col-md-3">
			<jsp:include page="/WEB-INF/views/ebook/elibSide.jsp"></jsp:include>
	</div>
	
	<div class="col-md-8">
		<div class="row">
			 <div class="input-group">
      			<input type="text" class="form-control" placeholder="책 검색">
      				<span class="input-group-btn">
      				 	<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
      				</span>
    		</div><!-- /input-group -->
		</div>
		<br>
		<div class="row panel panel-default" >
			<div class="row">
				<div class="col-md-12">
					<div class="media">
						<div class="media-left media">
							<img class="media-object" src="/lee/resources/ebook/book.jpg" style="width: 100px; height: 150px;"  alt="..." >
						</div>
						<div class="media-body">
							<br>
							<h4 class="media-heading">서울역</h4>
							<div class="row">
								<div class="col-md-2">저자</div><div class="col-md-10">박영란</div>
								<div class="col-md-2">출판사</div><div class="col-md-10">자음과 모음</div>
								<div class="col-md-2">제작일</div><div class="col-md-10">2015.08.19</div>
								<div class="col-md-2">추천수</div><div class="col-md-10">0</div>
								<div class="col-md-2">대출</div><div class="col-md-10">0/5</div>
								<div class="col-md-2">예약</div><div class="col-md-10">0</div>
								<div class="col-md-12 text-right">
									<button class="btn btn-default" onClick="ebookRefresh(1)"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span><span id="refreshSpan_1">가능</span></button>
									<input class="btn btn-default" type="button" value="대출하기">
									<input class="btn btn-default" type="button" value="추천하기">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
				<table class="table">
	  				<tr>
	  					<td>
	  					<h4>작품소개</h4>
	  					(강추!) 『나의 고독한 두리안 나무』 『라구나 이야기 외전』 『영우한테 잘해줘』의 
						 박영란 작가의 신작 
						 열 살 소년이 그곳에서 당신을 기다립니다 
						위험이 닥칠 땐 개다리춤을 추는 소년과 
						 귀차니 아줌마의 인생 이야기! 
						『나의 고독한 두리안 나무』『라구나 이야기 외전』『영우한테 잘해줘』에서 자신만의 확실한 작품세계와 문장으로 청소년을 만났던 박영란 작가가 들려주는 또다른 삶의 이야기이다. 
						세상에서 어슬렁거리는 사람을 내쫓지 않는 것은 광장뿐. 그곳에서 사는 사람들과 어울리면서 열 살 소년이 알아버린 삶의 무서운 진실, 인생 이야기. 
						절대 무너지지 마! 
						우리가 삶을 함부로 대하지 않으면 
						 그 무엇도 우리를 함부로 대할 수 없다! 
						여름방학이 다가오며 형은 여느 때와는 조금 다르게 아이언맨을 찾으러 집을 나갔고, 그 시간이 길어지기 시작했다. 나는 서울역 광장에서 아이언맨과 형을 기다렸다. 
						나는 일곱 살 때 열다섯 살이었던 형과 단둘이 살게 되었다. 엄마는 끓는 기름을 자신의 다리에 쏟아붓는 자해를 하면서까지 집을 떠나기를 원했고, 아빠는 그런 엄마를 떠나보낸 뒤, 뒤따라 집을 나갔다. 
						형과 나는 어리지만 나름의 방식으로 생활을 꾸려나갔다. 가끔씩 이모가 밑반찬을 들고 찾아와 청소도 해주고 엄마가 주는 돈을 전해주면 규모있게 쓸 줄도 안다. 형은 어린 내게 세상에서 나를 지키며 살아가는 법을 가르쳐 줬다. 위험한 처하면 개다리 춤을 춰서 사람들을 웃겨라, 아무리 친한 사람이라도 집안 사정을 바닥까지 드러내서는 안 된다. 부모 없는 아이들은 보호자가 12명쯤 있는 것처럼 연막을 쳐야 한다. 나는 형에게 배운 것을 십분 적용하여 서울역 광장에서 시간을 때운다. 
						사실 그건 별거 아니었다. 
						그건 그냥 형이 돌아온 후에도 계속되는 인생과 같은 거였다. 
						나는 남편에게 배신당하고 꼬질꼬질 유모차에 아기와 짐을 싣고 서울역 광장에서 살고 있는 귀차니 아줌마와 친구가 되어 같이 다닌다. 사기 치고 야반도주한 달의 궁전 누나나 귀차니 아줌마는 인생에 대해 많은 것을 이야기해준다. 
						“한 사람의 생애는 자기 책임 반이고, 세상 책임 반이야. 하필 재수 없게 이런 세상에 태어나서 팽개쳐졌다고 해도 자기 책임이 반은 된다는 거. 그러니까 세상이 인생을 빼앗아 갈 수는 없다는 거지.” 
						</td>
	  				</tr>
				</table>
			</div>
		</div>
	
</div>
</body>
</html>