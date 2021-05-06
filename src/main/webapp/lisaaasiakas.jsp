<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" href="styles.css">


<title>Uusi asiakas</title>
</head>
<body>

<form id="tiedot">
	<table class="uusi-asiakas">
		<thead>
			<tr>
				<th colspan="6" class="oikealle"><span class="takaisin" id="takaisin">Takaisin listaukseen</span>
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
				<td> <input type="text" name="Asiakas_id" id="asiakas_id"></td>
				<td> <input type="text" name="Etunimi" id="etunimi"></td>
				<td> <input type="text" name="Sukunimi" id="sukunimi"></td>
				<td> <input type="text" name="Puhelin" id="puhelin"></td>
				<td> <input type="text" name="Sposti" id="sposti"></td>
				<td> <input class="lisaa" type="submit" id="tallenna" value="Lisää"></td>
			</tr>
		</tbody>
	</table>
</form>

<span class="ilmo" id="ilmo"></span>

</body>
<script>

$(document).ready(function(){
	
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
	
}

</script>
</html>