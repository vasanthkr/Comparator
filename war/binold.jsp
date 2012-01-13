<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page isELIgnored="false" %>
 <%@ page import="java.util.*" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Binary Selection</title>
        
    <style>
    .scroll-content-item { float: left; display: inline; cursor: pointer; padding-top:2px; width: 70px; height: 95px; float: left; margin: 20px; font-size:10px;  font-family: arial ; color:#000000;  text-align: center; font-weight: normal; line-height: 10px;}
	* html .scroll-content-item { display: inline; } /* IE6 float double margin bug */
	
 
	.scroll-content-item :hover { background-color: #CCFFCC;}
	#back {
    color: #000000;
    z-index: 2;
    margin-left: -14px;
    margin-top: -10px;
	}
    </style>
	<script type="text/javascript" src="js/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.progressbar.min.js"></script>
	<script type="text/javascript">
	var logText = "";
	jQuery.fn.center = function () {
	    this.css("position","absolute");
	    //this.css("top", ( $(window).height() - this.height() ) / 2+$(window).scrollTop() + "px");
	    this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
	    return this;
	}
	function Rating()
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

	
	var rate = new Rating();
	rate.movieId = "${newrating.movieId}"; 
	rate.userId = "${newrating.userId}";
	rate.type = "bin";
	var ratingList = [];
	var counter=0;
	<c:forEach items="${ratings}"  var="rating" varStatus="loop">
		ratingList[counter] = new Rating();
		ratingList[counter].movieId = ${rating.movieId};
		ratingList[counter].movieName = "${rating.movieName}";
		counter++;
	</c:forEach>
	var listSize = counter; 
	function postResult(index){
		rate.value = index;
		rate.log = logText;
        rate.endDate = new Date().getTime();
		var jr = JSON.stringify(rate)
		
		$.post("/Express", "jr="+jr, function(data) {
			
			var results = data.split(':');
			rate.id = parseInt(results[0]);
			$("#status").html("Submitted: "+new Date(parseInt(results[1]))+" ");
	    	$("#binprogress").progressBar(100);
	    	$("#nextDiv").show();
        });
	};
	$(function() {
    	$("#binary-rate").center();
    	$("#progressInfo").center();
    	$("#direct").center();
		$("#mainBody").hide();
		$("#nextDiv").hide();
 	 });
	  $(document).ready(function(){
		  
	      var stepEstimate = Math.ceil(Math.log(listSize+1) / Math.log(2));
	      $("#binprogress").progressBar();

	      for (var i=0; i < listSize; i++){
	    	  
		  
	    	  $("#binary-rate").append('<li id="movie-' 
					   + i 
					   + '" class="scroll-content-item"><img src="/img/'
					   + ratingList[i].movieId+'.jpg"align="middle"/><div style="" >'
					   + ratingList[i].movieName+'</div></li>');	  
					  	  
	    /*$("#binary-rate").append('<li id="movie-' 
					   + i 
					   + '" class="movie-entry"><div class="movie-name">' 
					   + ratingList[i].movieName 
					   + '</div><div class="thumbnail">'
					   + '<img src="/img/'+ratingList[i].movieId+'.jpg" /></div></li>');*/
		  $("#movie-"+i).hide();
		  $("#back").hide();
		  $("#movie-"+i).click(function() {
		      $("#back").show();
		      $("#movie-"+m).fadeOut(200);
		      history = history + 1;
		      $("#binprogress").progressBar(Math.ceil((history-1)*100/stepEstimate));
		      hist_a[history] = a;
		      hist_b[history] = b;
		      hist_m[history] = m;
		      if(a >= b || a == m){
		    	  postResult(m);
		    	  
		    	}
		      else {
			  b = m - 1;
			  m = a + Math.floor((b - a)/2);
			  $("#movie-"+m).delay(300).fadeIn(200);
		      }
		  });
	      };

	      var a = 0;
	      var b = listSize - 1;
	      var m = Math.ceil((b - a)/2);
	      var hist_a = new Array();
	      var hist_b = new Array();
	      var hist_m = new Array();
	      var history = 1;
	      hist_a[history] = a;
	      hist_b[history] = b;
	      hist_m[history] = m;	
	      $("#movie-"+m).show();

	      $("#to-rate").click(function() {
		  $("#back").show();
		  $("#movie-"+m).fadeOut(200);
		  history = history + 1;
		  $("#binprogress").progressBar(Math.ceil((history-1)*100/stepEstimate));
		  hist_a[history] = a;
		  hist_b[history] = b;
		  hist_m[history] = m;
		  if(a >= b){
			  postResult(a+1);
			}
		  else {
		      a = m + 1;
		      m = a + Math.floor((b - a)/2);
		      $("#movie-"+m).delay(300).fadeIn(200);
		  }
	      });


	      $("#back").click(function() {
		  $("#movie-"+m).fadeOut(200);		  
		  history = history - 1;
		  if(history == 1){$("#back").hide()};
		  $("#binprogress").progressBar(Math.ceil((history-1)*100/stepEstimate));
		  a = hist_a[history];
		  b = hist_b[history];
		  m = hist_m[history];
		  $("#movie-"+m).delay(300).fadeIn(200);
	      });
	      
	      
	  });
	//logging
	
	$(document).click( function( event ){ 
		logText = logText+ ","+ new Date().getTime()+","+event.pageX+","+event.pageY+"\n";
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
<img src="/img/${newrating.movieId}.jpg"/>
<div style=" font-size:medium;" >${newrating.movieName}</div>
<a href="javascript:showPrototype();" style="font-size: large; color: blue;"> Click here to express your opinion</a>
</div>

<div id="mainBody">
<div style="margin-right:20%; margin-left:20%; height:30px; background-color:#ffff44; text-align: center;" id="status"></div> 

    <div id="direct" style="font-size: medium; margin-top: 15px;"> Which one do you like more?
      <!-- <img src="img/whichbetter.png" />  -->
    </div>

    <ul id="binary-rate" style="margin-top:50px; margin-left:-50px;">           
      <li id="to-rate" class="scroll-content-item">
      <img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div>  
<!--  	<div class="movie-name">${newrating.movieName}</div>
	<div class="thumbnail"><img src="img/${newrating.movieId}.jpg" /></div>
-->      </li>
    </ul>  
    
    <div class="information" id="progressInfo" style="margin-top:200px; margin-left:-50px; height: 70">
      <a id="back" style="cursor: pointer;"><img src="css/prev.png" align="middle" style=" width: 30px; height: 30px;"/> Previous Step</a>
      <span class="progressBar" id="binprogress">0%</span>
    </div>
  <div id="nextDiv" style="position: absolute; bottom: 100px; right: 0px;">
<a href="${nexturl}"><img src='css/next.png'/></a>
</div>
</div>      
   </body>
</html>
