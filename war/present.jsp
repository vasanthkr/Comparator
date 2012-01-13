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
			
		
	<style>
	
	.scroll-content-item { padding-top:2px; width: 70px; height: 120px; font-size:10px;  font-family: arial ; color:#000000;  text-align: center; font-weight: normal; line-height: 10px;}	
/*	.listN {background-color: #dddddd; }
	.listL {background-color: #aaffaa; }
	.listD {background-color: #ffaaaa; } */
	</style>
	<script>
	var logText = "Dist:";
	
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

		
	</script>

</head>
<body>
<c:set var='prevNum' value="11" />

<table style="width: 100%;"><tr><td align="center" style="background-color: #ffff77; width: 100%; font-size: large;">Stars</td></tr></table>
	<table>
	<tr><td colspan="21" width="850px"><img src="css/arrow.png"/> </td></tr>
	<tr>
    <c:forEach items="${ratings}"  var="rating" varStatus="loop">
	<c:if test="${prevNum!=rating.value}">
	<td></td>
	</tr>
	
    <tr><td width="50px"><img src="css/square.png"/> </td><td colspan="20">
	<c:forEach var="i" begin="1" end="${rating.value}" step="1">
	<img src='css/star.png'/>
	</c:forEach>
	</td><td></td>
	</tr>
	<tr><td width="50px"><img src="css/square.png"/> </td>
    <c:set var='prevNum' value="${rating.value}" />
    </c:if>
    
    <td width="90px">		
	<div class="scroll-content-item ${rating.type}"><img src="/img/${rating.movieId}.jpg"/><div style="" >${rating.movieName}</div></div>
	</td>
	
	</c:forEach>
	</tr>
</table>


<c:set var='prevNum' value="11" />
<table style="width: 100%;"><tr><td align="center" style="background-color: #ffff77; width: 100%; font-size: large;">Stars-History</td></tr></table>

	<table>
	<tr><td colspan="21" width="850px"><img src="css/arrow.png"/> </td></tr>
	<tr>
    <c:forEach items="${xratings}"  var="rating" varStatus="loop">
	<c:if test="${prevNum!=rating.value}">
	<td></td>
	</tr>
	
    <tr><td width="50px"><img src="css/square.png"/> </td><td colspan="20">
	<c:forEach var="i" begin="1" end="${rating.value}" step="1">
	<img src='css/star.png'/>
	</c:forEach>
	</td><td></td>
	</tr>
	<tr><td width="50px"><img src="css/square.png"/> </td>
    <c:set var='prevNum' value="${rating.value}" />
    </c:if>
    
    <td width="90px">		
	<div class="scroll-content-item ${rating.type}"><img src="/img/${rating.movieId}.jpg"/><div style="" >${rating.movieName}</div></div>
	</td>
	
	</c:forEach>
	</tr>
</table>




<table style="width: 100%;"><tr><td align="center" style="background-color: #ffff77; width: 100%; font-size: large;">List</td></tr></table>
<c:set var='prev' value='first' />
<table>
	
	<tr><td colspan="3"><img src="css/arrow.png"/> </td></tr>
    <c:forEach items="${list}"  var="rating" varStatus="loop">
    <c:if test="${prev!=rating.type && rating.type== 'listL'}">
    
    <tr><td><img src="css/square.png"/> </td><td colspan="2" style="background-color: #aaffaa;">Likes:</td></tr>
    <c:set var='prev' value='listL' />
    </c:if>
    <c:if test="${prev!=rating.type && rating.type== 'listN'}">
    
    <tr><td><img src="css/square.png"/> </td><td colspan="2" style="background-color: #dddddd;">Neutrals:</td></tr>
    <c:set var='prev' value='listN' />
    </c:if>
    <c:if test="${prev!=rating.type && rating.type== 'listD'}">
    
    <tr><td><img src="css/square.png"/> </td><td colspan="2" style="background-color: #ffaaaa;">Dislikes:</td></tr>
    <c:set var='prev' value='listD' />
    </c:if>
	<tr>
	<td><img src="css/square.png"/> </td>
	<td class=" ${rating.type}"><img src="/img/${rating.movieId}.jpg"/></td>
	<td class=" ${rating.type}" style="font-size:10px;  font-family: arial ;">${rating.movieName}</td>
	</tr>
	</c:forEach>
</table>	
<table style="width: 100%;"><tr><td align="center" style="background-color: #ffff77; width: 100%; font-size: large;">Bin</td></tr></table>
<table>
	<tr><td colspan="3"><img src="css/arrow.png"/> </td></tr>
    <c:forEach items="${bin}"  var="rating" varStatus="loop">
		
	<tr>
	<td><img src="css/square.png"/> </td>
	<td class=" ${rating.type}"><img src="/img/${rating.movieId}.jpg"/></td>
	<td class=" ${rating.type}" style="font-size:10px;  font-family: arial ;">${rating.movieName}</td>
	</tr>
	
	</c:forEach>

</table>


 
</body>
</html>