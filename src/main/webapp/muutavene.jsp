<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style>
table {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;  
  width: 50%;
}

table td, table th {
  border: 1px solid #ddd;
  padding: 8px;  
}

table tbody tr:nth-child(even){background-color: #f2f2f2;}

table tbody tr:hover {background-color: #ddd;}

table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: black;
  color: red;
}

.poista{
	color: red;
	text-decoration: underline;
	cursor: pointer;	
}

#uusiVene, #takaisin{
	color: white;	
	cursor: pointer;	
}

</style>
<title>Tietojen muutos</title>
</head>
<body>
<form id="tiedot">
	<table class="table">
		<thead>
			<tr>
				<th colspan="5"><a id="takaisin" href="listaaveneet.jsp">Takaisin listaukseen</a></th>
			</tr>
			<tr>
				<th>Nimi</th>
				<th>Merkkimalli</th>
				<th>Pituus</th>
				<th>Leveys</th>			
				<th>Hinta</th>
			</tr>
		</thead>
			<tr>
				<td><input type="text" name="nimi" id="nimi"></td>
				<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
				<td><input type="text" name="pituus" id="pituus"></td>
				<td><input type="text" name="leveys" id="leveys"></td>
				<td><input type="text" name="hinta" id="hinta"></td>			
				<td><input type="submit" value="Tallenna" id="tallenna"></td>
			</tr>
		<tbody>
		</tbody>
	</table>
	<input type="hidden" name="tunnus" id="tunnus">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	$("#nimi").focus();

	var tunnus = requestURLParam("tunnus");
	$.ajax({url:"veneet/haeyksi/"+tunnus, type:"GET", dataType:"json", success:function(result){	
		$("#nimi").val(result.nimi);	
		$("#merkkimalli").val(result.merkkimalli);
		$("#pituus").val(result.pituus);
		$("#leveys").val(result.leveys);
		$("#hinta").val(result.hinta);
		$("#tunnus").val(result.tunnus);		
    }});
	
	$("#tiedot").validate({						
		rules: {
			nimi:  {
				required: true,				
				minlength: 2				
			},	
			merkkimalli:  {
				required: true,				
				minlength: 1				
			},
			pituus:  {
				required: true
			},	
			leveys:  {
				required: true			
			},	
			hinta:	{
				required: true
			}
		},
		messages: {
			nimi: {     
				required: "Puuttuu",				
				minlength: "Liian lyhyt"			
			},
			merkkimalli: {
				required: "Puuttuu",				
				minlength: "Liian lyhyt"
			},
			pituus: {
				required: "Puuttuu"
			},
			leveys: {
				required: "Puuttuu"
			},
			hinta:	{
				required: "Puuttuu"
			}
		},			
		submitHandler: function(form) {	
			vieTiedot();
		}
	});   
});

function vieTiedot(){ 
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); 
	$.ajax({url:"veneet", data:formJsonStr, type:"PUT", success:function(result) {
		if(result.response==0){
      	$("#ilmo").html("Tietojen päivitys epäonnistui.");
      }else if(result.response==1){
      	$("#ilmo").html("Tietojen päivitys onnistui.");
		}
  }});
}
</script>
</html>