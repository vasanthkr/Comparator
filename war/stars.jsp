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
	var logText = "Stars:";

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

	
	var rate = new RatingWidget();
	rate.movieId = "${newrating.movieId}"; 
	rate.userId = "${newrating.userId}";
	rate.type = "stars";
	$(function() {
		$('.auto-submit-star').rating({
			 focus: function(value, link){
				    var tip = $('#hoverTip');
				    tip[0].data = tip[0].data || tip.html();
				    tip.html(link.title || 'value: '+value);
				  },
				  blur: function(value, link){
				    var tip = $('#hoverTip');
				    $('#hoverTip').html(tip[0].data || '');
				  },
			callback: function(value, link){
		        rate.value = value;
		        rate.log = logText;
		        rate.endDate = new Date().getTime();
				var jr = JSON.stringify(rate)
					
				$.post("/Express", "jr="+jr, function(data) {
					var results = data.split(':');
					rate.id = parseInt(results[0]);
					$("#status").show();
					$("#status").html("Submitted: "+new Date(parseInt(results[1]))+" ");
					$("#nextDiv").show();
			        });				
				}
			})
		});
	
	
	//logging
	
	$(document).click( function( event ){ 
		logText = logText+ ","+ new Date().getTime()+","+event.pageX+","+event.pageY+"\n";
	});
	$(function() {
		
    	$("#starsList").center();
    	$("#newItemForSort").center();
    	$("#direct").center();
    	
    	$("#mainBody").hide();
    	$("#nextDiv").hide();
    	$("#status").hide();
 	 });		
	function showPrototype() {
		$("#startBody").hide();
		$("#mainBody").show();
		logText = logText + ",Start:"+ new Date().getTime()+"\n";
		rate.startDate = new Date().getTime();
	};
	
	</script>

</head>
<body>
<div id="startBody" style="text-align: center;">
<img src="/img/${newrating.movieId}.jpg" align="middle"/>
<div style=" font-size:medium;" >${newrating.movieName}</div>
<a href="javascript:showPrototype();" style="font-size: large;"> Click here to express your opinion about this movie</a>
</div>

<div id="mainBody">


<div style="margin-right:20%; margin-left:20%; height:30px; background-color:#ffff44; text-align: center;" id="status"></div> 
    <div id="direct" style="font-size: medium; margin-top: 15px; background-color: #ffffaa;"> INSTRUCTIONS: Click on the appropriate star.</div>	
<div id="newItemForSort" class="connectedSortable" style="margin-top: 50px;">
	<div id="draggable" class="scroll-content-item listN"><img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div></div>
</div>

<div id="starsList" style="margin-top: 190px;">

	       <input type="radio" name="newrate" class="auto-submit-star" title="1" style="margin-left: 75px" value="1"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="2" style="margin-left: 75px" value="2"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="3" style="margin-left: 75px" value="3"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="4" style="margin-left: 75px" value="4"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="5" style="margin-left: 75px" value="5"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="6" style="margin-left: 75px" value="6"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="7" style="margin-left: 75px" value="7"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="8" style="margin-left: 75px" value="8"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="9" style="margin-left: 75px" value="9"/>
            <input type="radio" name="newrate" class="auto-submit-star" title="10" style="margin-left: 75px" value="10"/>
</div>
<div id="hoverTip" style="position:absolute; margin-left:150px; margin-top:200px; font-size: large;">__</div>
<p>&nbsp;</p>    
<div id="nextDiv" style="position: absolute; bottom: 100px; right: 0px;">
<a href="${nexturl}"><img src='css/next.png'/></a>
</div>
</div>
 
</body>
</html>