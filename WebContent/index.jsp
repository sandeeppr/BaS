<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sahaay : Welcome</title>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript">
     
      function MM_swapImgRestore() { //v3.0
    	  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
    	}
    	function MM_preloadImages() { //v3.0
    	  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    	    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    	    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
    	}

    	function MM_findObj(n, d) { //v4.01
    	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
    	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
    	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
    	  if(!x && d.getElementById) x=d.getElementById(n); return x;
    	}

    	function MM_swapImage() { //v3.0
    	  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
    	   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
    	}
    	
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
    	
    	function subscribe(){
    		alert('asked for subscroption ');
    		
    	}
    	
    	function checkLogin(){
    		//alert('loading');
    		var loggedIn = '<%= session.getAttribute("loggedIn") %>';
    		if(loggedIn != '' && loggedIn != 'undefined' && loggedIn == 'true'){
    			//alert('loggedin');
    			var username = '<%= session.getAttribute("userName") %>';
    			$('#loginHandle').html("<span align='right'><a href='#' class='subheading_link' style='text-decoration:none;color:#fff;'>Welcome, "+username+" ! </a>");
    			$('#loginHandle').append("<span class='subheading_link' style='text-decoration:none;color:#fff;'>&nbsp;&nbsp;|&nbsp;&nbsp;</span>");
    			$('#loginHandle').append("<a id='linkSignout' name='linkSignout' href='#' onClick='linkClick()' class='subheading_link' style='text-decoration:none;color:#fff;' >&nbsp;&nbsp;Logout&nbsp;&nbsp;</a> </span>");
    		}else {
    			//alert('not logged in');
    			$('#loginHandle').html("<a href='/sahaay/profileMgmt/loginRegister' class='subheading_link' style='text-decoration:none;color:#fff;'>Login/Register&nbsp;&nbsp;</a>");
    		}
    	}
    </script>
    <script type="text/javascript">
    $(document).ready(function() {
    	
		(function($) {
			$.fn.serializeObject = function() {
				var self = this, json = {}, push_counters = {}, patterns = {
					"validate" : /^[a-zA-Z][a-zA-Z0-9_]*(?:\[(?:\d*|[a-zA-Z0-9_]+)\])*$/,
					"key" : /[a-zA-Z0-9_]+|(?=\[\])/g,
					"push" : /^$/,
					"fixed" : /^\d+$/,
					"named" : /^[a-zA-Z0-9_]+$/
				};
				this.build = function(base, key, value) {
					base[key] = value;
					return base;
				};
				this.push_counter = function(key) {
					if (push_counters[key] === undefined) {
						push_counters[key] = 0;
					}
					return push_counters[key]++;
				};
				
			$.each($(this).serializeArray(),
				function() {
					// skip invalid keys
					if (!patterns.validate.test(this.name)) {
						return;
					}
					var k, keys = this.name.match(patterns.key), merge = this.value, reverse_key = this.name;
					while ((k = keys.pop()) !== undefined) {
						// adjust reverse_key
						reverse_key = reverse_key.replace(
								new RegExp("\\[" + k + "\\]$"), '');
						// push
						if (k.match(patterns.push)) {
							merge = self.build([], self
									.push_counter(reverse_key),
									merge);
						}
						// fixed
						else if (k.match(patterns.fixed)) {
							merge = self.build([], k, merge);
						}
						// named
						else if (k.match(patterns.named)) {
							merge = self.build({}, k, merge);
						}
					}
					json = $.extend(true, json, merge);
				});
	return json;
	};
	})(jQuery);
	
    	//$('#lnk-logout').click(function(e) {
    	$('#linkSignout').on('click',function(e) {
						
    		alert('logging out');
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
    </script>
</head>
<body onload="checkLogin()">
<div class="modal" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content modal-content-bg">
                <div class="modal-header modal-header-success">
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">�</button> -->
                    <!-- <i class="glyphicon glyphicon-thumbs-up"> --></i> <i>Welcome to <span class='label label-warning'>Sahaay.com</span></i>
                </div>
                <div class="modal-body" id="confirm_modal">
                	    	
                </div>
                <div class="modal-footer">
                    <a id="btn-success-modal" href="/" class="btn btn-success pull-justify">Take me to HomePage</a> 
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
<table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td style="background-image: url(${pageContext.request.contextPath}/images/bg.jpg); background-repeat: repeat-x;" valign="middle"><table align="center" border="0" cellpadding="0" cellspacing="0" width="1003">
      <tbody><tr>
        <td style="width: 646px;" class="menu_nav" height="40">
							<a href="/" class="menu_nav" style="text-decoration:none;color:#fff;">Home</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/howitworks" class="menu_nav" style="text-decoration:none;color:#fff;">How It Works </a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/services" class="menu_nav" style="text-decoration:none;color:#fff;">Services</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/aboutus" class="menu_nav" style="text-decoration:none;color:#fff;">About Us</a></td>
							<td style="width: 300px;" height="40" id="loginHandle" align='right'><a href="/sahaay/profileMgmt/loginRegister" class="subheading_link" style="text-decoration:none;color:#fff;">Login/Register&nbsp;&nbsp;</a></td>
							
<td style="width: 160px;" height="40"><select name="listprofile" style="border: 1px solid rgb(255, 255, 255); width: 150px; height: 23px; background-color: rgb(255, 255, 255);" id="listcity"><option class="para">Hyderabad</option><option class="para">Bangalore</option></select>
          <br /></td>
        <td style="width: 108px;" height="40"><table style="margin-left: 0px; width: 98px;" align="right" border="0" cellpadding="0" cellspacing="0" width="47%">
          <tbody><tr>
            <td style="width: 23px;"><a href="https://www.facebook.com/sahaay" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image1','','${pageContext.request.contextPath}/images/facebook_a.jpg',1)"><img src="${pageContext.request.contextPath}/images/facebook.jpg" alt="facebook" name="Image1" id="Image1" border="0" height="15" width="10" /></a></td>
            <td style="width: 23px;"><a href="https://twitter.com/SahaayIndia" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image2','','${pageContext.request.contextPath}/images/twitter_a.jpg',1)"><img src="${pageContext.request.contextPath}/images/twitter.jpg" alt="twitter" name="Image2" id="Image2" border="0" height="16" width="18" /></a></td>
            <td style="width: 23px;" align="center"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image3','','${pageContext.request.contextPath}/images/google_plus_a.jpg',1)"><img src="${pageContext.request.contextPath}/images/google_plus.jpg" alt="google_plus" name="Image3" id="Image3" border="0" height="17" width="16" /></a></td>
            <td style="width: 23px;" align="right"><a href="http://sahaayindia.wordpress.com/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','${pageContext.request.contextPath}/images/twitter.jpg',1)"><img src="${pageContext.request.contextPath}/images/rss.jpg" alt="rss" name="Image4" id="Image4" border="0" height="16" width="14" /></a></td>
          </tr>
        </tbody></table></td>
      </tr>
    </tbody></table>
    <br />
    <br />
    <br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="1003">
      <tbody><tr>
        <td align="center"><img src="${pageContext.request.contextPath}/images/logo.png" alt="logo" height="83" width="261" /></td>
      </tr>
    </tbody></table>
    <br />
    <br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="1003">
      <tbody><tr>
        <td class="subheading1" align="right" width="327"><strong>Offer a service</strong></td>
        <td align="center" width="334"><img src="${pageContext.request.contextPath}/images/bridge.png" alt="image" height="131" width="269" /></td>
        <td class="subheading2" width="342"><strong>Hire a service</strong></td>
      </tr>
    </tbody></table>
    <br />
    <br />
    <br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="1003">
      <tbody><tr>
        <td width="323"><table align="right" border="0" cellpadding="0" cellspacing="0" width="90%">
          <tbody><tr>
            <td align="center" width="52%"><a href="https://docs.google.com/forms/d/1ABS1d1T3k_lDRgXwK8FxOvd5mTWNVpjCl-ivNIEvRDs/viewform" ><img src="${pageContext.request.contextPath}/images/browse_task.png" alt="browse_task" height="69" width="72" /></a></td>
            <td align="center" width="48%"><a href="/sahaay/profileMgmt/showSPSignUp" ><img src="${pageContext.request.contextPath}/images/create_profile.png" alt="create_profile" height="69" width="70" /></a></td>
          </tr>
          <tr>
            <td style="text-align: center;" class="subheading3"><a href="https://docs.google.com/forms/d/1ABS1d1T3k_lDRgXwK8FxOvd5mTWNVpjCl-ivNIEvRDs/viewform" style="text-decoration:none; color:#454545;"><strong>Are you an agency ?<br>&nbsp;</strong></a></td>
            <td style="text-align: center;" class="subheading3" ><a href="/sahaay/profileMgmt/showSPSignUp" style="text-decoration:none; color:#454545;"><strong>Create Your <br />
              Profile</strong></a></td>
          </tr>
        </tbody></table></td>
        <td width="341">&nbsp;</td>
        <td width="339"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody><tr>
            <td align="center" width="46%"><a href="/sahaay/bookings/requestBookingPage" ><img src="${pageContext.request.contextPath}/images/browse_providers.png" alt="browse_providers" height="69" width="68" /></a></td>
            <td align="center" width="54%"><a href="https://docs.google.com/forms/d/1A7dyxTTCU7-vTRbkWf-lJuBOdwfnf-0af73d5IPnb1s/viewform" ><img src="${pageContext.request.contextPath}/images/get_providers.png" alt="get_providers" height="69" width="68" /></a></td>
          </tr>
          <tr>
            <td style="text-align: center;" class="subheading3" valign="top"><a href="/sahaay/bookings/requestBookingPage" style="text-decoration:none; color:#454545;"><strong>Book A Service</strong></a></td>
            <td style="text-align: center;" class="subheading3"><a href="https://docs.google.com/forms/d/1A7dyxTTCU7-vTRbkWf-lJuBOdwfnf-0af73d5IPnb1s/viewform" style="text-decoration:none; color:#454545;"><strong>Know a great provider ?<br />
Let us know </strong></a></td>
          </tr>
        </tbody></table></td>
      </tr>
    </tbody></table>
    <br />
    <br />
    <br />

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
        <td align="center" valign="bottom" class="copyright">Copyright � 2014. All rights reserved. www.sahaay.com</td>
        </tr>
    </table>
    <br />
    </td>
  </tr>
</tbody></table>
</body>
</html>