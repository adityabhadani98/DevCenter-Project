<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ResourceBundle"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="sat, 01 Dec 2001 00:00:00 GMT">
<link rel="stylesheet" href="resources/styles.css">
<title>HCOM Hospital Home</title>
<link rel='icon' type='image/x-icon' href='images/favicon.ico' />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet">
<script
	src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-show-password/1.0.3/bootstrap-show-password.min.js"></script>
<style>
html, body {
	margin: 0;
	padding: 0;
}

.navbar_right {
	padding: 4px 0;
	background: #0E94D3; /* Old browsers */
	background: -moz-linear-gradient(45deg, #95cd6a 0%, #95cd6a 21%, #0E94D3 21%,
		#0E94D3 100%); /* FF3.6-15 */
	background: -webkit-linear-gradient(45deg, #95cd6a 0%, #95cd6a 21%, #0E94D3 21%,
		#0E94D3 100%); /* Chrome10-25,Safari5.1-6 */
	background: linear-gradient(45deg, #95cd6a 0%, #95cd6a 21%, #0E94D3 21%, #0E94D3
		100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
}

.slider {
	width: 1024px;
	margin: 2em auto;
}

.slider-wrapper {
	width: 100%;
	height: 400px;
	position: relative;
}

li a {
	display: block;
	color: white;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

.slide {
	float: left;
	position: absolute;
	width: 100%;
	height: 100%;
	opacity: 0;
	transition: opacity 3s linear;
}

.slider-wrapper>.slide:first-child {
	opacity: 1;
}
</style>
<script>
	function preventBack() {
		window.history.forward();
	}

	setTimeout("preventBack()", 0);
	window.onunload = function() {
		null
	};
</script>
</head>
<body>
	<%
		ResourceBundle resourceBundle = ResourceBundle.getBundle("com.cerner.i18n.content", request.getLocale());
	%>

	<div role="navigation">
		<div class="navbar_right">
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="/welcome"><%=resourceBundle.getString("HcomHospital")%></a></li>
					<li><a href="/login"><%=resourceBundle.getString("login")%></a></li>
				</ul>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${mode=='MODE_HOME' }">
			<div class="container" id="homediv">
				<div class="slider" id="main-slider">
					<!-- outermost container element -->
					<div class="slider-wrapper">
						<!-- innermost wrapper element -->
						<img src="images/h1.jpg" alt="First" class="slide" />
						<!-- slides -->
						<img src="images/h2.jpg" alt="Second" class="slide" /> <img
							src="images/h3.jpg" alt="Third" class="slide" />
					</div>
					<h2 style="color: red" align="center"><%=resourceBundle.getString("hcomHospitalManagementSystem")%></h2>
				</div>
				<script>
					(function() {

						function Slideshow(element) {
							this.el = document.querySelector(element);
							this.init();
						}

						Slideshow.prototype = {
							init : function() {
								this.wrapper = this.el
										.querySelector(".slider-wrapper");
								this.slides = this.el
										.querySelectorAll(".slide");
								this.previous = this.el
										.querySelector(".slider-previous");
								this.next = this.el
										.querySelector(".slider-next");
								this.index = 0;
								this.total = this.slides.length;
								this.timer = null;

								this.action();
								this.stopStart();
							},
							_slideTo : function(slide) {
								var currentSlide = this.slides[slide];
								currentSlide.style.opacity = 1;

								for (var i = 0; i < this.slides.length; i++) {
									var slide = this.slides[i];
									if (slide !== currentSlide) {
										slide.style.opacity = 0;
									}
								}
							},
							action : function() {
								var self = this;
								self.timer = setInterval(function() {
									self.index++;
									if (self.index == self.slides.length) {
										self.index = 0;
									}
									self._slideTo(self.index);
								}, 3000);
							},
							stopStart : function() {
								var self = this;
								self.el.addEventListener("mouseover",
										function() {
											clearInterval(self.timer);
											self.timer = null;
										}, false);
								self.el.addEventListener("mouseout",
										function() {
											self.action();
										}, false);
							}
						};
						document.addEventListener("DOMContentLoaded",
								function() {
									var slider = new Slideshow("#main-slider");
								});
					})();
				</script>
			</div>
		</c:when>
	</c:choose>
</body>
</html>