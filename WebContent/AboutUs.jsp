<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sahaay : AboutUs</title>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript">
      /* jQuery.getJSON('http://freegeoip.net/json/', function(location) {
		console.log(location);
		document.getElementById('listcity').val(location.city);
		}); */
		
    	function linkClick(){
    		//alert('clicked');
    		//alert('logging out');
    		$.ajax({
				type : "GET",
				url : "/sahaay/auth/logout",
				cache : false,
				dataType : "text",
				success : function(xhr) {
					window.location.reload();
				},
				error : function(xhr) {
					alert("AJAX request failed: "
							+ xhr.status);
				}
			});
    	}
		
    	$(document).ready(function() {
        	
	    	$('#logout').on('click', function() {
	    		//alert('logging out');
	    		$.ajax({
					type : "GET",
					url : "/sahaay/auth/logout",
					cache : false,
					dataType : "text",
					success : function(xhr) {
						window.location.reload();
					},
					error : function(xhr) {
						alert("AJAX request failed: "
								+ xhr.status);
					}
				});
	    		
	    	});
	    	
	    	$('#btn-sbscibe').click(function(e){
	    		
	    		var sub_id = $('#sub_id').val();
	    		//alert(sub_id);
	    		$.ajax({
					type : "GET",
					url : "/sahaay/auth/"+sub_id+"/subscribe",
					cache : false,
					dataType : "text",
					success : function(xhr) {
						//alert(xhr);
						if(xhr == "Success"){	
							//alert('ready');
							$('#confirm_modal').append("<p align='center' > Welcome to Sahaay family !!</p>");
							$('#confirm_modal').append("<p align='center' > Your subscription is complete !! </p>");
							$('#confirm_modal').append("<p align='center' > We will keep you posted with latest updates and offers. </p>");
							var options = {
								    "backdrop" : "static"
								}
							$('#success').modal(options);
						}
						//window.location.reload();
					},
					error : function(xhr) {
						alert("AJAX request failed: "
								+ xhr.status);
					}
				});
	    	});

	
		});
		
    	function checkLogin(){
    		//alert('loading');
    		var loggedIn = '<%= session.getAttribute("loggedIn") %>';
    		if(loggedIn != '' && loggedIn != 'undefined' && loggedIn == 'true'){
    			//alert('loggedin');
    			var username = '<%= session.getAttribute("userName") %>';
    			$('#loginHandle').html("<span align='right'><a href='#' class='subheading_link' style='text-decoration:none;color:#fff;'>Welcome, "+username+" ! </a>");
    			$('#loginHandle').append("<span class='subheading_link' style='text-decoration:none;color:#fff;'>&nbsp;&nbsp;|&nbsp;&nbsp;</span>");
    			$('#loginHandle').append("<a href='#' class='subheading_link' style='text-decoration:none;color:#fff;' id='linkSignout' name='linkSignout' href='#' onClick='linkClick()' >&nbsp;&nbsp;Logout&nbsp;&nbsp;</a> </span>");
    		}else {
    			//alert('not logged in');
    			$('#loginHandle').html("<a href='/sahaay/profileMgmt/loginRegister' class='subheading_link' style='text-decoration:none;color:#fff;'>Login/Register&nbsp;&nbsp;</a>");
    		}
    	}
    </script>
</head>
<body  onload="checkLogin()">
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td
				style="background-image: url(${pageContext.request.contextPath}/images/top.jpg); background-repeat: repeat-x">
				<table
					align="center" border="0" cellpadding="0" cellspacing="0"
					width="1003">
					<tbody>
						<tr>
							<td style="width: 646px;" class="menu_nav" height="40">
							<a href="/" class="menu_nav" style="text-decoration:none;color:#fff;">Home</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/howitworks" class="menu_nav" style="text-decoration:none;color:#fff;">How It Works </a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/services" class="menu_nav" style="text-decoration:none;color:#fff;">Services</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/aboutus" class="menu_nav" style="text-decoration:none;color:#fff;">About Us</a></td>
							<td style="width: 300px;" height="40" id="loginHandle" align='right'><a href="/sahaay/profileMgmt/loginRegister" class="subheading_link" style="text-decoration:none;color:#fff;">Login/Register</a></td>
							<td style="width: 160px;" height="40"><select
								name="listprofile"
								style="border: 1px solid rgb(255, 255, 255); width: 150px; height: 23px; background-color: rgb(255, 255, 255);"
								id="listcity"><option class="para" value="Hyderabad" >Hyderabad</option>
									<option class="para" value="Bengaluru">Bangalore</option></select> <br /></td>
							<td style="width: 108px;" height="40"><table
									style="margin-left: 0px; width: 98px;" align="right" border="0"
									cellpadding="0" cellspacing="0" width="47%">
									<tbody>
										<tr>
											<td style="width: 23px;"><a
												href="https://www.facebook.com/sahaay"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('Image1','','${pageContext.request.contextPath}/images/facebook_a.jpg',1)"><img
													src="${pageContext.request.contextPath}/images/facebook.jpg" alt="facebook" name="Image1"
													id="Image1" border="0" height="15" width="10" /></a></td>
											<td style="width: 23px;"><a
												href="https://twitter.com/SahaayIndia"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('Image2','','${pageContext.request.contextPath}/images/twitter_a.jpg',1)"><img
													src="${pageContext.request.contextPath}/images/twitter.jpg" alt="twitter" name="Image2"
													id="Image2" border="0" height="16" width="18" /></a></td>
											<td style="width: 23px;" align="center"><a href="#"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('Image3','','${pageContext.request.contextPath}/images/google_plus_a.jpg',1)"><img
													src="${pageContext.request.contextPath}/images/google_plus.jpg" alt="google_plus"
													name="Image3" id="Image3" border="0" height="17" width="16" /></a></td>
											<td style="width: 23px;" align="right"><a
												href="http://sahaayindia.wordpress.com/"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('Image4','','${pageContext.request.contextPath}/images/rss_a.jpg',1)"><img
													src="${pageContext.request.contextPath}/images/rss.jpg" alt="rss" name="Image4" id="Image4"
													border="0" height="16" width="14" /></a></td>
										</tr>
									</tbody>
								</table></td>
						</tr>
					</tbody>
				</table></td>
		</tr>
	</table>
<!-- HEADER ENDS -->

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="background-image:url(${pageContext.request.contextPath}/images/contact.jpg);"><br />
      <table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center"><img src="${pageContext.request.contextPath}/images/logo.png" alt="logo" width="261" height="83" /></td>
      </tr>
    </table>
      <br />
    <table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="subheading2"><strong><u><h3>About Us :-</h3></u></strong><br />
          <br />
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="37%" valign="top"><img src="${pageContext.request.contextPath}/images/stock-photo-confident-chauffeur-sitting-in-elegant-automobile-93796168.jpg" alt="stock-photo-confident-chauffeur-sitting-in-elegant-automobile-93796168" width="350" height="200" /></td>
              <td width="63%" valign="top"><p class="para">We are a startup founded by IITians and senior management professionals in technology industry. We are on a mission to organize the unorganized Indian services sector through technology.<br />
                    <br />
                Sahaay aims to connect Indian customers with top quality service providers. We also aspire to bring fairness and dignity to blue collar services. Sahaay will give these providers an avenue to earn based on their performance.</p>
                <p class="para">We firmly believe Sahaay will revolutionize the quality of these services in India. Our vision is to create a win-win ecosystem for all - top quality services for the customers, and dignity of work for the providers!! </p></td>
            </tr>
          </table><br />
<br /><br /></td>
      </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
</td>
  </tr>
</table>

<!-- FOOTER -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="90"
				style="background-image: url(${pageContext.request.contextPath}/images/footer.jpg); background-repeat: repeat-x">
				</br>
				<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="500" class="menu_nav" valign="top"><strong>FAQ's   &nbsp;&nbsp;Blog   &nbsp;&nbsp;Carrers</strong>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Toll free</strong> +91 1800 1234 5678</td>

							<td width="400" valign="top">
								<form class="form-inline" role="form">									
									<div class="form-group"><input type="email" class="form-control"
											id="sub_id" name="sub_id" placeholder="Subscribe to our Newsletter/Alerts" style=" width: 250px;">&nbsp;&nbsp;
											<a id="btn-sbscibe" href="#" class="btn btn-success">&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;</a></div>
								</form>
							</td>
							
      </tr>
    </table>
     <br />
    <table width="100%" border="0">
      <tr>
        <td align="center" valign="bottom" class="copyright">All rights receved . copyright@www.sahaay.com</td>
        </tr>
    </table></td>
		</tr>
	</table>
</body>
</html>