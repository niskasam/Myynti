<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="style.css">
<title>Asiakkaat</title>
</head>
<body>

<h3> Asiakkaat </h3>




<table id="listaus" class="content-table">
	<thead>
		<tr>
			<th colspan="6" class="oikealle uusi-asiakas" ><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
	
		<tr>
			<th class="oikealle">Asiakashaku:</th>
			<th colspan="3"><input type="text" id="hakusana" class="haku"></th>
			<th colspan="2"><input class="hakunappi" type="button" value="Hae" id="hakunappi"></th>
		</tr>
	
		<tr>
			<th>Asiakas_id</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th></th>
		</tr>
	</thead>
	
		<tbody>
		</tbody>
		
</table>

<br><br>


<script>


$(document).ready(function(){	
	
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		console.log($("#hakusana").val());
		haeAsiakkaat();
	});
	
	$(document.body).on("keydown", function(event){
		if(event.which==13){
			haeAsiakkaat();
		}
	});
	
	$("#hakusana").focus();
	
});

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", datatype:"json", success:function(result){
		$.each(result.asiakkaat, function(i, field){
			var htmlStr;
			htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
			htmlStr+="<td>"+field.asiakas_id+"</td>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puhelin+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>";
			htmlStr+="<td><a href='muutaasiakas.jsp?asiakas_id="+field.asiakas_id+"'>Muuta</a>&nbsp;";
			htmlStr+="<span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>";
			htmlStr+="</tr>";
			$("#listaus tbody").append(htmlStr);
		});
	}});
}

function poista(asiakas_id){
	if(confirm("Haluatko varmasti poistaa asiakkaan " + asiakas_id + "?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result){
			if(result.response==0){
				$("#ilmo").html("Asiakkaan poistaminen epäonnistui.");
			} else if(result.response==1){
				$("#rivi_"+asiakas_id).css("background-color", "red");
				alert("Asiakkaan " + asiakas_id + " poistaminen onnistui.");
				haeAsiakkaat();
			}
		}})
	}
}


</script>
</body>
</html>