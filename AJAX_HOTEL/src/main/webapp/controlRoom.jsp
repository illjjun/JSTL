<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>객실관리</title>
</head>
<style>
@import url(https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap);
table{background-color:gray;
		color: white;
		}
#tblWrite {border-collapse:collapse;
		}

h2,h3{ color:white;
font-family: 'Noto Sans KR', sans-serif;
	}		
#tblRoom {
		}
th,td {border:1px solid black;}
body {background-image:url(https://p4.wallpaperbetter.com/wallpaper/109/664/851/black-texture-wallpaper-preview.jpg);}
</style>
<header><h2 align=center>객실관리 프로그램</h2><hr></header>

<body>

<table id=tblWrite align=center><!-- 입력부분 -->
<tr><td>객실번호:<input type=number id=roomcode></td></tr>
<tr><td>객실명:<input type=text id=name></td></tr>
<tr><td>객실종류:<input type=number id=type></td></tr>
<tr><td>숙박가능인원:<input type=number id=howmany></td></tr>
<tr><td>숙박비:<input type=number id=howmuch></td></tr>
<tr><td align=center><input type=button id='btnGo' value='전송'>
	<input type=reset value='비우기'></td></tr>
</table> 
<br><br>
<table id=tblRoom align=center>  <!-- 객실목록 -->
<thead>
	<tr><th>객실번호</th><th>객실명</th><th>객실종류</th><th>숙박가능인원</th>
		<th>숙박비</th></tr>
</thead>
<tbody>
</tbody>
</table>


</body>
<footer>
<hr>
<h3 align=center>Copyleft : Shin Dong Hun</h3></footer>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.ready(function(){
	loadRoom();
	return false;
})
.on('click','#btnGo',function(){
	let operation='';
	if($('#roomcode').val()==''){
		if($('#name').val()!='' && $('#type').val()!='' && $('#howmany').val()!='' && $('#howmuch').val()!=''){ //insert
			operation='insert';
		}else{
			alert('입력값이 모두 채워지지 않았습니다.');
			return false;
		}
	}else {
		if($('#name').val()!='' && $('#type').val()!='' && $('#howmany').val()!='' && $('#howmuch').val()!=''){ 
			//update
			operation='update';
		}else{ //delete
			operation='delete';	
		}
	}
	
	//AJAX CALL
	$.get(operation,{code:$('#roomcode').val(),
		  				name:$('#name').val(),
		  				type:$('#type').val(),
		 				howmany:$('#howmany').val(),
						howmuch:$('#howmuch').val()},
			function(txt){
					$('#roomcode,#name,#type,#howmany,#howmuch').val('');
					loadRoom();
			},'text');
	return false;
});
function loadRoom(){
	$('#tblRoom tbody').empty();
	$.get('select',{},function(txt){
		if(txt=='')return false;
		let rec=txt.split(';');
		for(i=0; i<rec.length;i++){
			let field=rec[i].split(',');
			let html='<tr><td>'+field[0]+'</td><td>'+field[1]+'</td><td>'+field[2]+
			'</td><td>'+field[3]+'</td><td>'+field[4]+'</td></tr>';
			$('#tblRoom tbody').append(html);
		}
	},'text');
}
</script>
</html>

