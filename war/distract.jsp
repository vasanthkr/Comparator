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
		<script type="text/javascript" src="js/jquery.cycle.all.min.js"></script>
		<script type="text/javascript" src="js/jquery.MetaData.js"></script>
	<style>
	
	.scroll-content-item { width: 120px; height: 250px; float: left; margin: 1px; font-size:10px;  font-family: arial; color:#000000;  text-align: center; }
	* html .scroll-content-item { display: inline; } /* IE6 float double margin bug */
	</style>
	<script>
	var logText = "Dist:";
	var inter, clickInter;
	jQuery.fn.center = function () {
	    this.css("position","absolute");
	    //this.css("top", ( $(window).height() - this.height() ) / 2+$(window).scrollTop() + "px");
	    this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
	    return this;
	}
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

	var readyToGo = false;
	var rate = new RatingWidget();
	rate.userId = "${newrating.userId}";
	rate.type = "dist";
	function finished(){
		        rate.log = logText;
		        rate.endDate = new Date().getTime();
				var jr = JSON.stringify(rate)
					
				$.post("/Express", "jr="+jr, function(data) {
					var results = data.split(':');
					rate.id = parseInt(results[0]);
					$("#status").html("You can go to the next step! ");
					$("#nextDiv").show();
					$("#status").show();
					$('#slideshow').cycle('pause');
			        });				
				};
	
	function timingDone(){
		window.clearInterval(inter);
		readyToGo = true;
	}
	//logging
	$(document).click( function( event ){ 
		logText = logText+ ","+ new Date().getTime()+","+event.pageX+","+event.pageY+"\n";
		
	});
	$(function() {
		$('#direct').center();
		$('#thisButton').center();
		
    	//$("#mainBody").hide();
    	$("#nextDiv").hide();
    	$("#status").hide();
 	 });		
	function showPrototype() {
		//$("#startBody").hide();
		//$("#mainBody").show();
		logText = logText + ",Start:"+ new Date().getTime()+"\n";
		rate.startDate = new Date().getTime();
		$('#slideshow').cycle('resume');
		inter = window.setInterval('timingDone()',20000);
	};
	function clickThisOne() {
		//alert('here bef');
		$('#thisImage').attr('width',74);
		//alert('here aft');
		logText = logText + ",this"+ new Date().getTime()+"\n";
		if(readyToGo)
			finished();
		clickInter = window.setInterval('clickBack()',30);
		
	};
	function clickBack(){
		$('#thisImage').attr('width',96);
		window.clearInterval(clickInter);
	}
	
	$(document).ready(function() {
		$('#slideshow').cycle({
			fx: 'fade', // choose your transition type, ex: fade, scrollUp, shuffle, etc...
			speed: 50,
			timeout:1000
	    }).cycle('pause');
	    $('#slideshow').center();
	});
	
	</script>

</head>
<body>
<div>



<div style="margin-right:20%; margin-left:20%; height:30px; background-color:#ffff44; text-align: center;" id="status"></div> 
<div style=" font-size:medium; background-color: #ffffaa;" id="direct">
Click on the red button when the current movie repeats what you saw 2 movies ago.
<p align="center"><a href="javascript:showPrototype();" style="font-size: large;"> Click here to start</a></p>
</div>
<div id="slideshow" style="margin-top:100;" >
    <c:forEach items="${ratings}"  var="rating" varStatus="loop">
		
	<div class="scroll-content-item" style=" background-color: #eeeeee; "><img src="/img/b/${rating.movieId}.jpg" /><div style="font-size: small;" >${rating.movieName}</div></div>
	
	</c:forEach>
</div>
<a href="javascript:clickThisOne();" id="thisButton" style="margin-top:350px; width: 80px;"><img id="thisImage" src='css/red.png'/></a>
<div id="nextDiv" style="position: absolute; bottom: 100px; right: 0px;">
<a href="${nexturl}"><img src='css/next.png'/></a>
</div>
</div>
 
</body>
</html>