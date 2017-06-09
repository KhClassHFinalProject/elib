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
		body {
			margin: 0 50px;
		}
		textarea{
			resize: none;
		}
		table:FIRST-OF-TYPE>tbody>tr>th{
			text-align: right;
			vertical-align: middle;
		}
		table:FIRST-OF-TYPE>tbody>tr:NTH-OF-TYPE(6)>td{
			text-align: center;
		}
		input[type=file]{
			display: none;
		}
		#cateMd{
			display: none;
		}
	</style>
    
	<script type="text/javascript" src="/lee/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="/lee/resources/bootstrapk/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="/lee/resources/js/jquery.form.js"></script>
	<script type="text/javascript" src="/lee/resources/js/jquery.ajax-progress.js"></script>
	<script type="text/javascript">
		$(function(){
			$(".fileinput-button").click(
				function() {
					$("input[name=files]").click();
				}
			);
			
			/*소분류 ajax*/
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
								console.log(data);
								var cateMdArr=data.cateMd;
								var cateMdOption=""
								for(var i=0 ; i<cateMdArr.length ; i++){
									
									cateMdOption+="<option value='" + i + "'>" + cateMdArr[i] + "</option>";
									
								}
								$("#cateMd").css("display", "block").html(cateMdOption);
							}
						});
					}
			});
			$('#cateLg').change();
		}); //기본함수
		
		var readyIdx=Math.floor(new Date().getTime());
		
		var objArr=new Array();
		var readerArr=new Array();
		/*파일 배열에 추가*/
		function addArrFile(obj) {
			var reader=new FileReader();
		    reader.readAsDataURL(obj);
		    reader.onload=function(){
		    	objArr[objArr.length]=obj;
		        readerArr[readerArr.length]=reader;
		        readerOnload(readerArr.length-1);
		    }
		}
		/*파일 추가 미리보기 생성 및 배열 추가*/
		function addFiles(obj) {
		    if (obj.files[0]) {
		    	//var arrLength=objArr.length;
		    	for(var i=0 ; i<obj.files.length ; i++){
		    		addArrFile(obj.files[i]);
		    	}
		    }
		}
		/*파일 추가 미리보기 만드는 함수*/
		function readerOnload(arrLength) {
        	var inHtml=$(".files").html();
			inHtml+='<tr class="template-upload">';
			inHtml+='		<td>';
			inHtml+='			<img src="' + readerArr[arrLength].result + '" border="0" style="width: 50px; height: 50px;">';
			inHtml+='			<span class="preview"></span></td><td><p class="name">' + objArr[arrLength].name + '</p>';
			inHtml+='			<strong class="error text-danger"></strong></td><td><p class="size">' + byteCalculation(objArr[arrLength].size) + '</p>';
			inHtml+='			<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">';
			inHtml+='				<div class="progress-bar progress-bar-success" style="width: 0%;">';
			inHtml+='				</div>';
			inHtml+='			</div>';
			inHtml+='		</td>';
			inHtml+='		<td>';
			inHtml+='			<button class="btn btn-primary start" onClick="eachStart(this)">';
			inHtml+='				<i class="glyphicon glyphicon-upload"></i><span>시작</span>';
			inHtml+='			</button>';
			inHtml+='			<button class="btn btn-warning cancel" onClick="eachCancel(this)">';
			inHtml+='				<i class="glyphicon glyphicon-ban-circle"></i><span>취소</span>';
			inHtml+='			</button>'
			inHtml+='		</td>';
			inHtml+='</tr>';
			$(".files").html(inHtml);
			$("input[type=file]").val("");
		}
		/*용량 계산*/
		function byteCalculation(bytes) {
			var bytes = parseInt(bytes);
			var s = ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
			var e = Math.floor(Math.log(bytes)/Math.log(1024));
		
			if(e == "-Infinity") return "0 "+s[0]; 
			else 
				return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+" "+s[e];
		}
		
		/*개별 업로드*/
		function eachStart(obj) {
			var startNum=$(".start").index(obj)-1;
	        var data = new FormData();
	        data.append("files", objArr[startNum]);
	        data.append("readyIdx", readyIdx);
			$.ajax({
				url : "adminUpload.ju"
				, type : "POST"
				, data : data
				, cache : false
				, contentType : false
				, processData : false 
				, progress : function(e) {
			        if(e.lengthComputable) {
			            var pct = (e.loaded / e.total) * 100;
			            /* console.log(pct); */
			            $(".progress-bar").eq(startNum).css("width", pct+"%");
			        }
				}
				, beforeSend: function() {
					$(".start").addClass("disabled");
					$(".cancel").addClass("disabled");
				}
				, success: function(reqData){
		            setTimeout(
		            	function() {
			            	$(".start").removeClass("disabled");
							$(".cancel").removeClass("disabled");
			            	$(".template-upload:eq(" + startNum + ")>td>.progress").css("display", "none");
			            	$(".template-upload:eq(" + startNum + ")>td>button").addClass("disabled").css("display", "none");
			            	var inHtml=$(".template-upload:eq(" + startNum + ")>td").eq(3).html();
			            	inHtml+='<button type="button" class="btn btn-info disabled">';
		            		inHtml+='	<i class="glyphicon glyphicon-ok"></i> <span>완료</span>';
	            			inHtml+='</button>';
			            	$(".template-upload:eq(" + startNum + ")>td").eq(3).html(inHtml);
		            	} , 500);
				}
				, error: function(data) {
	            	alert('error : ' +data);
	            }
			});
		}
		
		/*개별 취소*/
		function eachCancel(obj) {
			var cancelNum=$(".cancel").index(obj)-1;
			objArr.splice(cancelNum, 1);
			readerArr.splice(cancelNum, 1);
			$(".files>tr").eq(cancelNum).remove();
		}
		
		/*전체 업로드 */
		function allUploa() {
			var allStartlNum=$(".start").length;
			var data = new FormData();
			for(var i=0 ; i<objArr.length ; i++){
				if($(".template-upload:eq(" + i + ")>td>button").length==2){
			        data.append("files", objArr[i]);
				}
			}
	        data.append("readyIdx", readyIdx);
			$.ajax({
				url : "adminUpload.ju"
				, type : "POST"
				, data : data
				, cache : false
				, contentType : false
				, processData : false 
				, progress : function(e) {
			        if(e.lengthComputable) {
			            var pct = (e.loaded / e.total) * 100;
			            /* console.log(pct); */
			            $(".progress-bar").css("width", pct+"%");
			        }
			        else {
			            /* console.warn('Content Length not reported!'); */
			        }
				}
				, beforeSend: function() {
					$(".start").addClass("disabled");
					$(".cancel").addClass("disabled");
				}
				, success: function(reqData){
            			setTimeout(function() {
		            		for(var i=0 ; i<objArr.length ; i++){
				            	$(".template-upload:eq(" + i + ")>td>.progress").css("display", "none");
				            	$(".template-upload:eq(" + i + ")>td>button").css("display", "none");
				            	var inHtml=$(".template-upload:eq(" + i + ")>td").eq(3).html();
				            	inHtml+='<button type="button" class="btn btn-info disabled">';
			            		inHtml+='	<i class="glyphicon glyphicon-ok"></i> <span>완료</span>';
			           			inHtml+='</button>';
				            	$(".template-upload:eq(" + i + ")>td").eq(3).html(inHtml);
		            		}
            			}, 500);
					$(".start").removeClass("disabled");
					$(".cancel").removeClass("disabled");
				}
				, error: function(data) {
	            	console.log(data);
	            	alert('error : ' +data);
	            }
			});
		}
		/*전체 취소*/
		function allCancel() {
			var allCancelCount=$(".cancel").length;
			for(var i=0 ; i<allCancelCount-1 ; i++){
				objArr.splice(0, 1);
				readerArr.splice(0, 1);
				$(".files>tr").eq(0).remove();
			};
		}
	</script>
	
</head>
<body>

	<br><br><br><br>

	<table class="table">
		<tbody>
			<tr>
				<th>책 이름</th>
				<td><input type="text" class="form-control" placeholder="책이름" name="el_subject"></td>
			</tr>
			<tr>
				<th>저자</th>
				<td><input type="text" class="form-control" placeholder="저자" name="el_writer"></td>
			</tr>
			<tr>
				<th>출판사</th>
				<td><input type="text" class="form-control" placeholder="출판사" name="el_pub"></td>
			</tr>
			<tr>
				<td>	${cateLg } </td>
				<td><select id="cateMd" class="form-control"></select></td>
			</tr>
			<tr>
				<th>책 정보</th>
				<td><textarea class="form-control" rows="3" name="el_info"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<span class="btn btn-success fileinput-button">
						<i	class="glyphicon glyphicon-plus"></i> <span>파일 추가</span> 
					</span>
					<input type="file" name="files" accept=".gif, .jpg, .png" multiple="multiple" onchange="addFiles(this)">
					<button type="button" class="btn btn-primary start" onClick="allUploa()">
						<i class="glyphicon glyphicon-upload"></i> <span>전부 업로드</span>
					</button>
					<button type="button" class="btn btn-warning cancel" onClick="allCancel()">
						<i class="glyphicon glyphicon-ban-circle"></i> <span>전부 취소</span>
					</button>
				</td>
			</tr>
		</tbody>
	</table>
	
	<!-- <div class="row fileupload-buttonbar">
		<div class="col-md-7">
			<span class="btn btn-success fileinput-button">
				<i	class="glyphicon glyphicon-plus"></i> <span>파일 추가</span> 
			</span>
			<input type="file" name="files" accept=".gif, .jpg, .png" multiple="multiple" onchange="addFiles(this)">
			<button type="button" class="btn btn-primary start" onClick="allUploa()">
				<i class="glyphicon glyphicon-upload"></i> <span>전부 업로드</span>
			</button>
			<button type="button" class="btn btn-warning cancel" onClick="allCancel()">
				<i class="glyphicon glyphicon-ban-circle"></i> <span>전부 취소</span>
			</button>
		</div>
	</div> -->
	
	<table role="presentation" class="table table-striped">
		<tbody class="files">
		</tbody>
	</table>

</body>
</html>