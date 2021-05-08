<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" type="text/css" href="styles2.css">

<meta charset="UTF-8">
<title>Asiakkaan muutos</title>
</head>
<body onkeydown="tutkiNappain(event)">


<form id="tiedot">
	<table class="uusi-asiakas">
		<thead>
			<tr>
				
				<th colspan="5" id="ilmo"></th>
				<th colspan="7" ><a href="listaaasiakkaat.jsp" id="takaisin" class="oikealle back">Takaisin listaukseen</a></th>
			</tr>
		
			<tr>
				<th>Asiakas_id</th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td> <input type="text" name="asiakas_id" id="asiakas_id"></td>
				<td> <input type="text" name="etunimi" id="etunimi"></td>
				<td> <input type="text" name="sukunimi" id="sukunimi"></td>
				<td> <input type="text" name="puhelin" id="puhelin"></td>
				<td> <input type="text" name="sposti" id="sposti"></td>
				<td> <input class="lisaa" type="button" id="tallenna" value="Hyväksy muutos" onclick="muutaTiedot()"></td>
			</tr>
		</tbody>
	</table>
	
	<input type="hidden" name="vanhaasiakas_id" id="vanhaasiakas_id">
	
</form>

<span class="ilmo" id="ilmo"></span>

</body>

<script>

//front end with Javascript

function tutkiNappain(event){
	if(event.keyCode==13){
		muutaTiedot();
	}
}


document.getElementById("asiakas_id").focus();

var asiakas_id = requestURLParam("asiakas_id");
fetch("asiakkaat/haeyksi/" + asiakas_id,{
	method: 'GET'
})

.then(function(response){
	return response.json()
})

.then(function(responseJSON){
	document.getElementById("asiakas_id").value = responseJSON.asiakas_id;
	document.getElementById("etunimi").value = responseJSON.etunimi;
	document.getElementById("sukunimi").value = responseJSON.sukunimi;
	document.getElementById("puhelin").value = responseJSON.puhelin;
	document.getElementById("sposti").value = responseJSON.sposti;
	document.getElementById("vanhaasiakas_id").value = responseJSON.asiakas_id
});

function muutaTiedot(){
	var ilmo = "";
	if(document.getElementById("asiakas_id").value.length<1){
		ilmo="Asiakas id ei kelpaa!";
		
	} else if(document.getElementById("etunimi").value.length<3){
		ilmo="Syötetty etunimi on liian lyhyt"
		
	} else if(document.getElementById("sukunimi").value.length<3){
		ilmo="Syötetty sukunimi on liian lyhyt"
	
	} else if(document.getElementById("puhelin").value.length < 10 && document.getElementById("puhelin").value.length > 11){
		ilmo="Syötetty puhelinnumero ei kelpaa"
	
	} else if(document.getElementById("sposti").value.length<5){
		ilmo="Syötetty sähköpostiosoite on liian lyhyt"
	}
	
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML = ilmo;
		setTimeout(function(){document.getElementById("ilmo").innerHTML = "";}
		, 4000)
		return;
	}
	
	
	document.getElementById("asiakas_id").value;/*=siivoa(document.getElementById("asiakas_id").value);  Siivoa ei jostain syystä toiminut error: Uncaught ReferenceError: siivoa is not defined*/ 
	document.getElementById("etunimi").value;/*siivoa(document.getElementById("etunimi").value);*/
	document.getElementById("sukunimi").value;/*=siivoa(document.getElementById("sukunimi").value);*/
	document.getElementById("puhelin").value;/*siivoa(document.getElementById("puhelin").value);*/
	document.getElementById("sposti").value;/*siivoa(document.getElementById("sposti").value);*/
	
	var formJsonStr=formDataJsonStr(document.getElementById("tiedot"))
	
	fetch("asiakkaat",{
		method: 'PUT',
		body: formJsonStr
	})
	
	.then(function(reponse){
		return reponse.json()
	})
	
	.then(function(responseJson){
			var vastaus = responseJson.response;
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML = "Asiakkaan muuttaminen epäonnistui!";
			} else if(vastaus ==1){
				document.getElementById("ilmo").innerHTML = "Asiakkaan muuttaminen onnistui!";
			}
			setTimeout(function(){
				document.getElementById("ilmo").innerHTML = "";
			}, 5000);
		});
		
	document.getElementById("tiedot").reset();
	
}



// front end with jQuery
	
/* $(document).ready(function(){
	
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	var asiakas_id = requestURLParam("asiakas_id");
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){
		
		$("#vanhaasiakas_id").val(result.asiakas_id);
		$("#asiakas_id").val(result.asiakas_id);
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);
		
		console.log(asiakas_id);
		console.log(result.asiakas_id);
		
	
	}});
	
	
	$("#tiedot").validate({
		rules: {
			Asiakas_id: {
				required: true,
				minlength: 1
			},
			
			Etunimi: {
				required: true,
				minlength: 3
			},
			
			Sukunimi: {
				required: true,
				minlength: 3
			},
			
			Puhelin: {
				required: true,
				minlength: 10,
				maxlength: 11
			},
			
			Sposti: {
				required: true,
				minlength: 5
			}
			
		},
		
		messages:  {
			Asiakas_id: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			
			Etunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			
			Sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			
			Puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			
			Sposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},
		
		submitHandler: function(form){
			muutaTiedot();
		}
	});
});

function muutaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType: "json", success:function(result){
		if(result.response==0){
			$("#ilmo").html("Asiakkaan muuttaminen epäonnistui.");
		} else if(result.response==1){
			$("#ilmo").html("Asiakkaan muuttaminen onnistui.");
			$("#asiakas_id", "#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		} 
		
	}});
	
} */
</script>

</html>