<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sahaay : SignUp</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.css"
	rel="stylesheet">
<link type="text/css" href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
<link type="text/css"
	href="${pageContext.request.contextPath}/css/jquery.simple-dtpicker.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.simple-dtpicker.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.serializeJSON.min.js"></script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.ajaxfileupload.js"></script>
<link href="css/bootstrap.css" rel="stylesheet">
<link type="text/css" href="css/jquery.simple-dtpicker.css"
	rel="stylesheet" />
<script type="text/javascript" src="js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.simple-dtpicker.js"></script>
<script type="text/javascript" src="js/jquery.serializeJSON.min.js"></script>

<style type="text/css">
/* body {
	margin-top: 20px;
} */

.clearfix {
	*zoom: 1;
}

.clearfix:before,.clearfix:after {
	display: table;
	content: "";
	line-height: 0;
}

.clearfix:after {
	clear: both;
}

.hide-text {
	font: 0/0 a;
	color: transparent;
	text-shadow: none;
	background-color: transparent;
	border: 0;
}

.input-block-level {
	display: block;
	width: 100%;
	min-height: 30px;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

.btn-file {
	overflow: hidden;
	position: relative;
	vertical-align: middle;
}

.btn-file>input {
	position: absolute;
	top: 0;
	right: 0;
	margin: 0;
	opacity: 0;
	filter: alpha(opacity = 0);
	transform: translate(-300px, 0) scale(4);
	font-size: 23px;
	direction: ltr;
	cursor: pointer;
}

.fileupload {
	margin-bottom: 9px;
}

.fileupload .uneditable-input {
	display: inline-block;
	margin-bottom: 0px;
	vertical-align: middle;
	cursor: text;
}

.fileupload .thumbnail {
	overflow: hidden;
	display: inline-block;
	margin-bottom: 5px;
	vertical-align: middle;
	text-align: center;
}

.fileupload .thumbnail>img {
	display: inline-block;
	vertical-align: middle;
	max-height: 100%;
}

.fileupload .btn {
	vertical-align: middle;
}

.fileupload-exists .fileupload-new,.fileupload-new .fileupload-exists {
	display: none;
}

.fileupload-inline .fileupload-controls {
	display: inline;
}

.fileupload-new .input-append .btn-file {
	-webkit-border-radius: 0 3px 3px 0;
	-moz-border-radius: 0 3px 3px 0;
	border-radius: 0 3px 3px 0;
}

.thumbnail-borderless .thumbnail {
	border: none;
	padding: 0;
	-webkit-border-radius: 0;
	-moz-border-radius: 0;
	border-radius: 0;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
}

.fileupload-new.thumbnail-borderless .thumbnail {
	border: 1px solid #ddd;
}

.control-group.warning .fileupload .uneditable-input {
	color: #a47e3c;
	border-color: #a47e3c;
}

.control-group.warning .fileupload .fileupload-preview {
	color: #a47e3c;
}

.control-group.warning .fileupload .thumbnail {
	border-color: #a47e3c;
}

.control-group.error .fileupload .uneditable-input {
	color: #b94a48;
	border-color: #b94a48;
}

.control-group.error .fileupload .fileupload-preview {
	color: #b94a48;
}

.control-group.error .fileupload .thumbnail {
	border-color: #b94a48;
}

.control-group.success .fileupload .uneditable-input {
	color: #468847;
	border-color: #468847;
}

.control-group.success .fileupload .fileupload-preview {
	color: #468847;
}

.control-group.success .fileupload .thumbnail {
	border-color: #468847;
}
</style>
<style type="text/css">
.blocker{z-index:1000;height:100%;width:100%;background: aqua; opacity:0.3; position: absolute;}
.aboveAll{z-index:1010; text-align: middle;}
</style>

<script type="text/javascript">
$(document).ready(function() {
    
    var navListItems = $('ul.setup-panel li a'),
        allWells = $('.setup-content');

    allWells.hide();

    navListItems.click(function(e)
    {
        e.preventDefault();
        var $target = $($(this).attr('href')),
            $item = $(this).closest('li');
        
        if (!$item.hasClass('disabled')) {
            navListItems.closest('li').removeClass('active');
            $item.addClass('active');
            allWells.hide();
            $target.show();
        }
    });
    
    $('ul.setup-panel li.active a').trigger('click');    
    
     $('#btn-complete_profile').on('click', function(e) {
     
     	//alert('complete');
     	$('#expr1').attr('disabled', false);
     	$('#expr2').attr('disabled', false);
     	$('#expr3').attr('disabled', false);
     	alert('submitting');
     	document.upload_form.submit();
     	/* $('#expr1').attr('disabled', false);
     	$('#expr2').attr('disabled', false);
     	$('#expr3').attr('disabled', false);	
     	$('#ref_doc_dl').attr('disabled', false);
     	$('#ref_doc_pan').attr('disabled', false);
     	
     	$.ajax({
					type : "POST",
					url : "/sahaay/profileMgmt/saveProfile",
					data : JSON.stringify($('#signup_step2').serializeObject()),
					contentType : 'application/json',
					dataType : "text",
					success : function(resp){
					
								alert('saved profile data');
								},
					error : function(xhr) {
						alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
								+ xhr.status);
						console.log(xhr);
					}
				}); 
     	
     	console.log(JSON.stringify($('#signup_step2').serializeObject()));
   		alert(JSON.stringify($('#signup_step2').serializeObject())); */
     
      }); 
    $('#btn-register').on('click', function(e) {
    
    	var svrId = $("#service_id option:selected").val();
    	var cityId = $("#city option:selected").val();
   		var localityId = $("#locality option:selected").val();
   		var customer_id = $("#id").val();
   		
   		alert(svrId+"-"+cityId+"-"+localityId+"-"+customer_id);
   		// ajax call to register
   		console.log(JSON.stringify($('#signup_form').serializeObject()));
   		alert(JSON.stringify($('#signup_form').serializeObject()));
   		
   		$('#shadow').addClass('blocker');  
		$.ajax({
					type : "POST",
					url : "/sahaay/profileMgmt/createAccount",
					data : JSON.stringify($('#signup_form').serializeObject()),
					contentType : 'application/json',
					dataType : "text",
					success : function(resp){
						
						if($('#shadow').hasClass('blocker'))
						       $('#shadow').removeClass('blocker');  
								$('#service').val(svrId);
						   		$('#city_id').val(cityId);
						   		$('#customer_id').val(customer_id);
						   		$("#line_3").val(localityId);
								
								
								$('ul.setup-panel li:eq(1)').removeClass('disabled');
						        $('ul.setup-panel li a[href="#step-2"]').trigger('click');
						        $(this).remove();
								},
					error : function(xhr) {
						if($('#shadow').hasClass('blocker'))
						       $('#shadow').removeClass('blocker');  
						alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
								+ xhr.status);
						console.log(xhr);
					}
				});
    });  
    
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
    
   var badgesCount = 0;
					// custom script
					$("#service_id").change(
										function(event) {
											//alert('service selected/changed !');
											var svrId = $("#service_id option:selected").val();
											//alert(svrId);
											if (svrId == 'Driver') {
												badgesCount = badgesCount+1;
												//alert('add prefs for a '+ svrId);
												$('#pref1')
														.html(
																"<div class='form-group'><label for='param4' class='col-md-4 control-label'>Experience details&nbsp;&nbsp;&nbsp;<span style='color: red;'>*</span></label><div class='col-md-2'><select class='form-control' id='expr1' name='badgesOwned.param1' disabled='disabled'><option value='EXPR' SELECTED>Regular Cars</option></select>&nbsp;</div><div class='col-md-1'><input class='form-control' type='text' id='exprv1' name='badgesOwned.value1' placeholder='years'/></div></div> ");
												$('#pref1')
														.append(
																"<div class='form-group'><label for='param4' class='col-md-4 control-label'></label><div class='col-md-2'><select class='form-control' id='expr2' name='badgesOwned.param2' disabled='disabled'><option value='EXP_PREMIUM'  SELECTED>Premium Cars</option></select>&nbsp;</div><div class='col-md-1'><input class='form-control' type='text' placeholder='years' id='value2' name='badgesOwned.value2' /></div></div> ");
												$('#pref1')
														.append(
																"<div class='form-group'><label for='param4' class='col-md-4 control-label'></label><div class='col-md-2'><select class='form-control' id='expr3' name='badgesOwned.param3' disabled='disabled'><option value='EXP_SUPER_PREMIUM'  SELECTED>Super Premium Cars</option></select>&nbsp;</div><div class='col-md-1'><input class='form-control' type='text' placeholder='years' id='value3' name='badgesOwned.value3' /></div></div> ");
											
												$('#pref2')
														.html(
																"<label for='dl' class='col-md-4 control-label'>Upload Driving License &nbsp;&nbsp;&nbsp;<span style='color: red;'>*</span></label> <div class='col-md-4'> <div class='fileupload fileupload-new' data-provides='fileupload'> <span id='uploadBtn' class='btn btn-info btn-file pull-left'> <span class='fileupload-new'>Choose a jpeg/png</span> <span class='fileupload-exists'>Change</span><input type='file' id='dl_file' name='files[2].files'/></span> <span class='fileupload-preview'></span> <a href='#' class='close fileupload-exists' data-dismiss='fileupload' style='float: none'>×</a> <input name='files[2].provider' id='files[2].provider' value='' type='hidden'/><input name='files[2].doc_id' id='files[2].doc_id' value='DRIVING_LICENSE' type='hidden' /> </div> </div>");
												
												
											} else if (svrId == 'xxxx') {
												//alert('clear prefs');
												$('#pref1').html("");
												$('#pref2').html("");
												$('#locality').html("");
											}
										});

						
					/* $('#add_new_badge').on('click', function() {					
						alert('adding anther exp row');
						$('#pref1_'+badgesCount).html("<div class='form-group'><label for='param4' class='col-md-4 control-label'>Experience details&nbsp;&nbsp;&nbsp;<span style='color: red;'>*</span></label><div class='col-md-4'><select class='form-control' id='param4' name='param4' disabled='disabled'><option value='EXPR'>Regular Cars</option><option value='EXP_PREMIUM'>Premium Cars</option><option value='EXP_SUPER_PREMIUM'>Super Premium Cars</option></select><a href='#' id='add_new_badge' class='pull-right' disabled='disabled'>Add Expr Row</a></div></div> <div id='pref1_'+badgeCount></div>");
						
					}); */
					
					/* $("#input[name='years']").blur(function() {
									alert('expr changed/fed !');
									var hasValue = $("input[id='lang']").val();
									alert(hasValue);
									if(hasValue == true){
									
										$('#ref_docs_dl').attr('disabled', false);
										$('#ref_docs_pan').attr('disabled', false);
									}else{
										$('#ref_docs_pan').attr('disabled', true);
										$('#ref_docs_dl').attr('disabled', true);
									}
									
						});  */
						
				 /* $('#uploadBtn').on('click',function(event){						
						alert('ckicked');	
						$('#name').attr('disabled', false);				
					}); */
					
					
					/* $('#upload_pic_form').change(function(event){
						document.upload_pic_form.submit();
					});
					$('#upload_pan_form').change(function(event){
						document.upload_pan_form.submit();
					});
					$('#upload_dl_form').change(function(event){
						document.upload_dl_form.submit();
					}); */
					
					$('#value1').blur(function(event){
						alert("yahoo value");
						
					});
					
					var _validFileExtensions = [".jpg", ".jpeg", ".bmp",".png", ".pdf"];
					var _validFileExtensionsForProfile = [".jpg", ".jpeg", ".bmp",".png"];
					$('#pic_file').change(function(event){
						//alert($('#pic_file').val());
						var ufile = document.upload_form.pic_file;
						if(ufile.type == "file") {
							//alert('its of type file');
							var blnValid = false;
							var sFileName = ufile.value;
			                for (var j = 0; j < _validFileExtensionsForProfile.length; j++) {
			                    var sCurExtension = _validFileExtensionsForProfile[j];
			                    if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
			                        blnValid = true;
			                        break;
			                    }
			                }							
						}
						
						if (!blnValid) {
							$('#pic_error').html("Allowed extensions are: " + _validFileExtensionsForProfile.join(", "));
							$('#pic_error').css('display', 'block');
		                    $('#pic_file').val("");
		                    //return false;
		                } else {		     
		                	$('#pic_error').html("");
							$('#pic_error').css('display', 'none');           
							$('#dl_file').attr('disabled', false);
							$('#dl_file').focus();
						}						
					});
					
					$('#dl_file').change(function(event){
						//alert($('#dl_file').val());
						var ufile = document.upload_form.dl_file;
						if(ufile.type == "file") {
							//alert('its of type file');
							var blnValid = false;
							var sFileName = ufile.value;
			                for (var j = 0; j < _validFileExtensions.length; j++) {
			                    var sCurExtension = _validFileExtensions[j];
			                    if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
			                        blnValid = true;
			                        break;
			                    }
			                }							
						}
						
						if (!blnValid) {
							$('#dl_error').html("Allowed extensions are: " + _validFileExtensions.join(", "));
							$('#dl_error').css('display', 'block');
		                    $('#dl_file').val("");
		                    //return false;
		                } else {		     
		                	$('#dl_error').html("");
							$('#dl_error').css('display', 'none');           
							$('#pan_file').attr('disabled', false);
							$('#pan_file').focus();
						}						
					});
					
					$('#pan_file').change(function(event){
						//alert($('#pan_file').val());
						var ufile = document.upload_form.pan_file;
						if(ufile.type == "file") {
							//alert('its of type file');
							var blnValid = false;
							var sFileName = ufile.value;
			                for (var j = 0; j < _validFileExtensions.length; j++) {
			                    var sCurExtension = _validFileExtensions[j];
			                    if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
			                        blnValid = true;
			                        break;
			                    }
			                }							
						}
						
						if (!blnValid) {
							$('#pan_error').html("Allowed extensions are: " + _validFileExtensions.join(", "));
							$('#pan_error').css('display', 'block');
		                    $('#pan_file').val("");
		                    //return false;
		                } else {		     
		                	$('#pan_error').html("");
							$('#pan_error').css('display', 'none');           
							/* $('#line_1').attr('disabled', false);
							$('#line_1').focus(); */
						}						
					});
				
					$('#line_1').blur(function(event){
						//alert($('#exprv1').val());
						var line_1 = $('#line_1').val();
						if(line_1 != "" && line_1.length > 4){
							$('#line_2').attr('disabled', false);
							$('#line1_error').html("");
							$('#line1_error').css('display', 'none');
							$('#line_2').focus();
							}else{
								$('#line1_error').html("Address line1 is mandatory and must be minimum 4 characters.");		
								$('#line1_error').css('display', 'block');     					
							}						
					});
					
					$('#line_2').blur(function(event){
						var line_2 = $('#line_1').val();
						if(line_2 != "" && line_2.length > 4){
							$('#addrcity').attr('disabled', false);		
							$('#line2_error').html("");
							$('#line2_error').css('display', 'none');
							$('#addrcity').focus();
						}else{
							$('#line2_error').html("Address line2 is mandatory and must be minimum 4 characters.");	
							$('#line2_error').css('display', 'block');  	
						}
					});
					
					$('#addrcity').blur(function(event){
					if($('#addrcity').val() != "")
						$('#pin').attr('disabled', false);						
					});
					
					$('#pin').blur(function(event){
					if($('#pin').val() != "" && $('#pin').val().length == 6 && $.isNumeric($('#pin').val() ))
						$('#addrstate').attr('disabled', false);						
					});
					
					$('#addrstate').blur(function(event){
					if($('#addrstate').val() != "")
						$('#addrcountry').attr('disabled', false);						
					});
					
					$('#addrcountry').blur(function(event){
					if($('#addrcountry').val() != "")
						$('#refName1').attr('disabled', false);
						$('#refContactNum1').attr('disabled', false);	
						$('#refName2').attr('disabled', false);
						$('#refContactNum2').attr('disabled', false);	
						$('#btn-complete_profile').attr('disabled', false);					
					});
					
					/* $('#ref_docs_pan').ajaxfileupload({
					  'action': 'BaS/sahaay/profileMgmt/uploadFile',					  
						'onComplete': function(response) {				
					 					$('#upload').hide();					
					 					alert("File SAVED!!");
									 },
					
						   'onStart': function() {
						  			 $('#upload').show();
									}
					}); */
					
					$('#exprv1').blur(function(){
						alert('moved away from exp1');
						var name = $('#exprv1').val();
						if(name != ""){
							$('#ref_docs_dl').attr('disabled', false);
							$('#ref_docs_pan').attr('disabled', false);	
						}
					});
					
					$('#value2').blur(function(){
						alert('moved away from exp2');
						var name = $('#value2').val();
						if(name != ""){
							$('#ref_docs_dl').attr('disabled', false);
							$('#ref_docs_pan').attr('disabled', false);	
						}
					});
					
					$('#value3').blur(function(){
						alert('moved away from exp3');
						var name = $('#value3').val();
						if(name != ""){
							$('#ref_docs_dl').attr('disabled', false);
							$('#ref_docs_pan').attr('disabled', false);	
						}
					});

					
					/* $('#id').blur(function(){
						//alert('moved away from user id');
						var id = $('#id').val();
						//alert(id);
												
						if(id != ""){
							$.ajax({
								type : "GET",
								url : "/sahaay/auth/checkUserId/"+id,
								cache : false,
								dataType : "text",
								success : function(resp){
											if(resp == "true"){
												$('#password').attr('disabled', false);	
												$('#userid_error').css('display', 'none');
											}else{
												$('#userid_error').html("UserId is already taken. Please choose another one.");
												$('#userid_error').css('display', 'block');
											}
										},
								error : function(xhr) {
								alert("AJAX request failed: "
											+ xhr.status);
								}
							});	
						}
					}); */
					
					$('#password').blur(function(){
						//alert('moved away from password');
						var pwd = $('#password').val();
						
						if(pwd != "" && pwd.length > 6){
							$('#pwd_error').html("");
							$('#pwd_error').css('display', 'none');
							$('#confirmPwd').attr('disabled', false);		
						}else{
							$('#pwd_error').html("");
							$('#pwd_error').html("Password must be atleast 6 characters.");
							$('#pwd_error').css('display', 'block');
						}
					});
					
					$('#confirmPwd').blur(function(){
						//alert('moved away from confirmPwd');
						var cpwd = $('#confirmPwd').val();
						var pwd = $('#password').val();
						//alert(pwd+"_vs_"+cpwd);
						if(cpwd != "" && cpwd.length > 6 && cpwd == pwd){
							$('#cpwd_error').html("");
							$('#cpwd_error').css('display', 'none');
							$('#name').attr('disabled', false);		
						}else{
							$('#cpwd_error').html("Passwords didnot match. Please try again.");
							$('#cpwd_error').css('display', 'block');
						}
					});
					
					$('#name').blur(function(){
						//alert('moved away from name');
						var name = $('#name').val();
						if(name != "" && name.length > 2){
							$('#userid_error').html("");
							$('#userid_error').css('display', 'none');
							$('#mobile').attr('disabled', false);
							$('#mobile').focus();
				
						}else{
							
							$('#userid_error').html("Name is required and must contain atleast 2 characters.");
							$('#userid_error').css('display', 'block');
						}
					});
					
					$('#mobile').blur(function(){
						//alert('moved away from mobile');
						var mobile = $('#mobile').val();
												
						if(mobile != "" && $.isNumeric(mobile) && (mobile.length > 9 && mobile.length < 12)){
							$('#shadow').addClass('blocker');  
							$.ajax({
								type : "GET",
								url : "/sahaay/auth/checkUserId/"+mobile,
								cache : false,
								dataType : "text",
								success : function(resp){
											//alert('returned from checking id');
											//alert(resp);
											if(resp == "true"){
												
												if($('#shadow').hasClass('blocker'))
												       $('#shadow').removeClass('blocker');  
												$('#mobile_error').html("");
												$('#mobile_error').css('display', 'none');
												$('#btn-register').attr('disabled', false);	
												
												$('#id').val(mobile);
												$('#password').val(mobile);	
												
												$('#btn-register').focus();
											}else{
												$('#mobile_error').html("Our system has a registration already exists with this mobile number. Try with another mobile number.");
												$('#mobile_error').css('display', 'block');
											}
										},
								error : function(xhr) {
										alert("AJAX request failed: " + xhr.status);
								}
							});	
						
						
						}else{
									$('#mobile_error').html("Mobile number must be numeric and not more than 11 digits.");
									$('#mobile_error').css('display', 'block');
						}
						
					});
					
					$("#locality").change(
								function(event) {
									//alert('location selected/changed !');
									var locality = $("#locality option:selected").val();
									if(locality == "" || locality == undefined || locality == 'xxxx'){
										$('#spsignup_alert').html("Please select a Locality !");
									}
									
									var cityId = $("#city option:selected").val();
									if (cityId == 'xxxx') {
										$('#locality').html("");	
										$('#locality').attr('disabled', true);
										$('#ref_docs_pan').attr('disabled', true);
										$('#ref_docs_dl').attr('disabled', true);						
									} else {
												
										if($('#shadow').hasClass('blocker'))
										       $('#shadow').removeClass('blocker');  
											$('#name').attr('disabled', false);
											$('#name').focus();
											
											//$("input[id='lang']").removeAttr("disabled");
											//$('#ref_docs_dl').attr('disabled', false);
											//$('#ref_docs_pan').attr('disabled', false);
									}

								});
								
					
					$("input[id='lang']").change(function(event) {
									//alert('lang changed !');
									var langChecked = $("input[id='lang']").is(':checked');
									//alert(langChecked);
									
									if(langChecked == true){
										
										var langVals = $("input[id='lang']:checked").map(
    										 function () {return this.value;}).get().join(",");
    										 
										
										$('#languages').val(langVals);										

										$("#line_1").attr('disabled', false);
										//$('#ref_docs_dl').attr('disabled', false);
										//$('#ref_docs_pan').attr('disabled', false); 
									}else{
										
									}
									
						});
						
						
					$("#city").change(
								function(event) {
									//alert('location selected/changed !');
									var svrId = $("#type option:selected").val();
									if(svrId == "" || svrId == 'xxxx'){
										alert('no service');
										$('#spsignup_alert').html("Please select Service !");
										$('#spsignup_alert').css('display', 'block');
										return false;
									}else{
									
									var cityId = $("#city option:selected")
											.val();
									//alert("BaS/sahaay/metadata/"+cityId+"/localities");
									if (cityId == 'xxxx') {
										$('#locality').html("");	
										$('#locality').attr('disabled', true);
									} else {
										$('#shadow').addClass('blocker');  
										$.ajax({
											type : "GET",
											url : "/sahaay/metadata/"
													+ cityId + "/localities",
											cache : false,
											dataType : "text",
											success : process_localities,
											error : function(xhr) {
												if($('#shadow').hasClass('blocker'))
												       $('#shadow').removeClass('blocker');  
												alert("AJAX request failed: "
														+ xhr.status);
											}
										});
									}
									}
								});

						function process_localities(response) {
							if($('#shadow').hasClass('blocker'))
							       $('#shadow').removeClass('blocker');  
							//alert(response); // for debug
							var finalData = jQuery.parseJSON(response);
							var rows = 0;
											
							$('#locality')
									.html(
											'<option value="xxxx">Select a Locality</option>');
							$.each(finalData, function(index, value) {
								$("#locality").append(
										'<option value="'+value+'">' + value
												+ '</option>');
								rows = rows+1;
							});
							
							if(rows < 1){
								$('#locality').html("");
								//alert('Opps !! we are yet to expand to this city !!')
							}else {
								$('#locality').attr('disabled', false);
							}
						}
						
						!function(e){var t=function(t,n){this.$element=e(t),this.type=this.$element.data("uploadtype")||(this.$element.find(".thumbnail").length>0?"image":"file"),this.$input=this.$element.find(":file");if(this.$input.length===0)return;this.name=this.$input.attr("name")||n.name,this.$hidden=this.$element.find('input[type=hidden][name="'+this.name+'"]'),this.$hidden.length===0&&(this.$hidden=e('<input type="hidden" />'),this.$element.prepend(this.$hidden)),this.$preview=this.$element.find(".fileupload-preview");var r=this.$preview.css("height");this.$preview.css("display")!="inline"&&r!="0px"&&r!="none"&&this.$preview.css("line-height",r),this.original={exists:this.$element.hasClass("fileupload-exists"),preview:this.$preview.html(),hiddenVal:this.$hidden.val()},this.$remove=this.$element.find('[data-dismiss="fileupload"]'),this.$element.find('[data-trigger="fileupload"]').on("click.fileupload",e.proxy(this.trigger,this)),this.listen()};t.prototype={listen:function(){this.$input.on("change.fileupload",e.proxy(this.change,this)),e(this.$input[0].form).on("reset.fileupload",e.proxy(this.reset,this)),this.$remove&&this.$remove.on("click.fileupload",e.proxy(this.clear,this))},change:function(e,t){if(t==="clear")return;var n=e.target.files!==undefined?e.target.files[0]:e.target.value?{name:e.target.value.replace(/^.+\\/,"")}:null;if(!n){this.clear();return}this.$hidden.val(""),this.$hidden.attr("name",""),this.$input.attr("name",this.name);if(this.type==="image"&&this.$preview.length>0&&(typeof n.type!="undefined"?n.type.match("image.*"):n.name.match(/\.(gif|png|jpe?g)$/i))&&typeof FileReader!="undefined"){var r=new FileReader,i=this.$preview,s=this.$element;r.onload=function(e){i.html('<img src="'+e.target.result+'" '+(i.css("max-height")!="none"?'style="max-height: '+i.css("max-height")+';"':"")+" />"),s.addClass("fileupload-exists").removeClass("fileupload-new")},r.readAsDataURL(n)}else this.$preview.text(n.name),this.$element.addClass("fileupload-exists").removeClass("fileupload-new")},clear:function(e){this.$hidden.val(""),this.$hidden.attr("name",this.name),this.$input.attr("name","");if(navigator.userAgent.match(/msie/i)){var t=this.$input.clone(!0);this.$input.after(t),this.$input.remove(),this.$input=t}else this.$input.val("");this.$preview.html(""),this.$element.addClass("fileupload-new").removeClass("fileupload-exists"),e&&(this.$input.trigger("change",["clear"]),e.preventDefault())},reset:function(e){this.clear(),this.$hidden.val(this.original.hiddenVal),this.$preview.html(this.original.preview),this.original.exists?this.$element.addClass("fileupload-exists").removeClass("fileupload-new"):this.$element.addClass("fileupload-new").removeClass("fileupload-exists")},trigger:function(e){this.$input.trigger("click"),e.preventDefault()}},e.fn.fileupload=function(n){return this.each(function(){var r=e(this),i=r.data("fileupload");i||r.data("fileupload",i=new t(this,n)),typeof n=="string"&&i[n]()})},e.fn.fileupload.Constructor=t,e(document).on("click.fileupload.data-api",'[data-provides="fileupload"]',function(t){var n=e(this);if(n.data("fileupload"))return;n.fileupload(n.data());var r=e(t.target).closest('[data-dismiss="fileupload"],[data-trigger="fileupload"]');r.length>0&&(r.trigger("click.fileupload"),t.preventDefault())})}(window.jQuery)
    
    
    				/* $('#btn-register').on('click', function(event){    				
    					alert('button clicked');
    					alert(JSON.stringify($('#signup_form').serializeObject()));
    					console.log(JSON.stringify($('#signup_form').serializeObject()));
    				}); */
    				
    				
    
    
});

</script>

</head>
<body>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td style="background-image:url(${pageContext.request.contextPath}/images/top.jpg); background-repeat:repeat-x">
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="1003">
      <tbody><tr>
        <td style="width: 646px;" class="menu_nav" height="40">
							<a href="/" class="menu_nav" style="text-decoration:none;color:#fff;">Home</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/howitworks" class="menu_nav" style="text-decoration:none;color:#fff;">How It Works </a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/services" class="menu_nav" style="text-decoration:none;color:#fff;">Services</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/aboutus" class="menu_nav" style="text-decoration:none;color:#fff;">About Us</a></td>
							<td style="width: 100px;" height="40"><a href="/sahaay/profileMgmt/loginRegister" class="subheading_link" style="text-decoration:none;color:#fff;">Login/Register</a></td>
							
<td style="width: 160px;" height="40"><select name="listprofile" style="border: 1px solid rgb(255, 255, 255); width: 150px; height: 23px; background-color: rgb(255, 255, 255);" id="listcity"><option class="para">Hyderabad</option><option class="para">Bangalore</option></select>
          <br /></td>
        <td style="width: 108px;" height="40"><table style="margin-left: 0px; width: 98px;" align="right" border="0" cellpadding="0" cellspacing="0" width="47%">
          <tbody><tr>
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
        </tbody></table></td>
      </tr>
    </tbody></table></td>
  </tr>
</table>
<div id="shadow">    </div>
<div class="container" style="margin-top: 20px;">
<div class="row form-group">
			<div class="col-xs-12">
				<ul class="nav nav-pills nav-justified thumbnail setup-panel">
					<li class="active"><a href="#step-1">
							<h4 class="list-group-item-heading">Step 1</h4>
							<p class="list-group-item-text">Service you can offer</p>
					</a></li>
					<li class="disabled"><a href="#step-2">
							<h4 class="list-group-item-heading">Step 2</h4>
							<p class="list-group-item-text">Some Additional Information</p>
					</a></li>
				</ul>
			</div>
		</div>
<div class="row setup-content" id="step-1">
			<div class="col-xs-12">
				<div class="col-md-12 well text-center">
					<div class="container">
						<div class="row">
							<div class="span6">
								<div class="panel-body">									
									<!-- <div class="panel-heading pull-left">
										<div class="panel-title"><h3>Service Provider Registration</h3></div>										
									</div><br><br><br><br> -->
									<form id="signup_form" class="form-horizontal" action="" method="post">
										<div id="spsignup_alert" style="display: none"
											class="alert alert-danger">
											<span></span>
										</div>
										<div class="form-group">
											<label for="service_id" class="col-md-4 control-label">What
												service do you offer</label>
											<div class="col-md-4">
												<select class="form-control" id="service_id" name="service_id">
													<option value="xxxx">Choose a service</option>
													<option value="Driver">Driver</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label for="city" class="col-md-4 control-label">In
												which City&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
											<div class="col-md-4">
												<select class="form-control" id='city'
													placeholder="City/Location">
													<option value="xxxx">Select a city</option>
													<option value="Hyderabad">Hyderabad</option>
													<option value="Bengaluru">Bangalore</option>
												</select>
											</div>
										</div>

										
										<div class='form-group'>
											<label for='locality' class='col-md-4 control-label'>Locality&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
											<div class='col-md-4'>
												<select class='form-control' id='locality' disabled='disabled'></select>
											</div>											
										</div>
										<hr width="75%"> <!-- seperator -->
										<div id="creds_alert" style="display: none" class="alert alert-danger">
											<span></span>
										</div>
										
										<div class="form-group">
											<label for="name" class="col-md-4 control-label">
												Name&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
											<div class="col-md-4">
												<input type='text' class="form-control" id="name"
													name="name"  disabled="disabled"/><span id='userid_error' style="display: none" class="alert alert-danger"></span>
											</div>
										</div>
										<div class="form-group">
											<label for="mobile" class="col-md-4 control-label">
												Contact Number&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
											<div class="col-md-4">
												<input type='text' class="form-control" id="mobile" name="mobile"  disabled="disabled"/><span id='mobile_error' style="display: none" class="alert alert-danger"></span>
												<input name="id" id="id" value="" type="hidden" />
												<input name="password" id="password" value="" type="hidden" />
												<input name="type" id="type" value="PROVIDER" type="hidden" />
											</div>
										</div>
										<hr width="75%"> <!-- seperator -->
										
										<div class="form-group">
											<!-- Button -->
											<div class="col-md-offset-4 col-md-4">
												<button id="btn-register" type="button" class="btn btn-primary" disabled="disabled">
													<i class="icon-hand-right"></i>Register & Proceed !
												</button>
											</div>
										</div>
										
									</form>
								</div>
							</div>
							<!-- .span8 -->
						</div>
					</div>
				</div>
			</div>
		
		</div>
		</div>
<div class="row setup-content" id="step-2">
				
				<div class="col-md-12 well text-center">
					<div class="container">
						<div class="row">
							<div class="span6">
								<div class="panel-body">
								<f:form id="upload_form" name="upload_form" class="form-horizontal" action="/sahaay/profileMgmt/uploadFile" method="post" modelAttribute="prof" enctype="multipart/form-data">
									<div class="form-group">
											<label for="dl" class="col-md-4 control-label">Upload
												Profile Pic &nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
											<div class="col-md-4">	
											<div class="fileupload fileupload-new" data-provides="fileupload">
											    <span id='uploadBtn' class="btn btn-info btn-file pull-left">
											    	<span class="fileupload-new">Choose a jpeg/png</span>
											    	<span class="fileupload-exists">Change</span><input type="file" id='pic_file' name='files[0].files'/></span>
											    <span class="fileupload-preview"></span>
											    <a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">×</a>
											    <input name="files[0].doc_id" id="files[0].doc_id" value="PROFILE_PIC" type="hidden" />
											    <input name='files[0].provider' id='files[0].provider' value='' type='hidden'/>
											 </div>
											 <span id='pic_error' style="display: none" class="alert alert-danger"></span>
											  </div>
										</div>
										
									<div class="form-group" id="pref2">
											
										</div>
									<div class="form-group">
											<label for="dl" class="col-md-4 control-label">Upload
												PAN Card &nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
											<div class="col-md-4">	
											<div class="fileupload fileupload-new" data-provides="fileupload">
											    <span id='uploadBtn' class="btn btn-info btn-file pull-left">
											    	<span class="fileupload-new">Choose a jpeg/png</span>
											    	<span class="fileupload-exists">Change</span><input type="file" id='pan_file' name='files[1].files'/></span>											    	
											    <span class="fileupload-preview"></span>
											    <a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">×</a>
											    
											    <input name="files[1].doc_id" id="files[1].doc_id" value="PAN_CARD" type="hidden" />
											    <input name='files[1].provider' id='files[1].provider' value='' type='hidden'/>
											 </div>
											 <span id='pan_error' style="display: none" class="alert alert-danger"></span>
											  </div>
										</div>	
										
										<div class="form-group">										
											<input name="service" id="service" value="" type="hidden" />
											<input name="city_id" id="city_id" value="" type="hidden" />
											<input name='address.line_3' id="line_3" value="" type="hidden" />
											<input name="customer_id" id="customer_id" value="" type="hidden" />
											<input name="badgesOwned.value4" id="languages" value="" type="hidden" />
											<input name="badgesOwned.param4" id="badgesOwned.param4" value="LANG" type="hidden" />
											<hr>
										</div>
										<div class="form-group">
											<label for="pkg_code" class="col-md-4 control-label">Languages
												Spoken &nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
											<div class="col-md-4">
												<input type="checkbox" value="English" id="lang" >
												English <input type="checkbox" value="Hindi" id="lang" >
												Hindi <input type="checkbox" value="Telugu" id="lang" >
												Telugu <input type="checkbox" value="Tamil" id="lang" >
												Tamil <input type="checkbox" value="Kannada" id="lang" >
												Kannada
											</div>
										</div>
										<div class="form-group" id="pref1"></div>
										

										<hr width="75%"> 								
										
										<div class="form-group">
										
											<label for="misc[info3]" class="col-md-4 control-label">Complete
												Address &nbsp;&nbsp;&nbsp;<span style="color: red;">*</span>
											</label>
											<div class="col-md-4">
													<input type='text' class="form-control" id="line_1"
													name="address.line_1"  disabled="disabled" placeHolder="address line1"/>
													<span id='line1_error' style="display: none" class="alert alert-danger"></span>
											</div>
										</div>
										<div class="form-group">
											<label for="mobile" class="col-md-4 control-label"><span style="color: red;"></span></label>
											<div class="col-md-4">
													<input type='text' class="form-control" id="line_2"
													name="address.line_2"  disabled="disabled" placeHolder="address line2"/>
													<span id='line2_error' style="display: none" class="alert alert-danger"></span>
											</div>
										</div>
										
										<div class="form-group">
											<label for="pin" class="col-md-4 control-label"><span style="color: red;">*</span></label>
												<div class="col-md-2">
													
													<select class="form-control" id='addrcity' name="address.city"   disabled="disabled" 
													placeholder="City">
													<option value="xxxx">Select a city</option>
													<option value="Hyderabad">Hyderabad</option>
													<option value="Bengaluru">Bangalore</option>
												</select>
											</div>
											<div class="col-md-2">
													<input type='text' class="form-control" id="pin"
													name="address.zipcode"  disabled="disabled" placeHolder="zipcode"/>
													<span id='pin_error' style="display: none" class="alert alert-danger"></span>
											</div>											
										</div>
										
										<div class="form-group">
											<label for="addrstate" class="col-md-4 control-label"><span style="color: red;">*</span></label>
											<div class="col-md-2">													
													<select class="form-control" id='addrstate' name="address.state"   disabled="disabled" 
													placeholder="State">
													<option value="xxxx">State</option>
													<option value="Andhra Pradesh">Andhra Pradesh</option>
													<option value="Karnataka">Karnataka</option></select>
											</div>
											<div class="col-md-2">													
													<select class="form-control" id='addrcountry' name="address.country"   disabled="disabled" 
													placeholder="Country">
													<option value="xxxx">Country</option>
													<option value="India">India</option></select>
										</div>
										</div>
										
										<div class="form-group">
											<label for="pref1_address" class="col-md-4 control-label">Reference 1 &nbsp;&nbsp;&nbsp;<span style="color: red;"></span>
											</label>
											<div class="col-md-4">
												<input type="text" class="form-control" id="refName1" name="refs[0].refName"
													disabled="disabled" placeHolder="Ref Contact Name">
											</div>
										</div>
										<div class="form-group">
											<label for="pref1_contactNo" class="col-md-4 control-label"><span style="color: red;"></span></label>
											<div class="col-md-4">
												<input type="text" class="form-control" id="refContactNum1" name="refs[0].refContactNum"
													disabled="disabled" placeHolder="Ref Contact No">
											</div>
										</div>
										<div class="form-group">
											<label for="pref2_contactName" class="col-md-4 control-label">Reference 2 
												 &nbsp;&nbsp;&nbsp;<span style="color: red;"></span>
											</label>
											<div class="col-md-4">
												<input type="text" class="form-control" id="refName2" name="refs[1].refName"
													disabled="disabled" placeHolder="Ref Contact Name">
											</div>
										</div>
										<div class="form-group">
											<label for="pref2_contactNo" class="col-md-4 control-label"><span style="color: red;"></span></label>
											<div class="col-md-4">
												<input type="text" class="form-control" id="refContactNum2" name="refs[1].refContactNum"
													 disabled="disabled" placeHolder="Ref Contact No">
											</div>
										</div> 
										<div class="form-group">
											<hr>
										</div>

										<div class="form-group">
											<!-- Button -->
											<div class="col-md-offset-4 col-md-4">
												<button id="btn-complete_profile" type="button" class="btn btn-primary" disabled="disabled">
													<i class="icon-hand-right"></i>Register me now !
												</button>
											</div>
										</div>
								</f:form>
								
										</div>
										</div>
										</div>	</div>
				</div>
			</div>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="90" style="background-image:url(${pageContext.request.contextPath}/images/footer.jpg); background-repeat:repeat-x"><table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="528" class="menu_nav"><strong>FAQ's   &nbsp;&nbsp;Blog   &nbsp;&nbsp;Carrers</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Toll free</strong> +91 1800 1234 5678</td>
        <td width="220"><table width="60%" border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td colspan="2"><input type="text" name="txtlastname" id="txtlastname" style="width:150px; height:18px; border:1px solid #fff; border-radius:3px;" /></td>
            </tr>
            <tr>
              <td class="menu_nav"><span class="para">
                <input type="checkbox" name="checkbox3" id="checkbox3" />
              </span></td>
              <td class="menu_nav">Keep Login</td>
            </tr>
        </table></td>
        <td width="126"><table width="60%" border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td><input type="text" name="txtlastname2" id="txtlastname2" style="width:150px; height:18px; border:1px solid #fff; border-radius:3px;" /></td>
            </tr>
            <tr>
              <td class="menu_nav">Forget Password</td>
            </tr>
        </table></td>
        <td width="129" align="center" valign="top"><img src="${pageContext.request.contextPath}/images/login.png" alt="login" width="78" height="29" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>