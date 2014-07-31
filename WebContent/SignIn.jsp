<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sahaay : SignIn/Register</title>
<link type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" />
<link type="text/css" href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.bpopup.min.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.serializeJSON.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqBootstrapValidation.js"></script> --%>

<script
	src="C:\workspaces\ides\userProjects\BaS\WebContent\js/jquery-2.1.0.min.js"></script>
<script
	src="C:\workspaces\ides\userProjects\BaS\WebContent\js\jquery.bpopup.min.js"></script>
	<script
	src="C:\workspaces\ides\userProjects\BaS\WebContent\js\bootstrap.min.js"></script>
	
<style type="text/css">
.blocker{z-index:1000;height:100%;width:100%;background: white; opacity:0.3; position: absolute;}
.aboveAll{z-index:1010; text-align: middle;}

/* .modal-header {
    padding:9px 15px;
    border-bottom:1px solid #eee;
    //background-color: #51a351;
    //background-color: #62c462;
    -webkit-border-top-left-radius: 5px;
    -webkit-border-top-right-radius: 5px;
    -moz-border-radius-topleft: 5px;
    -moz-border-radius-topright: 5px;
     border-top-left-radius: 5px;
     border-top-right-radius: 5px;
 } */
</style>

<script type="text/javascript">

$(document)
.ready(
		function() {
			
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
			

			$(function() {
				if(navigator.appVersion.indexOf("MSIE") != -1){
					alert('removing fade');
					$('.modal').removeClass('fade');
				}
				});
			
			$('#id').blur(function(e){
				var id = $('#id').val();
				var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
				
				if(id == null || id == undefined || id == "" || !emailReg.test(id)){
						$('#signupalert').html("");
						$('#signupalert').append("Please provide valid Email address.");
						$('#signupalert').css('display', 'block');
						$('#id').focus();
				}else{
					//alert('id all well');
					$('#shadow').addClass('blocker');
					/* var options = {
						"backdrop" : "static"
						}
					alert('showing progress bar'); */
					//$('#pleaseWaitDialog').modal(options);
					$.ajax({
						type : "GET",
						url : "/sahaay/auth/checkUserId/"+id,
						cache : false,
						dataType : "text",
						success : function(resp){
									//alert('returned from checking id');
									//alert(resp);
									if(resp == "true"){
										if($('#shadow').hasClass('blocker'))
										       $('#shadow').removeClass('blocker');
										//$('#pleaseWaitDialog').modal('hide');
										//alert('hidden');
										$('#signupalert').html("");
										$('#signupalert').css('display', 'none');
										$('#password').focus();
									}else{
										if($('#shadow').hasClass('blocker'))
										      $('#shadow').removeClass('blocker');  
										$('#id').focus();
										$('#signupalert').html("Userid already used. Try with another email address.");
										$('#signupalert').css('display', 'block');										
									}
								},
						error : function(xhr) {
							if($('#shadow').hasClass('blocker'))
							       $('#shadow').removeClass('blocker');  
							//alert('Error occured : '+xhr.status)
							window.location.href = '/sahaay/auth/error';
						}
					});
				}
			});
			
			$('#password').blur(function(e){
				var password = $('#password').val();
				if(password == null || password == undefined || password == "" || password.length < 6){
						$('#signupalert').html("");
						$('#signupalert').append("Password is mandatory and it must contain atleast 6 characters.");
						$('#signupalert').css('display', 'block');
						$('#password').focus();
				}else{
					$('#signupalert').html("");
					$('#signupalert').css('display', 'none');
					$('#confirmPwd').focus();
				}
			});
			
			$('#confirmPwd').blur(function(e){
				var password = $('#password').val();
				var cpwd = $('#confirmPwd').val();
				if(cpwd == null || cpwd == undefined || cpwd == "" || cpwd.length < 6 || password != cpwd){
						$('#signupalert').html("");
						$('#signupalert').append("Password must match. Please try again.");
						$('#signupalert').css('display', 'block');
						$('#confirmPwd').focus();
					
				}else{
					$('#signupalert').html("");
					$('#signupalert').css('display', 'none');
					$('#name').focus();
				}
			});
			
			$('#name').blur(function(e){
				var name = $('#name').val();
				if(name == null || name == undefined || name == "" || name.length < 3){
						$('#signupalert').html("");
						$('#signupalert').append("Name is mandatory and it must contain atleast 3 characters.");
						$('#signupalert').css('display', 'block');
						$('#name').focus();
				}else{
					$('#signupalert').html("");
					$('#signupalert').css('display', 'none');
					$('#mobile').focus();
				}
			});
			
			$('#mobile').blur(function(e){
				var mobile = $('#mobile').val();
				var mobileReg = /^0[0-9]*$/;
				
				if(mobileReg.test(mobile)){					
					alert('starts with a 0');
					$('#signupalert').html("");
					$('#signupalert').append("Mobile number cannot start with a Zero.");
					$('#signupalert').css('display', 'block');
				}else {
					$('#signupalert').html("");
					$('#signupalert').css('display', 'none');					
					
					if(mobile == null || mobile == undefined || mobile == "" || mobile.length != 10 || !$.isNumeric(mobile)){
							$('#signupalert').html("");
							$('#signupalert').append("Mobile is mandatory and it must not exceed 10 digits.");
							$('#signupalert').css('display', 'block');
							$('#mobile').focus();
					}else{
						$('#signupalert').html("");
						$('#signupalert').css('display', 'none');
						$('#btn-signup').focus();
					}
				}
			});
			
			$('#btn-clear').on('click', function(e) {
				$('#signupalert').html("");
				$('#signupalert').css('display', 'none');
				$('#id').focus();
				
				$('#id').val("");
				$('#password').val("");
				$('#confirmPwd').val("");
				$('#name').val("");
				$('#mobile').val("");				
				
			});
			
			$('#btn-signup').on('click', function(e) {
					$('#shadow').addClass('blocker');  	
					// make an ajax call
					$.ajax({
						url : "/sahaay/profileMgmt/createAccount",
						type : "POST",
						data : JSON.stringify($('#signup').serializeObject()),
						contentType : 'application/json',
						dataType:"text",
						success : function(registered) {
							if($('#shadow').hasClass('blocker'))
							       $('#shadow').removeClass('blocker');  
									//alert(registered);
									if(registered == "Success"){	
										$('#confirm_modal').append("<p align='center' > Welcome to Sahaay family !!</p>");
										$('#confirm_modal').append("<p align='center' > Your account is successfully created with us. </p>");
										var options = {
											    "backdrop" : "static"
											}
										$('#success').modal(options);
										//window.location.href = '/';
									}else {
										//alert('failure : ');
										window.location.href = '/sahaay/auth/error';
									}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							if($('#shadow').hasClass('blocker'))
							       $('#shadow').removeClass('blocker');  
							//alert('failed : '+jqXHR.status);
							window.location.href = '/sahaay/auth/error';
						}
					});
					return false;
			
		});

		$('#btn-login').on(
				'click',
				function(e) {
					var userid = $('#userid').val();
					var password = $('#pwd').val();
					//alert(userid+" : "+password);
					var hasError = false;
					 var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
					if(userid == null || userid == undefined || userid == "" || !emailReg.test(userid)){
						hasError = true;
						$('#login-alert').html("");
						$('#login-alert').append("Please provide valid Email address");
					}
					
					//alert("check pawdd");
					if(password == null || password == undefined || password == ""){
						if(hasError == true)
							$('#login-alert').append(" and Password ");
						else{
							$('#login-alert').html("");
							$('#login-alert').append("Please provide value for Password");
							hasError = true;
						}
					}
				
				
					if(hasError == true){
						$('#login-alert').append(" to proceed !!");
						$('#login-alert').css('display', 'block');
					}else {						
							$('#shadow').addClass('blocker');  
							// make an ajax call
							$.ajax({
								url : "/sahaay/bookings/auth/signin",
								type : "POST",
								data : JSON.stringify($('#signin').serializeObject()),
								contentType : 'application/json',
								dataType:"text",
								success : function(loggedIn) {
								
											// sign in went well..lets see the responses
											//var loggedIn = jQuery.parseJSON(resp);
											if($('#shadow').hasClass('blocker'))
										       $('#shadow').removeClass('blocker');  
											if(loggedIn == "Success"){
												//alert('logged in');
												$('#login-alert').html("");
												$('#login-alert').css('display', 'none');
												
												$('#confirm_modal').append("<p align='center' > Welcome back !! </p>");
												$('#confirm_modal').append("<p align='center' > You are logged in now. </p>");
												//$('#confirm_popup').append("<p align='center' > </p>");
												   var options = {
													    "backdrop" : "static"
													}
												
													$('#success').modal(options);
													
												//$('#success').modal(options);
												//window.location.href = '/';
											}else {
												//window.location.href = '/sahaay/auth/error';
												$('#login-alert').html("");
												$('#login-alert').append("Invalid Username or Password.");
												$('#login-alert').css('display', 'block');
											}
								},
								error : function(jqXHR, textStatus, errorThrown) {
									if($('#shadow').hasClass('blocker'))
									       $('#shadow').removeClass('blocker');  
									window.location.href = '/sahaay/auth/error';
								}
							});
							return false;
					
					}
					
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

</script>



<script>
function checkLogin(){
	//alert('loading');
	var loggedIn = '<%= session.getAttribute("loggedIn") %>';
	if(loggedIn != '' && loggedIn != 'undefined' && loggedIn == 'true'){
		//alert('loggedin');
		var username = '<%= session.getAttribute("userName") %>';
		$('#loginHandle').html("<span align='right'><a href='#' class='subheading_link' style='text-decoration:none;color:#fff;'>Welcome, "+username+" ! </a>");
		$('#loginHandle').append("<span class='subheading_link' style='text-decoration:none;color:#fff;'>&nbsp;&nbsp;|&nbsp;&nbsp;</span>");
		$('#loginHandle').append("<a id='lnk-logout' name='lnk-logout' href='#' class='subheading_link' style='text-decoration:none;color:#fff;' >&nbsp;&nbsp;Logout&nbsp;&nbsp;</a> </span>");
	}else {
		//alert('not logged in');
		$('#loginHandle').html("");
	}
}
</script>

</head>
<body  >
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
							<td style="width: 100px;" height="40"></td>
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
	
	<table width="100%" align="center" ><tr><td style="background-image:url(${pageContext.request.contextPath}/images/contact.jpg); ">
	<div id="shadow">    </div>
	
	<div class="container" style="margin-top: 20px;">
		<div class="row setup-content" id="step-1">
			<div class="col-xs-12">
				<div class="col-md-12 well ">
		<div id="loginbox" style="display: none; margin-top: 25px;margin-bottom: 25px;"
			class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
	
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Sign In</div>
					<!-- <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="#">Forgot password?</a></div> -->

					<!--  <div style="float:right; font-size: 80%; position: relative; top:-10px" >
                                            Don't have an account! 
                                        <a href="#" onClick="$('#loginbox').hide(); $('#signupbox').show()">
                                            Sign Up Here
                                        </a>
                                        </div> -->

				</div>

				<div style="padding-top: 30px" class="panel-body">

					<div style="display: none" id="login-alert"
						class="alert alert-danger col-sm-12"></div>

					<form id="signin" class="form-horizontal" role="form"
						action="/sahaay/bookings/auth/signin">

						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-user"></i></span> <input id="userid"
								type="text" class="form-control" name="userid" value=""
								placeholder="username or email">
						</div>

						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-lock"></i></span> <input id="pwd"
								type="password" class="form-control" name="pwd"
								placeholder="password">
						</div>



						<div class="input-group">
							<div class="checkbox">
								<label> <input id="login-remember" type="checkbox"
									name="remember" value="1"> Remember me
								</label>
							</div>
						</div>


						<div style="margin-top: 10px" class="form-group">
							<!-- Button -->

							<div class="col-sm-12 controls">
								<a id="btn-login" href="#" class="btn btn-success">Login </a> <a
									id="btn-fblogin" href="#" class="btn btn-primary">Login
									with Facebook</a>

							</div>
						</div>
						<div class="form-group">
							<div class="col-md-12 control">
								<div>
									<br>
								</div>
								<div
									style="float: left; font-size: 80%; position: relative; top: -10px">
									<a href="#">Forgot password?</a>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-12 control">

								<div
									style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
									Don't have an account! <a href="#"
										onClick="$('#loginbox').hide(); $('#signupbox').show()">
										Register Here </a>
								</div>

							</div>
						</div>


					</form>




				</div>
			</div>
		</div>
		
	<!--  CONFIRMATION MODAL -->
	<div class="modal" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content modal-content-bg">
                <div class="modal-header modal-header-success">
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                    <!-- <i class="glyphicon glyphicon-thumbs-up"> --></i> <i>Welcome to <span class='label label-warning'>Sahaay.com</span></i>
                </div>
                <div class="modal-body" id="confirm_modal">
                	    	
                </div>
                <div class="modal-footer">
                    <a id="btn-success-modal" href="/" class="btn btn-success pull-justify">Take me to HomePage</a> 
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    <!-- <div id="element_to_pop_up" style="display:none;">
    	<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title"><i>Welcome to <span class='label label-warning'>Sahaay.com</span></i></div>
				</div>
				<div class="panel-body">
					<div id="confirm_popup">
                	    	
                	</div>
					<div>
	                    <a id="btn-success-modal" href="/" class="btn btn-success pull-justify">Take me to HomePage</a> 
	                </div>
				</div>
		</div>
    
    </div> -->
    
    
		<div id="signupbox" style="display: block; margin-top: 25px;margin-bottom: 25px;"
			class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<br>
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Register / Sign up</div>
					<div
						style="float: right; font-size: 85%; position: relative; top: -10px">
						<a id="signinlink" href="#"
							onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign
							In</a>
					</div>
				</div>
				<div class="panel-body">
					<form id="signup" class="form-horizontal" role="form">

						<div id="signupalert" style="display: none"
							class="alert alert-danger">
							<p>Error:</p>
							<span></span>
						</div>

						

						<div class="form-group">
							<label for="email" class="col-md-3 control-label">Email</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="id" id="id"
									placeholder="Email Address">
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-md-3 control-label">Password</label>
							<div class="col-md-9">
								<input type="password" class="form-control" name="password"
									id="password" placeholder="Password">
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-md-3 control-label">Retype Password</label>
							<div class="col-md-9">
								<input type="password" class="form-control" 
									id="confirmPwd" placeholder="Retype Password">
							</div>
						</div>
						<div class="form-group">
							<label for="lastname" class="col-md-3 control-label">Name</label>
							<div class="col-md-9">
								<input type="text" class="form-control" id="name" name="name"
									placeholder="Full Name">
							</div>
						</div>
						<div class="form-group">
							<label for="mobile" class="col-md-3 control-label">Mobile</label>
							<div class="col-md-9">
								<input type='text' class="form-control" id="mobile"
									name="mobile" placeholder="Mobile number" />
								<input name="type" id="type" value="USER" type="hidden" />
								<input name="status" id="status" value="INACTIVE" type="hidden" />
							</div>
						</div>
						<div class="form-group">
							<!-- Button -->
							<div class="col-md-offset-3 col-md-9">
								<a id="btn-signup" href="#" class="btn btn-success">&nbsp;&nbsp;&nbsp;&nbsp;SignUp &nbsp;&nbsp;&nbsp;&nbsp;</a> <a
									id="btn-clear" href="#" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;Clear&nbsp;&nbsp;&nbsp;&nbsp;</a>
								<!-- <span style="margin-left:8px;">or</span>   -->
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
		</div></div></div>
		    
		
	</div>
		</td></tr></table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-image:url(${pageContext.request.contextPath}/images/footer.jpg); background-repeat:repeat-x">
  <tr>
    <td height="120" >
    <table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="528" class="menu_nav"><strong>FAQ's   &nbsp;&nbsp;Blog   &nbsp;&nbsp;Carrers</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Toll free</strong> +91 1800 1234 5678</td>
        <td width="220"><form class="form-inline" role="form">									
									<div class="form-group"><input type="email" class="form-control"
											id="sub_id" name="sub_id" placeholder="Subscribe to our Newsletter/Alerts" style=" width: 250px;">&nbsp;&nbsp;
											<a id="btn-sbscibe" href="#" class="btn btn-success">&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;</a></div>
								</form></td>
      </tr>
    </table>
     <br /><br>
    <table width="100%" border="0">
      <tr>
        <td align="center" valign="bottom" class="copyright">Copyright © 2014. All rights reserved. www.sahaay.com</td>
        </tr>
    </table>
</td>
  </tr>
</table>
</body>
</html>