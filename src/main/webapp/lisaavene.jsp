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
<title>Veneen lisäys</title>
</head>
<body>
<form id="tiedot">
	<table>
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
			<th></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><input type="text" name="nimi" id="nimi"></td>
			<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
			<td><input type="text" name="pituus" id="pituus"></td>
			<td><input type="text" name="leveys" id="leveys"></td> 
			<td><input type="text" name="hinta" id="hinta"></td> 
			<td><input type="submit" id="tallenna" value="Lisää"></td>
		</tr>
	</tbody>
	</table>
</form>
<span id="ilmo"></span>
<script>
$(document).ready(function(){

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
			lisaaTiedot();
		}		
	});  
	$("#nimi").focus(); 
});
function lisaaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	console.log(formJsonStr);
	$.ajax({url:"veneet", data:formJsonStr, type:"POST", dataType:"json", success:function(result) {
		if(result.response==0){
        	$("#ilmo").html("Veneen lisääminen epäonnistui.");
        }else if(result.response==1){			
        	$("#ilmo").html("Veneen lisääminen onnistui.");
        	$("#nimi, #merkkimalli, #pituus, #leveys, #hinta").val("");
		}
    }});	
}
</script>
</body>
</html>