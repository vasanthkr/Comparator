 <%@ page isELIgnored="false" %>
 <%@ page import="java.util.*" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html>

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

		<title>__</title>

		<link type="text/css" href="css/ui-lightness/jquery-ui-1.8.11.custom.css" rel="stylesheet" />	
		<link type="text/css" href="css/jquery.rating.css" rel="stylesheet" />

		<script type="text/javascript" src="js/jquery-1.5.1.min.js"></script>
		<script type="text/javascript" src="js/json2.js"></script>			
		<script type="text/javascript" src="js/jquery-ui-1.8.11.custom.min.js"></script>
		<script type="text/javascript" src="js/jquery.rating.pack.js"></script>	
		<script type="text/javascript" src="js/jquery.MetaData.js"></script>
	<style>
	.scroll-content-item { width: 70px; height: 95px; float: left; margin: 1px; font-size:10px;  font-family: arial; color:#000000;  text-align: center; }
	* html .scroll-content-item { display: inline; } /* IE6 float double margin bug */
	</style>
	<script>
	
	function RatingWidget()
	{
	    this.id = 0;
	    this.value = 0;
	    this.type = "";
	    this.log = "";
	    this.movieId = 0;
	    this.movieName = "";
	    this.userId = 0;
	    this.startDate=0;
		this.endDate=0;
		this.year=0;
	}

	
	var rate = new RatingWidget();
	rate.movieId = "${newrating.movieId}"; 
	rate.userId = "${newrating.userId}";
	rate.type = "stars";
	$(function() {
		
		$("#first${V1}").attr("checked", "checked");
		$('#hoverTip').html($("#first${V1}").attr("title"));
		$("#first${V1}").click();
		$("#first${V1}").button('refresh');
		$("#second${V2}").attr("checked", "checked");
		$('#hoverTip2').html($("#second${V2}").attr("title"));
		$("#second${V2}").click();
		$("#second${V2}").button('refresh');
		$("#third${V3}").attr("checked", "checked");
		$('#hoverTip3').html($("#third${V3}").attr("title"));
		$("#third${V3}").click();
		$("#third${V3}").button('refresh');
		$('.star1').rating();
		$('.star2').rating();
		$('.star3').rating();
		
		//{
			/* focus: function(value, link){
				    var tip = $('#hoverTip');
				    tip[0].data = tip[0].data || tip.html();
				    tip.html(link.title || 'value: '+value);
				  },
				  blur: function(value, link){
				    var tip = $('#hoverTip');
				    $('#hoverTip').html(tip[0].data || '');
				  }
			})*/
		});
	
		

	
	</script>

</head>
<body>
 
<div id="direct" style="font-size: medium; background-color: #ffffaa;"> INSTRUCTIONS: Click on the appropriate star.</div>	
<table><tr>
<td>
<div id="draggable" class="scroll-content-item"><img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div></div>


<div id="starsList" style="float:left;">

			<input type="radio" name="newrate1" class="star1 {split:2}" title="0.5" style="margin-left: 75px" id="first1" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="1" style="margin-left: 75px" id="first2" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="1.5" style="margin-left: 75px" id="first3" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="2" style="margin-left: 75px" id="first4" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="2.5" style="margin-left: 75px" id="first5" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="3" style="margin-left: 75px" id="first6" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="3.5" style="margin-left: 75px" id="first7" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="4" style="margin-left: 75px" id="first8" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="4.5" style="margin-left: 75px" id="first9" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="5" style="margin-left: 75px" id="first10" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="5.5" style="margin-left: 75px" id="first11" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="6" style="margin-left: 75px" id="first12" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="6.5" style="margin-left: 75px" id="first13" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="7" style="margin-left: 75px" id="first14" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="7.5" style="margin-left: 75px" id="first15" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="8" style="margin-left: 75px" id="first16" disabled="disabled" />
            <input type="radio" name="newrate1" class="star1 {split:2}" title="8.5" style="margin-left: 75px" id="first17" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="9" style="margin-left: 75px" id="first18" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="9.5" style="margin-left: 75px" id="first19" disabled="disabled"/>
            <input type="radio" name="newrate1" class="star1 {split:2}" title="10" style="margin-left: 75px" id="first20" disabled="disabled"/>
</div>
<div id="hoverTip" style="float:left; font-size: large;">__</div>

</td></tr>
<tr><td style="background-color: #cccccc; height: 50px;">&nbsp;
</td></tr>

<tr><td>
<div class="scroll-content-item"><img src="/img/${D1.movieId}.jpg" align="middle"/><div style="" >${D1.movieName}</div></div>
<div class="scroll-content-item"><img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div></div>
<div class="scroll-content-item"><img src="/img/${D2.movieId}.jpg" align="middle"/><div style="" >${D2.movieName}</div></div>
</td></tr>
<tr><td><img src="css/recar.png"/></td></tr>
<tr><td style="background-color: #000000; height: 400px;" >&nbsp;
</td></tr>
<tr><td>

<div id="draggable2" class="scroll-content-item"><img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div></div>


<div id="starsList2" style="float:left;">

	       <input type="radio" name="newrate2" class="star2 {split:2}" title="0.5" style="margin-left: 75px" id="second1" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="1" style="margin-left: 75px" id="second2" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="1.5" style="margin-left: 75px" id="second3" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="2" style="margin-left: 75px" id="second4" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="2.5" style="margin-left: 75px" id="second5" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="3" style="margin-left: 75px" id="second6" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="3.5" style="margin-left: 75px" id="second7" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="4" style="margin-left: 75px" id="second8" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="4.5" style="margin-left: 75px" id="second9" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="5" style="margin-left: 75px" id="second10" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="5.5" style="margin-left: 75px" id="second11" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="6" style="margin-left: 75px" id="second12" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="6.5" style="margin-left: 75px" id="second13" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="7" style="margin-left: 75px" id="second14" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="7.5" style="margin-left: 75px" id="second15" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="8" style="margin-left: 75px" id="second16" disabled="disabled" />
            <input type="radio" name="newrate2" class="star2 {split:2}" title="8.5" style="margin-left: 75px" id="second17" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="9" style="margin-left: 75px" id="second18" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="9.5" style="margin-left: 75px" id="second19" disabled="disabled"/>
            <input type="radio" name="newrate2" class="star2 {split:2}" title="10" style="margin-left: 75px" id="second20" disabled="disabled"/>
</div>
<div id="hoverTip2" style="float:left; font-size: large;">__</div>

</td></tr>
<tr><td style="background-color: #cccccc; height: 50px;">&nbsp;
</td></tr>

<tr><td>
<div class="scroll-content-item"><img src="/img/${N1.movieId}.jpg" align="middle"/><div style="" >${N1.movieName}</div></div>
<div class="scroll-content-item"><img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div></div>
<div class="scroll-content-item"><img src="/img/${N2.movieId}.jpg" align="middle"/><div style="" >${N2.movieName}</div></div>
</td></tr>
<tr><td><img src="css/recar.png"/></td></tr>
<tr><td style="background-color: #000000; height: 400px;">&nbsp;
</td></tr>
<tr><td>

<div id="draggable3" class="scroll-content-item"><img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div></div>


<div id="starsList3" style="float:left;">

	       <input type="radio" name="newrate3" class="star3 {split:2}" title="0.5" style="margin-left: 75px" id="third1" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="1" style="margin-left: 75px" id="third2" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="1.5" style="margin-left: 75px" id="third3" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="2" style="margin-left: 75px" id="third4" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="2.5" style="margin-left: 75px" id="third5" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="3" style="margin-left: 75px" id="third6" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="3.5" style="margin-left: 75px" id="third7" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="4" style="margin-left: 75px" id="third8" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="4.5" style="margin-left: 75px" id="third9" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="5" style="margin-left: 75px" id="third10" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="5.5" style="margin-left: 75px" id="third11" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="6" style="margin-left: 75px" id="third12" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="6.5" style="margin-left: 75px" id="third13" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="7" style="margin-left: 75px" id="third14" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="7.5" style="margin-left: 75px" id="third15" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="8" style="margin-left: 75px" id="third16" disabled="disabled" />
            <input type="radio" name="newrate3" class="star3 {split:2}" title="8.5" style="margin-left: 75px" id="third17" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="9" style="margin-left: 75px" id="third18" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="9.5" style="margin-left: 75px" id="third19" disabled="disabled"/>
            <input type="radio" name="newrate3" class="star3 {split:2}" title="10" style="margin-left: 75px" id="third20" disabled="disabled"/>
</div>
<div id="hoverTip3" style="float:left; font-size: large;">__</div>
</td></tr>
<tr><td style="background-color: #cccccc; height: 50px;">&nbsp;
</td></tr>

<tr><td>
<div class="scroll-content-item"><img src="/img/${L1.movieId}.jpg" align="middle"/><div style="" >${L1.movieName}</div></div>
<div class="scroll-content-item"><img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div></div>
<div class="scroll-content-item"><img src="/img/${L2.movieId}.jpg" align="middle"/><div style="" >${L2.movieName}</div></div>
</td></tr>
<tr><td><img src="css/recar.png"/></td></tr>


</table>
 
</body>
</html>