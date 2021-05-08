<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="scripts/main2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" type="text/css" href="styles2.css">

<title>Uusi asiakas</title>
</head>
<body onkeydown="tutkiNappain(event)">

<form id="tiedot">
	<table class="uusi-asiakas">
		<thead>
			<tr>
			<th colspan="3" id="ilmo"></th>
				<th colspan="4" class="oikealle"><a href="listaaasiakkaat.jsp" id="takaisin" class="back">Takaisin listaukseen</a></th>
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
				<td> <input type="button" class="lisaa" name="nappi" id="tallenna" value="Lisää" onclick="lisaaAsiakas()"></td>
			</tr>
		</tbody>
	</table>
</form>

<span class="ilmo" id="ilmo"></span>

</body>
<script>


//front end with Javascript

function tutkiNappain(event){
	if(event.keyCode==13){
		lisaaAsiakas();
	}
}

document.getElementById("asiakas_id").focus();

function lisaaAsiakas(){
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
	
	
	var formJsonStr=formDataJsonStr(document.getElementById("tiedot"));
	
	fetch("asiakkaat/",{
		method: 'POST',
		body:formJsonStr
	})
	.then(function(reponse){
		return reponse.json()
	})
	
	.then(function(responseJson){
			var vastaus = responseJson.response;
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML = "Asiakkaan lisääminen epäonnistui!";
			} else if(vastaus ==1){
				document.getElementById("ilmo").innerHTML = "Asiakkaan lisääminen onnistui!";
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
			lisaaTiedot();
		}
	});
});

function lisaaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType: "json", success:function(result){
		if(result.response==0){
			$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
		} else if(result.response==1){
			$("#ilmo").html("Asiakkaan lisääminen onnistui.");
			$("#asiakas_id", "#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		} 
		
	}});
	
} */

</script>
</html>