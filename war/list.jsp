 <%@ page isELIgnored="false" %>
 <%@ page import="java.util.*" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html>

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

		<title>__</title>

		<link type="text/css" href="css/ui-lightness/jquery-ui-1.8.11.custom.css" rel="stylesheet" />	

		<script type="text/javascript" src="js/jquery-1.5.1.min.js"></script>
		<script type="text/javascript" src="js/json2.js"></script>		
		<script type="text/javascript" src="js/jquery-ui-1.8.11.custom.min.js"></script>

	

	<c:set var="scrollwidth" value="${(fn:length(ratings)+4)*74}"/>	
	<style>
	.connectedSortable{;}
	.fixed-item{;}
	.always-fixed{;}
	.listN {background-color: #cccccc; }
	.listL {background-color: #33ff33; }
	.listD {background-color: #ff3333; }
	#demo-frame > div.demo { padding: 10px !important; }
	.scroll-pane { overflow: auto; width: 520px; float:left; }
	.scroll-content { width: ${scrollwidth}px; float: left; } 
	.scroll-content-item { padding-top:2px; width: 70px; height: 95px; float: left; margin: 1px; font-size:10px;  font-family: arial ; color:#000000;  text-align: center; font-weight: normal; line-height: 10px; overflow:hidden;}
	* html .scroll-content-item { display: inline; } /* IE6 float double margin bug */
	
	.scroll-content-item-not { padding-top:2px; width: 70px; height: 95px; float: left; margin: 1px; font-size:10px;  font-family: arial ; color:#000000;  text-align: center; font-weight: normal;}
	* html .scroll-content-item-not { display: inline; } /* IE6 float double margin bug */
	
	.scroll-bar-wrap { clear: left; padding: 0 0px 0 0px; margin: 0 -1px -1px -1px; }
	.scroll-bar-wrap .ui-slider { background-color: #ff9999;}
	.scroll-bar-wrap .ui-slider { background: none; border:0; height: 1em; margin: 0 auto;  }
	.scroll-bar-wrap .ui-handle-helper-parent { position: relative; width: 100%; height: 100%; margin: 0 auto; }
	.scroll-bar-wrap .ui-slider-handle { top:.2em; height: 1em; }
	.scroll-bar-wrap .ui-slider-handle .ui-icon { margin: -8px auto 0; position: relative; top: 50%; }
	</style>
	<script>
	//logging
	var logText = "List:";
	$(document).click( function( event ){ 
		logText = logText+ ","+ new Date().getTime()+","+event.pageX+","+event.pageY+"\n";
	});
	
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
	
	    $(function() {
	    	$("#listWidget").center();
	    	$("#newItemForSort").center();
	    	$("#direct").center();
	    	$("#mainBody").hide();
	    	$("#nextDiv").hide();
	    	$("#status").hide();
			$( "#sortable, #newItemForSort" ).sortable({
				connectWith: ".connectedSortable",
				cancel: ".fixed-item",
				items: ".scroll-content-item",
				stop: function(event, ui) {
					//console.log("${likeIndex} ${neutralIndex} and ")
					
					var index = ui.item.prevAll().length;
					
					//alert(likeIndex+" "+neutralIndex+ "and "+index);
					if(index==0)
						return;
					if(index>likeIndex){
						ui.item.removeClass('listD');
						ui.item.removeClass('listN');
						ui.item.addClass('listL');
						rate.type = 'listL';
						rate.value = index-3;
					}
					else if(index>neutralIndex){
						ui.item.removeClass('listD');
						ui.item.removeClass('listL');
						ui.item.addClass('listN');
						rate.type = 'listN';
						rate.value = index-2;
					}
					else{
						ui.item.removeClass('listN');
						ui.item.removeClass('listL');
						ui.item.addClass('listD');
						rate.type = 'listD';
						rate.value = index-1;
					}
					rate.log = logText;
					rate.endDate = new Date().getTime();
					var jr = JSON.stringify(rate)
					$('#direct').html(' ');
					$.post("/Express", "jr="+jr, function(data) {
						var results = data.split(':');
						rate.id = parseInt(results[0]);
						$("#status").html("Submitted: "+new Date(parseInt(results[1]))+" ");
						$("#nextDiv").show();
						$("#status").show();
			        });				
				}
			}).disableSelection();
		});

	$(function() {
	
		//scrollpane parts
		var scrollPane = $( ".scroll-pane" ),
			scrollContent = $( ".scroll-content" );
		
		//build slider
		var scrollbar = $( ".scroll-bar" ).slider({
			/*	step: 6,*/
			value:5,
			slide: function( event, ui ) {
				if ( scrollContent.width() > scrollPane.width() ) {
					scrollContent.css( "margin-left", Math.round(
						ui.value / 100 * ( scrollPane.width() - scrollContent.width() )
					) + "px" );
				} else {
					scrollContent.css( "margin-left", 0 );
				}
			}
		});
		
		//append icon to handle
		var handleHelper = scrollbar.find( ".ui-slider-handle" )
		.mousedown(function() {
			scrollbar.width( handleHelper.width() );
		})
		.mouseup(function() {
			scrollbar.width( "100%" );
		})
		.append( "<span class='ui-icon ui-icon-grip-dotted-vertical'></span>" )
		.wrap( "<div class='ui-handle-helper-parent'></div>" ).parent();
		
		//change overflow to hidden now that slider handles the scrolling
		scrollPane.css( "overflow", "hidden" );
		
		//size scrollbar and handle proportionally to scroll distance
		function sizeScrollbar() {
			var remainder = scrollContent.width() - scrollPane.width();
			var proportion = remainder / scrollContent.width();
			var handleSize = 15;//scrollPane.width() - ( proportion * scrollPane.width() );
			scrollbar.find( ".ui-slider-handle" ).css({
				width: handleSize,
				"margin-left": -handleSize / 2
			});
			handleHelper.width( "" ).width( scrollbar.width() - handleSize );
		}
		
		//reset slider value based on scroll content position
		function resetValue() {
			var remainder = scrollPane.width() - scrollContent.width();
			var leftVal = scrollContent.css( "margin-left" ) === "auto" ? 0 :
				parseInt( scrollContent.css( "margin-left" ) );
			var percentage = Math.round( leftVal / remainder * 100 );
			scrollbar.slider( "value", percentage );
		};
		//if the slider is 100% and window gets larger, reveal content
		function reflowContent() {
				var showing = scrollContent.width() + parseInt( scrollContent.css( "margin-left" ), 10 );
				var gap = scrollPane.width() - showing;
				if ( gap > 0 ) {
					scrollContent.css( "margin-left", parseInt( scrollContent.css( "margin-left" ), 10 ) + gap );
				}
		}
		
		//change handle position on window resize
		$( window ).resize(function() {
			resetValue();
			sizeScrollbar();
			reflowContent();
		});
		//init scrollbar size
		setTimeout( sizeScrollbar, 10 );//safari wants a timeout
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
<div id="direct" style="font-size: medium; margin-top: 15px; background-color: #ffffaa;">INSTRUCTIONS: Scroll to the position you would like to put the movie, then drag and drop it there.</div>
<div class="scroll-pane ui-widget ui-widget-header ui-corner-all" style="margin-top:60px; background-color: #000000; border-color: #000000;" id="listWidget">
	<div class="connectedSortable scroll-content" id="sortable" style="background-color: #000000; border-color: #000000;">
			<c:set var='neutrals' value="${1}" />
			<c:set var='likes' value="${1}" />
			<c:set var='dislikes' value="${1}" />
			
			
			<c:set var='prev' value='listD' />
			<div style="line-height: 70px; font-weight: bold; " class="scroll-content-item-not listD">Dislikes &gt;&gt;</div>
			<c:forEach items="${ratings}"  var="rating" varStatus="loop">
				<c:if test="${prev=='listD' && rating.type != 'listD'}">
					<div style="line-height: 70px; font-weight: bold; " class="scroll-content-item listN fixed-item">Neutrals &gt;&gt;</div>
					<c:set var='prev' value='listN' />
				</c:if>
				<c:if test="${prev=='listN'&&  rating.type != 'listN'}">
					<div style="line-height: 70px; font-weight: bold; " class="scroll-content-item listL fixed-item">Likes &gt;&gt;</div>
					<c:set var='prev' value='listL' />
				</c:if>
				<div class="scroll-content-item ${rating.type} fixed-item"><img src="/img/${rating.movieId}.jpg"/><div style="" >${rating.movieName}</div></div>
				
				<c:if test="${rating.type == 'listN'}">
					<c:set var='neutrals' value="${neutrals+1}" />
				</c:if>
				<c:if test="${rating.type == 'listL'}">
					<c:set var='likes' value="${likes+1}" />
				</c:if>
				<c:if test="${rating.type == 'listD'}">
					<c:set var='dislikes' value="${dislikes+1}" />
				</c:if>
			</c:forEach>
				<c:if test="${prev=='listD'}">
					<div style="line-height: 70px; font-weight: bold; " class="scroll-content-item listN fixed-item">Neutrals &gt;&gt;</div>
					<div style="line-height: 70px; font-weight: bold; " class="scroll-content-item listL fixed-item">Likes &gt;&gt;</div>
				</c:if>
				<c:if test="${prev=='listN'}">
					<div style="line-height: 70px; font-weight: bold; " class="scroll-content-item listL fixed-item">Likes &gt;&gt;</div>
				</c:if>
		<script> 
		var likeIndex = "${dislikes + neutrals}"; 
		var neutralIndex = "${dislikes}";
		</script>
	</div>
	<div class="scroll-bar-wrap ui-widget-content ui-corner-bottom" style="height:1.4em;" >
		<div style="margin:0; float: left; background-color:#ff6666; height:100%; width:${(dislikes*100)/(likes+dislikes+neutrals)}%"></div>
		<div style="margin:0; float: left; background-color:#cccccc; height:100%; width:${(neutrals*100)/(likes+dislikes+neutrals)}%"></div>	
		<div style="margin:0; float: left; background-color:#66ff66; height:100%; width:${(likes*100)/(likes+dislikes+neutrals)}%"></div>		
		
		<div class="scroll-bar">
		
		
		</div>
	
	</div>
</div>



<div id="newItemForSort" class="connectedSortable" style="margin-left:-70px; margin-top:210px; padding: 70px; width: 80px; height: 100px; background-color: #eeeeee; ">
	<div id="draggable"  class="scroll-content-item listN"><img src="/img/${newrating.movieId}.jpg" align="middle"/><div style="" >${newrating.movieName}</div></div>
</div>
<div id="nextDiv" style="position: absolute; bottom: 100px; right: 0px;">
<a href="${nexturl}"><img src='css/next.png'/></a>
</div>
 </div>
</body>
</html>