<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="scripts/main.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" type="text/css" href="styles2.css">
<title>Asiakkaat</title>
</head>
<body onkeydown="tutkiNappain(event)">

<h3> Asiakkaat </h3>




<table id="listaus" class="content-table">
	<thead>
		<tr>
			<th colspan="4" id="ilmo"></th>
			<th colspan="6" class="oikealle uusi-asiakas" ><a id="uusiAsiakas" href="lisaaasiakas.jsp"><span id="uusiAsiakas" class="uusias">Lisää uusi asiakas</span></a></th>
		</tr>
	
		<tr>
			<th class="oikealle">Asiakashaku:</th>
			<th colspan="3"><input type="text" id="hakusana" class="haku"></th>
			<th colspan="2"><input class="hakunappi" type="button" value="Hae" id="hakunappi" onclick="haeAsiakkaat()"></th>
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
	
		<tbody id="tbody">
		</tbody>
		
</table>

<br><br>


<script>


// front end with Javascript

haeAsiakkaat();

document.getElementById("hakusana").focus();

function tutkiNappain(event){
	if(event.keyCode==13){
		haeAsiakkaat();
	}
}

function haeAsiakkaat(){
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/" + document.getElementById("hakusana").value,{
		method: 'GET'
	})
	
	.then(function (response){
		return response.json()
	})
	
	.then(function (responseJSON){
		var asiakkaat = responseJSON.asiakkaat;
		var htmlStr="";
		for(var i = 0; i<asiakkaat.length;i++){
			htmlStr+="<tr>";
			htmlStr+="<td>"+asiakkaat[i].asiakas_id+"</td>";
			htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
			htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
			htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>";
			htmlStr+="<td>"+asiakkaat[i].sposti+"</td>";
			htmlStr+="<td><a class='nod' href='muutaasiakas.jsp?asiakas_id="+asiakkaat[i].asiakas_id+"'>Muuta</a>&nbsp;";
			htmlStr+="<span class='poista nod2' onclick=poista('"+asiakkaat[i].asiakas_id+"')>Poista</span></td>";
			htmlStr+="</tr>";
		}
		
		document.getElementById("tbody").innerHTML = htmlStr;
	})
}

function poista(asiakas_id){
	if(confirm("Poista asiakas " + asiakas_id + "?")){
		fetch("asiakkaat/"+asiakas_id,{
			method: 'DELETE'
		})
		
		.then(function(response){
			return response.json()
		})
		
		.then(function(responseJson){
			var vastaus = responseJson.response;
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML = "Asiakkaan poistaminen epäonnistui!";
			} else if(vastaus ==1){
				document.getElementById("ilmo").innerHTML = "Asiakkaan " + asiakas_id + " poistaminen onnistui!";
				haeAsiakkaat();
			}
			setTimeout(function(){
				document.getElementById("ilmo").innerHTML = "";
			}, 5000);
		})
	}
}




// front end with jQuery

/*/$(document).ready(function(){	
	
	
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
} */


</script>
</body>
</html>