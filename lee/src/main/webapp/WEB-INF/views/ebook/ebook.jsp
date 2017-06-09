<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
	<link rel="stylesheet" href="/lee/resources/bootstrapk/css/bootstrap.min.css">
	<style type="text/css">
		#detailFind>h4>a{
			text-decoration: none;
		}
		#openFind>div>table>tbody>tr>th{
			vertical-align: middle;
		}
		#cateMd{
			display: none;
		}
		.order>span:HOVER{
			cursor : pointer;
		}
		.modal-body{
			margin: 2%;
		}
		.modal-body>div>div{
			padding: 1%;
		}
		@media (max-width: 768px) {
			.info{
				display: none;
			}
		}
	</style>
    
	<script type="text/javascript" src="/lee/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="/lee/resources/bootstrapk/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function() {
			/*사이드바*/
			$("#emList").removeClass("has-sub");
			$("#emList>ul").remove();
			$("#abList").removeClass("has-sub");
			$("#abList>ul").remove();
			$("#eduList").removeClass("has-sub");
			$("#eduList>ul").remove();
			
			/*사이드바 메뉴 클릭*/
			$("#ebList>ul>li>a").click(
				function(event) {
					detailSubject="";
					detailWrite="";
					detailPub="";
					cateLg=$(event.target).eq(0).data("lg");
					cateMd="";
					
					$(".order>span").eq(1).click();
					ebookDetailAjax(detailSubject, detailWrite, detailPub, cateLg, cateMd, 1, orderName);
					$("#pagingNav").removeClass().addClass("detail");
					$("#pagingNav>ul>li").removeClass("active");
					$("#pagingNav>ul>li").eq(1).addClass("active");
				}
			);
			$("#ebList>ul>li>ul>li>a").click(
				function(event) {
					detailSubject="";
					detailWrite="";
					detailPub="";
					cateLg=$(event.target).parent().parent().parent().children("a").data("lg");
					cateMd=$(event.target).eq(0).data("md");
					
					$(".order>span").eq(1).click();
					ebookDetailAjax(detailSubject, detailWrite, detailPub, cateLg, cateMd, 1, orderName);
					$("#pagingNav").removeClass().addClass("detail");
					$("#pagingNav>ul>li").removeClass("active");
					$("#pagingNav>ul>li").eq(1).addClass("active");
				}
			);
			
			/*페이지 클릭시 색칠 및 Ajax실행*/
			$("#pagingNav>ul>li").click(
				function() {
					var page=$(this).data("page");
					/*해당 버튼 사용 불가*/
					if($(this).hasClass("disabled")==true || $(this).hasClass("active")==true){
						alert("사용불가");
						return null;
					}
					$("body").scrollTop(0);
					/*<< >> 판단*/
					if(page=="before"){
						page="-1";
						alert($(this).next().data("page")-1);
						/*페이징을 ajax하고 page 변수로 해당 버튼을 색칠한다*/
					}
					else if(page=="after"){
						page="99";
						alert($(this).prev().data("page")+1);
					}
					else{
						$("#pagingNav>ul>li").removeClass("active");
						$(this).addClass("active");
					}
					var pagingNavClassName=$("#pagingNav")[0].className;
					if(pagingNavClassName=="noSearch"){
						ebookListFirst(page, orderName);
					}
					else if(pagingNavClassName=="simple"){
						ebookSearchAjax(simpleSearchText, page, orderName);
					}
					else if(pagingNavClassName=="detail"){
						ebookDetailAjax(detailSubject, detailWrite, detailPub, cateLg, cateMd, page, orderName);
					}
				}
			);
			
			$("#ebList").addClass('open').children('ul').show();
			
			/*소 카테고리*/
			$("#cateLg").change(
				function() {
					var cateLgVal=$("#cateLg").val();
					if(cateLgVal==99){
						$("#cateMd").css("display", "none");
					}
					else{
						$.ajax({
							type : "GET"
							, url : "ebookCate.ju"
							, data : {cateLgVal : cateLgVal}
							, dataType : "json"
							, success: function(data){
								var cateMdArr=data.cateMd;
								var cateMdOption="<optgroup><option value='99'>전체</option></optgroup><optgroup>"
								for(var i=0 ; i<cateMdArr.length ; i++){
									cateMdOption+="<option value='" + i + "'>" + cateMdArr[i] + "</option>";
								}
									cateMdOption+="</optgroup>";
								$("#cateMd").css("display", "block").html(cateMdOption);
							}
						});
					}
			});
			
			/*처음 Ajax 실행*/
			ebookListFirst(1, orderName);
			
			var simpleSearchText="";
			/*단순 검색 Ajax*/
			function ebookSearchAjax(simpleSearchText, page, orderName) {
				$.ajax({
					type : "GET"
					, url : "ebookSimpleSearch.ju"
					, data : {simpleSearchText : simpleSearchText, page : page, orderName : orderName}
					, dataType : "json"
					, success : function(data){
						var arr=data.ebArr;
						var intoHTML="";
						for(var i=0 ; i<arr.length ; i++){
							intoHTML+='<tr data-idx=' + arr[i].bk_idx + '>';
							intoHTML+='	<td>';
							intoHTML+='		<div class="media">';
							intoHTML+='			<div class="media-left media-middle text-center">';
							intoHTML+='				<img class="media-object" src="/lee/resources/ebook/book.jpg" style="width: 97px; height: 110px;"><br>';
							intoHTML+='			</div>';
							intoHTML+='			<div class="media-body">';
							intoHTML+='				<h4 class="media-heading">진짜 진짜 생생한 동물 낱말 카드 TEST Count : ' + arr[i].el_subject + '</h4>';
							intoHTML+='				<div class="row">';
							intoHTML+='					<div class="col-md-2">저자</div>';
							intoHTML+='						<div class="col-md-8">편집부 저</div>';
							intoHTML+='				</div>';
							intoHTML+='				<div class="row info">';
							intoHTML+='					<div class="col-md-12">';
							intoHTML+='						<dl>';
							intoHTML+='							<dt>간략소개</dt>';
							intoHTML+='							<dd>';
							intoHTML+=' 사람의 일생에서 가장 폭발적인 언어 습득 능력을 구사하는 나이는 생후 18개월. 이 시기의 아이들은 스펀지가 물을 빨아들이듯, 빠른 속도로 언어를 배우기 시작합니다. 사물카드는 주변에서 쉽게 볼 수 있는 사물들을 이름과 함께 보여 주어, 어린이의 어휘력과 함께 사고력의 발달을 도와줍니다.';
							intoHTML+='							</dd>';
							intoHTML+='						</dl>';
							intoHTML+='					</div>';
							intoHTML+='				</div><!-- class info -->';
							intoHTML+='			</div><!-- class media-body -->';
							intoHTML+='		</div><!-- class media -->';
							intoHTML+='	</td>';
							intoHTML+='</tr>';
						}
						$("#contentTbody").html(intoHTML);
						contentClick();
					}
				});
			}
			/*단순 검색 Ajax 실행*/
			$("#simpleSearchText").keypress(
				function(e) {
					if(e.keyCode==13){
				    	$("#ebookSearch").click();
				    }
				}
			);
			$("#ebookSearch").click(
				function() {
					simpleSearchText=$("#simpleSearchText").val();
					ebookSearchAjax(simpleSearchText, 1, orderName);
					$("#pagingNav").removeClass().addClass("simple");
					$("#pagingNav>ul>li").removeClass("active");
					$("#pagingNav>ul>li").eq(1).addClass("active");
				}
			);
			
			var detailSubject="";
			var detailWrite="";
			var detailPub="";
			var cateLg="";
			var cateMd="";
			/*상세 검색 Ajax*/
			function ebookDetailAjax(detailSubject, detailWrite, detailPub, cateLg, cateMd, page, orderName) {
				$.ajax({
					type : "GET"
					, url : "ebookDetailSearch.ju"
					, data : {detailSubject : detailSubject , detailWrite : detailWrite , detailPub : detailPub , cateLg : cateLg , cateMd : cateMd , page : page, orderName : orderName}
					, dataType : "json"
					, success: function(data){
						var arr=data.ebArr;
						var intoHTML="";
						for(var i=0 ; i<arr.length ; i++){
							intoHTML+='<tr data-idx=' + arr[i].bk_idx + '>';
							intoHTML+='	<td>';
							intoHTML+='		<div class="media">';
							intoHTML+='			<div class="media-left media-middle text-center">';
							intoHTML+='				<img class="media-object" src="/lee/resources/ebook/book.jpg" style="width: 97px; height: 110px;"><br>';
							intoHTML+='			</div>';
							intoHTML+='			<div class="media-body">';
							intoHTML+='				<h4 class="media-heading">진짜 진짜 생생한 동물 낱말 카드 TEST Count : ' + arr[i].el_subject + '</h4>';
							intoHTML+='				<div class="row">';
							intoHTML+='					<div class="col-md-2">저자</div>';
							intoHTML+='					<div class="col-md-8">편집부 저</div>';
							intoHTML+='				</div>';
							intoHTML+='				<div class="row info">';
							intoHTML+='					<div class="col-md-12">';
							intoHTML+='						<dl>';
							intoHTML+='							<dt>간략소개</dt>';
							intoHTML+='							<dd>';
							intoHTML+='사람의 일생에서 가장 폭발적인 언어 습득 능력을 구사하는 나이는 생후 18개월. 이 시기의 아이들은 스펀지가 물을 빨아들이듯, 빠른 속도로 언어를 배우기 시작합니다. 사물카드는 주변에서 쉽게 볼 수 있는 사물들을 이름과 함께 보여 주어, 어린이의 어휘력과 함께 사고력의 발달을 도와줍니다.';
							intoHTML+='							</dd>';
							intoHTML+='						</dl>';
							intoHTML+='					</div>';
							intoHTML+='				</div><!-- class info -->';
							intoHTML+='			</div><!-- class media-body -->';
							intoHTML+='		</div><!-- class media -->';
							intoHTML+='	</td>';
							intoHTML+='</tr>';
						}
						$("#contentTbody").html(intoHTML);
						contentClick();
					}
				});
			}
			/*상세 검색 Ajax 실행*/
			$("#detailSearch").click(
				function() {
					detailSubject=$("#detailSubject").val();
					detailWrite=$("#detailWrite").val();
					detailPub=$("#detailPub").val();
					cateLg=$("#cateLg").val();
					if(cateLg==99){
						cateMd="";
					}
					else{
						cateMd=$("#cateMd").val();
					}
					ebookDetailAjax(detailSubject, detailWrite, detailPub, cateLg, cateMd, 1, orderName);
					$("#pagingNav").removeClass().addClass("detail");
					$("#pagingNav>ul>li").removeClass("active");
					$("#pagingNav>ul>li").eq(1).addClass("active");
				}
			);
			
			/*추천, 최신순 변경*/
			var orderName="new";
			$(".order>span").eq(0).css("font-weight", "400");
			$(".order>span").click(
				function() {
					var orderSpanIndex=$(".order>span").index(this);
					var fontWeight=$(".order>span").eq(orderSpanIndex).css("font-weight");
					if(fontWeight=="400"){
						orderName=$(".order>span").eq(orderSpanIndex).data("order");
						$(".order>span").eq(orderSpanIndex).css("font-weight", "bold");
						$(".order>span").eq(orderSpanIndex).siblings().css("font-weight", "400");
						var pagingNavClassName=$("#pagingNav")[0].className;
						if(pagingNavClassName=="noSearch"){
							ebookListFirst(1, orderName);
						}
						else if(pagingNavClassName=="simple"){
							ebookSearchAjax(simpleSearchText, 1, orderName);
						}
						else if(pagingNavClassName=="detail"){
							ebookDetailAjax(detailSubject, detailWrite, detailPub, cateLg, cateMd, 1, orderName);
						}
						
						
					}
					else if(fontWeight="bold"){
						/*이미 해당 순서로 정렬됨*/
						return null;
					}
				}
			);
			
		}); //기본 끝나는 곳
		
		/*처음 미검색 Ajax*/
		function ebookListFirst(page, order) {
			$.ajax({
				type : "GET"
				, url : "ebookFirst.ju"
				, data : {page : page, order : order}
				, dataType : "json"
				, success: function(data){
					var arr=data.ebArr;
					var intoHTML="";
					for(var i=0 ; i<arr.length ; i++){
						intoHTML+='<tr data-idx=' + arr[i].bk_idx + '>';
						intoHTML+='	<td>';
						intoHTML+='		<div class="media">';
						intoHTML+='			<div class="media-left media-middle text-center">';
						intoHTML+='				<img class="media-object" src="/lee/resources/ebook/book.jpg" style="width: 97px; height: 110px;"><br>';
						intoHTML+='			</div>';
						intoHTML+='			<div class="media-body">';
						intoHTML+='				<h4 class="media-heading">진짜 진짜 생생한 동물 낱말 카드 TEST Count : ' + arr[i].el_subject + '</h4>';
						intoHTML+='				<div class="row">';
						intoHTML+='					<div class="col-md-2">저자</div>';
						intoHTML+='					<div class="col-md-8">편집부 저</div>';
						intoHTML+='				</div>';
						intoHTML+='				<div class="row info">';
						intoHTML+='					<div class="col-md-12">';
						intoHTML+='						<dl>';
						intoHTML+='							<dt>간략소개</dt>';
						intoHTML+='							<dd>';
						intoHTML+=' 사람의 일생에서 가장 폭발적인 언어 습득 능력을 구사하는 나이는 생후 18개월. 이 시기의 아이들은 스펀지가 물을 빨아들이듯, 빠른 속도로 언어를 배우기 시작합니다. 사물카드는 주변에서 쉽게 볼 수 있는 사물들을 이름과 함께 보여 주어, 어린이의 어휘력과 함께 사고력의 발달을 도와줍니다.';
						intoHTML+='							</dd>';
						intoHTML+='						</dl>';
						intoHTML+='					</div>';
						intoHTML+='				</div><!-- class info -->';
						intoHTML+='			</div><!-- class media-body -->';
						intoHTML+='		</div><!-- class media -->';
						intoHTML+='	</td>';
						intoHTML+='</tr>';
					}
					$("#contentTbody").html(intoHTML);
					$("#pagingNav>ul>li").removeClass("active");
					$("#pagingNav>ul>li").eq(page).addClass("active");
					contentClick();
				}
			});
		}
		
		
		/*컨텐츠 클릭*/
		function contentClick() {
			$("#contentTbody>tr>td").click(
				function() {
					var selectNum=$("#contentTbody>tr>td").index(this);
					var bk_idx=$("#contentTbody>tr").eq(selectNum).data("idx");
					$.ajax({
						type : "GET"
						, url : "ebookContent.ju"
						, data : {bk_idx : bk_idx}
						, dataType : "json"
						, success: function(data){
							var intoHeaderHTML="";
							intoHeaderHTML+='<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
							intoHeaderHTML+='<h4 class="modal-title" id="myModalLabel">서울역' + data.ebArr[0].bk_idx + '</h4>';
							
							var intoBodyHTML="";
							intoBodyHTML+='<div class="panel panel-default" >';
							intoBodyHTML+='	<div class="row">';
							intoBodyHTML+='		<div class="col-md-12">';
							intoBodyHTML+='			<div class="media">';
							intoBodyHTML+='				<div class="media-left media">';
							intoBodyHTML+='					<img class="media-object" src="/lee/resources/ebook/book.jpg" style="width: 100px; height: 150px;"  alt="..." >';
							intoBodyHTML+='				</div>';
							intoBodyHTML+='				<div class="media-body">';
							intoBodyHTML+='					<div class="row">';
							intoBodyHTML+='						<div class="col-md-2">저자</div><div class="col-md-10">박영란</div>';
							intoBodyHTML+='						<div class="col-md-2">출판사</div><div class="col-md-10">자음과 모음</div>';
							intoBodyHTML+='						<div class="col-md-2">제작일</div><div class="col-md-10">2015.08.19</div>';
							intoBodyHTML+='						<div class="col-md-2">추천수</div><div class="col-md-10">0</div>';
							intoBodyHTML+='						<div class="col-md-2">대출</div><div class="col-md-10">0/5</div>';
							intoBodyHTML+='						<div class="col-md-2">예약</div><div class="col-md-10">0</div>';
							intoBodyHTML+='						<div class="col-md-12 text-right">';
							intoBodyHTML+='							<button class="btn btn-default" onClick="ebookRefresh(1)">';
							intoBodyHTML+='								<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span><span id="refreshSpan">가능</span>';
							intoBodyHTML+='							</button>';
							intoBodyHTML+='							<input class="btn btn-default" type="button" onClick="ebookLoan(1)" value="대출하기">';
							intoBodyHTML+='							<input class="btn btn-default" type="button" onClick="ebookRecommend(1)" value="추천하기">';
							intoBodyHTML+='						</div>';
							intoBodyHTML+='					</div>';
							intoBodyHTML+='				</div>';
							intoBodyHTML+='			</div>';
							intoBodyHTML+='		</div>';
							intoBodyHTML+='	</div>';
							intoBodyHTML+='</div>';
							intoBodyHTML+='<div class="row">';
							intoBodyHTML+='	<table class="table">';
							intoBodyHTML+='		<tr>';
							intoBodyHTML+='			<td>';
							intoBodyHTML+='				<h4>작품소개</h4>';
							intoBodyHTML+='				(강추!) 『나의 고독한 두리안 나무』 『라구나 이야기 외전』 『영우한테 잘해줘』의 박영란 작가의 신작 열 살 소년이 그곳에서 당신을 기다립니다 위험이 닥칠 땐 개다리춤을 추는 소년과 귀차니 아줌마의 인생 이야기! 『나의 고독한 두리안 나무』『라구나 이야기 외전』『영우한테 잘해줘』에서 자신만의 확실한 작품세계와 문장으로 청소년을 만났던 박영란 작가가 들려주는 또다른 삶의 이야기이다. 세상에서 어슬렁거리는 사람을 내쫓지 않는 것은 광장뿐. 그곳에서 사는 사람들과 어울리면서 열 살 소년이 알아버린 삶의 무서운 진실, 인생 이야기. 절대 무너지지 마! 우리가 삶을 함부로 대하지 않으면 그 무엇도 우리를 함부로 대할 수 없다!';
							intoBodyHTML+='			</td>';
							intoBodyHTML+='		</tr>';
							intoBodyHTML+='	</table>';
							intoBodyHTML+='</div>';
							$(".modal-header").html(intoHeaderHTML);
							$(".modal-body").html(intoBodyHTML);
						}
					});
					$("#myModal").modal("show");
				}
			);
		}
		
		/*새로고침*/
		function ebookRefresh(el_idx) {
			$.ajax({
				type : "GET"
				, url : "ebookRefresh.ju"
				, data : {el_idx : el_idx}
				, dataType : "json"
				, success: function(data){
					$("#refreshSpan").text(data.msg);
				}
			})
		}
		/*대출*/
		function ebookLoan(el_idx) {
			$.ajax({
				type : "GET"
				, url : "ebookLoan.ju"
				, data : {el_idx : el_idx}
				, dataType : "json"
				, success: function(data){
					alert(data.loan);
				}
			})
		}
		/*추천*/
		function ebookRecommend(el_idx) {
			$.ajax({
				type : "GET"
				, url : "ebookRecommend.ju"
				, data : {el_idx : el_idx}
				, dataType : "json"
				, success: function(data){
					alert(data.recommend);
				}
			})
		}
		
	</script>
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	<!-- 사이드바+컨텐츠 -->
	<div class="row">
		<div class="col-md-3">
			<jsp:include page="/WEB-INF/views/ebook/elibSide.jsp"></jsp:include>
		</div>
		
		<!-- 컨텐츠 -->
		<div class="col-md-8">
			
			<!-- 검색바 -->
			<div class="row" style="background: #3cdbde; padding: 80px 0;">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="책 검색..." name="simpleSearchText" id="simpleSearchText">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" id="ebookSearch">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</span>
				</div>
			</div>
			
			<!-- 상세검색 -->
			<div class="row">
				<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
					<div class="panel panel-default">
					
						<!-- 상세검색 상단 -->
						<div class="panel-heading text-center" role="tab" id="detailFind">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#openFind" aria-expanded="true" aria-controls="collapseOne">
									상세검색
								</a>
							</h4>
						</div>
						
						<!-- 상세검색색 부분 -->
						<div id="openFind" class="panel-collapse collapse" role="tabpanel" aria-labelledby="detailFind">
							<div class="panel-body">
							
								<table class="table">
									<tbody>
										<tr>
											<th class="col-md-1 text-right">책 이름</th>
											<td class="col-md-4" colspan="2"><input type="text" class="form-control" placeholder="책 이름" name="detailSubject" id="detailSubject"></td>
										</tr>
										<tr>
											<th class="col-md-1 text-right">저자</th>
											<td class="col-md-4" colspan="2"><input type="text" class="form-control" placeholder="저자" name="detailWrite" id="detailWrite"></td>
										</tr>
										<tr>
											<th class="col-md-1 text-right">출판사</th>
											<td class="col-md-4" colspan="2"><input type="text" class="form-control" placeholder="출판사" name="detailPub" id="detailPub"></td>
										</tr>
										<tr>
											<th class="col-md-1 text-right">카테고리</th>
											<td class="col-md-2">
												${bookLgSelect }
											</td>
											<td class="col-md-2">
												<select id="cateMd" class="form-control">
												</select>
											</td>
										</tr>
										<tr>
											<td class="text-center" colspan="3"><button class="btn btn-default" id="detailSearch">상세검색</button></td>
										</tr>
									</tbody>
								</table>
								
							</div>
						</div><!-- 상세검색부분 End -->
					</div>
				</div>
			</div><!-- 상세검색 End -->
			
			<!-- 검색리스트 -->
			<div class="row">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>
								<div class="row">
								<div class="col-md-6 text-left">
									<span>자료검색</span>
								</div>
								<div class="col-md-6 text-right order">
									<span data-order="recommend">추천 순</span>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<span data-order="new">최신 순</span>
								</div>
								</div>
							</th>
						</tr>
					</thead>
					
					<tbody id="contentTbody">
					<!-- Ajax로 들어감 -->
					</tbody>
					
					<tfoot class="text-center">
						<tr>
							<td>
								<nav id="pagingNav" class="noSearch">
									<ul class="pagination">
										<li data-page="before"><a href="#" onclick="return false" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
										<li data-page="1"><a href="#" onclick="return false">1</a></li>
										<li data-page="2"><a href="#" onclick="return false">2</a></li>
										<li data-page="3"><a href="#" onclick="return false">3</a></li>
										<li data-page="4" class="disabled"><a href="#" onclick="return false">4</a></li>
										<li data-page="5"><a href="#" onclick="return false">5</a></li>
										<li data-page="after"><a href="#" onclick="return false" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>	</li>
									</ul>
								</nav>
							</td>
						</tr>
					</tfoot>
				</table>
			</div><!-- 검색리스트 End-->
			
		</div><!-- 컨텐츠 End-->
	</div><!-- 사이드바+컨텐츠 End-->

<!-- Modal -->
	<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
				</div>
				<div class="modal-body">
					<!-- 선택한 책 -->
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" data-dismiss="modal">닫기</button>
			</div>
			</div>
		</div>
	</div>
	
</body>
</html>