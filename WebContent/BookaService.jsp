<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sahaay : Book A Service</title>
<link type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" />
<link type="text/css" href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
<link type="text/css" href="${pageContext.request.contextPath}/css/jquery.simple-dtpicker.css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.simple-dtpicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.serializeJSON.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqBootstrapValidation.js"></script>


<style>
/* body {
	margin-top: 20px;
} */

.thumbnail.right-caption > img {
    float: left;
    margin-right: 9px;
}

.thumbnail.right-caption {
    float: left;
}

.thumbnail.right-caption > .caption {
    padding: 4px;
}

.glyphicon { margin-right:5px;}
.rating .glyphicon {font-size: 22px; color:#FFA500;}
.rating-num { margin-top:0px;font-size: 54px; }
.progress { margin-bottom: 5px;}
.progress-bar { text-align: left; }
.rating-desc .col-md-3 {padding-right: 0px;}
.sr-only { margin-left: 5px;overflow: visible;clip: auto; }

.form-inline .form-group { margin-right:10px; }
.well-primary {
color: rgb(255, 255, 255);
background-color: rgb(66, 139, 202);
border-color: rgb(53, 126, 189);
}
.glyphicon { margin-right:5px; }
/* .modal-content {
  background-color: #0480be;
} */
.modal-body {
  background-color: #fff;
}
</style>
<style type="text/css">
.blocker{z-index:1000;height:100%;width:100%;background: white; opacity:0.3; position: absolute;}
.aboveAll{z-index:1010; text-align: middle;}
</style>
<script type="text/javascript">
	function modifySearch(){
		//alert('modifying..');
		$('ul.setup-panel li:eq(2)').removeClass('disabled');
		$('ul.setup-panel li a[href="#step-1"]').trigger('click');
		$('#btn-search').attr('disabled', false);
		//alert('activated..');
	}
	$(document)
			.ready(
					function() {
						//alert('loading step 1');
						var navListItems = $('ul.setup-panel li a'), allWells = $('.setup-content');

						allWells.hide();

						navListItems.click(function(e) {
							e.preventDefault();
							var $target = $($(this).attr('href')), $item = $(
									this).closest('li');

							if (!$item.hasClass('disabled')) {
								navListItems.closest('li')
										.removeClass('active');
								$item.addClass('active');
								allWells.hide();
								$target.show();
							}
						});

						$('ul.setup-panel li.active a').trigger('click');

					$('#modify').on('click',function(e) {
									alert('modifying..');
									$('ul.setup-panel li:eq(2)').removeClass('disabled');
									$('ul.setup-panel li a[href="#step-1"]').trigger('click');
									$('#btn-search').attr('disabled', false);
									alert('activated..');
									});
					
					$('#btn-search1')
						.on(
								'click',
								function(e) {
									
									alert($('#serviceid_display').val());
									alert($('#cityid_display').val());
									alert($('#localityid_display').val());
									alert($('#pkg_display').val());
									alert($('#car_display').val());
									alert($('#date_display').val());
					});
					
					$('#btn-search')
								.on(
										'click',
										function(e) {
											//alert('searching..');
											/* $('ul.setup-panel li:eq(1)').removeClass('disabled');
											$('ul.setup-panel li a[href="#step-2"]').trigger('click');
											$(this).remove(); */
									
											var cityId = $("#param1 option:selected").val();
											var service = $('#type option:selected').val();
											var locality = $('#param2 option:selected').val();
											var date = $('#param5').val();
											var vehicle = $('#param3 option:selected').val();
											var pkg = $('#param4 option:selected').val();
											
											// populate in modify fields
											$('#serviceid_display').val(service);
											$('#cityid_display').val(cityId);
											$('#localityid_display').val(locality);
											$('#pkg_display').val(pkg);
											$('#car_display').val(vehicle);
											$('#date_display').val(date);
											
											// validations
											if(locality == 'xxxx'){
												//alert('Please select a locality');
												$('#searchalert').html("");
												$('#searchalert').append("Please select a locality !");
												$('#searchalert').css('display', 'block');
												return;
											} else{
												$('#searchalert').html("");
												$('#searchalert').css('display', 'none');
											}
													
											//alert(JSON.stringify($('#form_search').serializeObject()));
											//alert($('#form_search').attr('action'));
											console.log(JSON.stringify($('#form_search').serializeObject()));
											$('#shadow').addClass('blocker');  
											$.ajax({
														type : "POST",
														url : $('#form_search').attr('action'),
														data : JSON.stringify($('#form_search').serializeObject()),
														contentType : 'application/json',
														dataType : "text",
														success : proceed_toStep2,
														error : function(xhr) {
															if($('#shadow').hasClass('blocker'))
															       $('#shadow').removeClass('blocker');  
															alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
																	+ xhr.status);
														}
													});
											//alert('activate step2');
											$('ul.setup-panel li:eq(1)')
													.removeClass('disabled');
											$('ul.setup-panel li a[href="#step-2"]')
													.trigger('click');
											$('#btn-search').attr('disabled', true);
											//$(this).remove();
										});

						function proceed_toStep2(response) {
							//alert(response); // for debug	
							//alert(jQuery.parseJSON(response));		
							if($('#shadow').hasClass('blocker'))
								$('#shadow').removeClass('blocker');  
							console.log(jQuery.parseJSON(response));
							var finalData = jQuery.parseJSON(response);	
							var cityId = $("#param1 option:selected").val();
							var service = $('#type option:selected').val();
							var locality = $('#param2 option:selected').val();
							var date = $('#param5').val();
							var vehicle = $('#param3 option:selected').val();
							var pkg = $('#param4 option:selected').val();
							alert(vehicle); 
							
							//$("#search_results").append("<p  class='bg-info pull-right'><div class='col-md-12 pull-right'><strong><span class='label label-warning'>"+service+"</span></strong>&nbsp;&nbsp;&nbsp;<strong><span class='label label-warning'>"+cityId+"</span></strong>&nbsp;&nbsp;&nbsp;<h3><span class='label label-warning'>"+date+"</span>&nbsp;&nbsp;&nbsp;<span class='label label-warning'>"+locality+"</span>&nbsp;&nbsp;&nbsp;<span class='label label-warning'>"+vehicle+"</span>&nbsp;&nbsp;&nbsp;<span class='label label-warning'>"+pkg+" hrs</span>&nbsp;&nbsp;&nbsp;<a href='#' class='btn btn-info pull-right' id='modify'>&nbsp;&nbsp;&nbsp;Modify Search&nbsp;&nbsp;&nbsp;</a></h3></div></p>"); 
							$("#search_results").append("<div class='col-md-12 pull-right' valign='top'><table border='0' align='center'><tr width='100%' align='center'><td><span  valign='top' class='btn btn-warning'>"+service+"</span>&nbsp;&nbsp;&nbsp;</td><td><span class='btn btn-warning'>"+cityId+"</span>&nbsp;&nbsp;&nbsp;</td><td><span class='btn btn-warning'>"+date+"</span>&nbsp;&nbsp;&nbsp;</td><td><span class='btn btn-warning'>"+locality+"</span>&nbsp;&nbsp;&nbsp;</td><td><span class='btn btn-warning'>"+vehicle+"</span>&nbsp;&nbsp;&nbsp;</td><td><span class='btn btn-warning'>"+pkg+" hrs</span>&nbsp;&nbsp;&nbsp;</td><td><a href='#' class='btn btn-info pull-justify' id='btn-search1' onClick='modifySearch()'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Modify Search&nbsp;&nbsp;&nbsp;</a></td></tr></table></div>");
							/* $("#search_results").append("<div class='col-md-2'><h4><span class='label label-warning'>"+cityId+"</span></h4></div>");
							$("#search_results").append("<div class='col-md-2'><h4><span class='label label-warning'>"+date+"</span></h4></div>");
							$("#search_results").append("<div class='col-md-2'><h4><span class='label label-warning'>"+locality+"</span></h4></div>");
							$("#search_results").append("<div class='col-md-2'><h4><span class='label label-warning'>"+vehicle+"</span></h4></div>");
							$("#search_results").append("<div class='col-md-2'><h4><span class='label label-warning'>"+pkg+" hrs</span></h4></div>"); 
							$("#search_results").append("<div class='col-md-2 pull-right'> <h4><a href='#' class='btn btn-primary' id='modify'>&nbsp;&nbsp;&nbsp;Modify Search&nbsp;&nbsp;&nbsp;</a></h4></div>");/* <input type='text' id='serviceid_display'  align='center' class='form-control' disabled='disabled' value='' /> */
 							$("#search_results").append("<br><strong><hr size='2' width='75%' color='green'></strong>");
							
							$('#search_results').append("<form id='searchform' class='form-horizontal' role='form'>");					
							$('#search_results').append("<ul id='search_results' class='thumbnails' style='list-style-type: none;'>");
							$.each(finalData,
									function(index, value) {	
											//alert(value);								
											console.log(value);
											
										

										/* <div class='col-md-2'>
											<input type='text' id='cityid_display' align='center' class='form-control' disabled='disabled' value='' />
										</div>
										<div class='col-md-2'>
											<input type='text'  id='localityid_display'  align='center' class='form-control' disabled='disabled' value='' />
										</div>
										<div class='col-md-2'>
											<input type='text'  id='date_display'  align='center' class='form-control' disabled='disabled' value='' />
										</div>
										<div class='col-md-2'>
											<input type='text'  id='car_display'  align='center' class='form-control' disabled='disabled' value='' />
										</div>
										<div class='col-md-2'>
											<input type='text'  id='pkg_display'  align='center' class='form-control' disabled='disabled' value='' />
										</div>
						 */		
				
				/*  */
											
											
											
											$("#search_results").append("<li class='span6' style='list-style-type: none;'>"
											+"<div class='col-sm-6 col-md-6'> <div class='thumbnail right-caption'>"
												+"<img class='span3' src='data:image/png;base64,"+value.pic+"' width='130' height='180' alt=''>"
												+"<div class='caption'>"
													+"<h4><a href='#aboutModal' data-toggle='modal' data-target='#myModal'>"+value.name+"</a></h4><p></p>"
													+"<p><small>"+value.locality+",</small></p>"
													+findExpr(value)+"  <p><small><b>Tariff : Rs "+value.tariff+"</b> </small></p>"
													+"<p><span class='label label-success'><small>Our Rating : "+value.rating+" &nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-star'></span> </small> </span></p>"
													+"<hr>"
													+"<p class='span4'>Some text to put it in his own words to explain his services. Or we can put it up.Or we can put it up.Or we can put it up.Or we can put it up.</p>"
													+"<p>"
														+"<button id='btn-selectme' type='button' value='"+value.provider+"_"+value.tariff+"' class='btn btn-primary pull-right'><i class='icon-hand-right'></i>Select & Proceed </button>"
													+"</p></div></div></div></li>"
															);
											$("#search_results").append("<div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'> <div class='modal-dialog'>             <div class='modal-content'>                 <div class='modal-header'>                     <button type='button' class='close' data-dismiss='modal' aria-hidden='true'></button>                     <h4 class='modal-title' id='myModalLabel'><small>More About : </small><span class='label label-warning'>"+value.name+"</span></h4>                     </div>                 <div class='modal-body'>                     <center>                     <img src='data:image/png;base64,"+value.pic+"' name='aboutme' width='120' height='140' border='0' class='img-circle'></a>                     <h3 class='media-heading'>"+value.name+" <small>, "+value.locality+"</small></h3>  <p><span class='label label-warning'><small>"+value.rating+" &nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-star'></span> </small> </span></p> </center>                     <hr>                     <center>                     <p class='text-left'><strong><span class='label label-info'>Bio: </span></strong><br>  <br>                       Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sem dui, tempor sit amet commodo a, vulputate vel tellus.</p>           <br>      <p class='text-left'><span class='label label-info'><strong>Some more interesting facts</strong></span></p>         <div class='tab-content'>                        <div id='information' class='tab-pane active'> <div class='span6'>  <table class='table table-condensed table-responsive table-user-information'><tbody> <tr> <td>Locality : </td><td>"+value.locality+"</td></tr>    <tr><td>Speaks :</td><td>"+value.badges.LANG+"</td></tr>       <tr> <td>Experience details :</td><td>"+findExpr(value)+"</td>                                     </tr>              </tbody>                                 </table>                             </div>                         </div>                                             </div>                     <br>                     </center>                 </div>                 <div class='modal-footer'>                     <center>                     <button type='button' class='btn btn-default' data-dismiss='modal'>I've heard enough about "+value.name+"</button>                     </center>                 </div>             </div>         </div>     </div> 	");
									});
							
							$('#search_results')
									.append("</form>");
							
							var cityId = $("#param1 option:selected").val();
							var service = $('#type option:selected').val();
							var locality = $('#param2 option:selected').val();
							var startDate = $('#param5').val();
							var pkg_code = $('#param4 option:selected').val();
							var model = $('#param3 option:selected').val();
							$("#service_id").val(service);
							$("#misc_city").val(cityId);
							$("#misc_loc").val(locality);
							$("#booking_startDate").val(startDate);
							$("#misc_model").val(model);
							$("#pkg_code").val(pkg_code);
							
						}
						
						function findExpr(value){
							var htmlString = "";							
							if(value.badges.EXPR == null || value.badges.EXPR == undefined){
								if(value.badges.EXP_PREMIUM == null || value.badges.EXP_PREMIUM == undefined){
									if(value.badges.EXP_SUPER_PREMIUM == null || value.badges.EXP_SUPER_PREMIUM == undefined){
										htmlString = "";
									}else{
										htmlString = "<p><small>Experience in Super Premium cars : <b>"+value.badges.EXP_SUPER_PREMIUM+"</b> , </small></p>";
									}
								}else{
									htmlString = "<p>Experience in Premium cars : <b>"+value.badges.EXP_PREMIUM+"</b> , </small></p>";
								}
							}else{
								htmlString = "<p>Experience : <b>"+value.badges.EXPR+"</b> , </small> </p>";
							}
							return htmlString;
						}
						

						// Move to step3
						$(document).on('click', '#btn-selectme', function () {
						//$('#btn-selectme').on('click',function(e) {
							var selectme = $('#btn-selectme').val();
							var arr = selectme.split('_');
							var provider = arr[0];
							var tariff = arr[1];
							$("#cost").val(tariff);	
							$("#misc_provider").val(provider);	
							
									//alert('activate step3');
									$('ul.setup-panel li:eq(2)').removeClass(
											'disabled');
									$('ul.setup-panel li a[href="#step-3"]')
											.trigger('click');
									$(this).remove();
								});

						
						$('#userid').blur(function(event){
							var userid = $('#userid').val();
							if(userid != "" && userid.length > 3){
									
								$('#userid_error').html("");
								$('#userid_error').css('display', 'none');
								
								$('#returningUser').attr('disabled', false);	
								$('#returningUser').focus();
							}else{
								$('#userid_error').html("Email address is mandatory.");	
								$('#userid_error').css('display', 'block'); 
							}
						
						});
						
						$('#pwd').blur(function(event){
							var userid = $('#pwd').val();
							var isReturningUser = $('#returningUser').val();
							//alert('pwd :'+userid);
							//alert('returning :'+isReturningUser);
							if(isReturningUser != "" && isReturningUser == "true" && userid != "" && userid.length > 3){
								//alert('erase');
								$('#pwd_error').html("");
								$('#pwd_error').css('display', 'none');
								
							}else{
								//alert('paint');
								$('#pwd_error').html("Password is mandatory.");	
								$('#pwd_error').css('display', 'block'); 
							}
						
						});
						
				
						// Move to step4
						$('#btn-login').on(
								'click',
								function(e) {
									var userid = $('#userid').val();
									var password = $('#pwd').val();
									var returningUser = $("#returningUser").val();
									//alert(userid+" : "+password+" : "+returningUser);
									var hasError = false;
									 var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
									if(userid == null || userid == undefined || userid == "" || !emailReg.test(userid)){
										hasError = true;
										$('#login-alert').html("");
										$('#login-alert').append("Please provide valid Email address");
									}
									
									if(returningUser != "" || returningUser == 'undefined' || returningUser != "false"){ 
										//alert("check pwd now");
										if(returningUser == "true"){
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
											}
									}
									
									if(hasError == true){
										$('#login-alert').append(" to proceed !!");
										$('#login-alert').css('display', 'block');
									}else {
									
										//alert("checking if i am returning user");
										if(returningUser == "true"){
											// make an ajax call
											console.log(JSON.stringify($('#signin').serializeObject()));
											console.log($('#signin').attr('action'));
											$('#shadow').addClass('blocker');  
											$.ajax({
												url : "/sahaay/bookings/auth/signin",
												type : "POST",
												data : JSON.stringify($('#signin').serializeObject()),
												contentType : 'application/json',
												dataType:"text",
												success : function(loggedIn) {
													if($('#shadow').hasClass('blocker'))
													       $('#shadow').removeClass('blocker');  
															// sign in went well..lets see the responses
															//var loggedIn = jQuery.parseJSON(resp);
															
															if(loggedIn == "Success"){
															
																	$('#customer_id').val(userid);
																	$("#misc_guestid").val("false");
																	
																	
																	var name = '<%= session.getAttribute("userName") %>';
																	var mobile = '<%= session.getAttribute("mobile") %>';
																	
																	console.log(name+'_'+mobile);
																	//alert(name);
																	//alert(mobile);
																	if(name != 'null' && mobile != 'null'){
																		$('#customer_name').val(name);
																		$('#contact_no').val(mobile);
																	}
																	
															
																	//alert('activate step4 for returning user!!');
																	$('ul.setup-panel li:eq(3)').removeClass(
																			'disabled');
																	$('ul.setup-panel li a[href="#step-4"]')
																			.trigger('click');
																	$(this).remove();
															}else {
																$('#login-alert').html("");
																$('#login-alert').append("Login Failed. Invalid username or password !!");
																$('#login-alert').css('display', 'block');
															}
												},
												error : function(jqXHR, textStatus, errorThrown) {
													if($('#shadow').hasClass('blocker'))
													       $('#shadow').removeClass('blocker');  
													alert('An error has occured!! :-('+jqXHR.status);
												}
											});
											return false;
									
										}else{	
											//alert('proceeding as a guest user !!!');	
											$('#customer_id').val(userid);									
											$("#misc_guestid").val("true");											
											
											//alert('activate step4 for guest user !!');
											$('ul.setup-panel li:eq(3)').removeClass(
													'disabled');
											$('ul.setup-panel li a[href="#step-4"]')
													.trigger('click');
											$(this).remove();
										}	
									}
									
								});
								
						// Complete the booking
						$('#btn-bookit').on(
								'click',
								function(e) {
									//alert('booking it !!');
									$('#cost').attr('disabled', false);
									
									// validations
									var number = $('#contact_no').val();
									var name = $('#customer_name').val();
									var pickup = $('#pickup').val();
									var out = $('#out').val();
									
									var hasError = false;
									var comma = ", ";
									
									$('#detailsalert').html("Please provide valid values for ");
									if(name == "" ){
										hasError = true;
										$('#detailsalert').append("Customer Name ");
										$('#customer_name').closest('.form-control').addClass('error');
									}
									if(number == "" ){
										if(hasError == false) comma = "";
										hasError = true;
										$('#detailsalert').append(comma+"Contact Number ");
									}else{
										// TODO number validation
									}
									if(pickup == "" ){
										if(hasError == false) comma = "";
										hasError = true;
										$('#detailsalert').append(comma+"Pickup ");
									}
									if(out == "" ){
										if(hasError == false) comma = "";
										hasError = true;
										$('#detailsalert').append(comma+"Out-of-Station ");
									}
									
									if(hasError == true){
										$('#detailsalert').append(" to proceed !!");
										$('#detailsalert').css('display', 'block');
									}
									
									if(hasError == false){
										///alert(JSON.stringify($('#details-form').serializeObject()));
										console.log(JSON.stringify($('#details-form').serializeObject()));
										console.log($('#details-form').attr('action'));
										$('#shadow').addClass('blocker');  
										$.ajax({
											url : $('#details-form').attr('action'),
											type : 'POST',
											data : JSON.stringify($('#details-form').serializeObject()),
											contentType : 'application/json',
											dataType : "text",
											success : function(resp) {
												if($('#shadow').hasClass('blocker'))
												       $('#shadow').removeClass('blocker'); 
												
												$('#confirm_modal').append("<p><strong> Thanks for Booking with Sahaay.com </strong></p>");
												$('#confirm_modal').append("<p> Your order number is  <strong>"+resp+"</strong> for further reference. </p><br>");
												$('#confirm_modal').append("<p>  If you have any questions regarding this booking, please feel free to contact us.<br /><strong>Toll Free number : </strong>1234-567-890 <strong> </br>Email us              :</strong> customer.service@sahaay.com </br>Yours sincerely,<br />Sahaay.com</p>");
												var options = {
													    "backdrop" : "static"
													}
												$('#success').modal(options);
												//window.location.href = "//";
											},
											error : function(jqXHR, textStatus, errorThrown) {
												if($('#shadow').hasClass('blocker'))
												       $('#shadow').removeClass('blocker');  
												$('#cost').attr('disabled', true);
												alert('An error has occured!! :-('+jqXHR.status);											
											}
										});
										return false;
									}
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
 						
						$("#type")
								.change(
										function(event) {
											//alert('service selected/changed !');
											var svrId = $(
													"#type option:selected")
													.val();
											//alert(svrId);
											if (svrId == 'Driver') {
												//alert('add prefs for a '+ svrId);
												$('#pref1')
														.html(
																"<div class='form-group'><label for='param3' class='col-md-3 control-label'>I have</label><div class='col-md-9'><select class='form-control' id='param3' name='param3' disabled='disabled'></select></div></div>");
												$('#pref2')
														.html(
																"<div class='form-group'><label for='param4' class='col-md-3 control-label'>Service hours</label><div class='col-md-9'><select class='form-control' id='param4' name='param4' disabled='disabled'><option value='4'>Half day or 4 hrs</option><option value='8'>Full day or 8 hrs</option></select></div></div>");
												$('#pref3')
														.html(
																"<div class='form-group'><label for='param2' class='col-md-3 control-label'>Pref pickup @</label><div class='col-md-9'><select class='form-control' id='param2' name='param2' disabled='disabled'></select></div></div>");
												$('#shadow').addClass('blocker');  
												$.ajax({
													type : "GET",
													url : "/sahaay/metadata/models",
													cache : false,
													dataType : "text",
													success : populate_models,
													error : function(xhr) {
														if($('#shadow').hasClass('blocker'))
														       $('#shadow').removeClass('blocker'); 
														alert("AJAX request failed: "
																+ xhr.status);
													}
												});
												
												
												$('#param1').attr('disabled', false);
											} else if (svrId == 'xxxx') {
												//alert('clear prefs');
												$('#pref1').html("");
												$('#pref2').html("");
												$('#pref3').html("");
												$('#param1').attr('disabled', true);
												
											}
										});

						
						function populate_models(response) {
							//alert(response); 
							var finalData = jQuery.parseJSON(response);
							if($('#shadow').hasClass('blocker'))
							       $('#shadow').removeClass('blocker'); 
							$('#param3')
									.html(
											'<option value="xxxx">Select a model</option>');
							$.each(finalData, function(index, value) {
								$("#param3").append(
										'<option value="'+value+'">' + value
												+ '</option>');
								
							});
							
							var date = $('#param5').val();
							var city = $('#param1 option:selected').val();
							
							if(date != "" && city != "xxxx"){								
								$('#param2').attr('disabled', false);
								$('#param3').attr('disabled', false);
								$('#param4').attr('disabled', false);
							
								$('#param1').trigger("change");
							}
							
						}
						
						$("#param1").change(
								function(event) {
									//alert('location selected/changed !');
									var svrId = $("#type option:selected").val();
									if(svrId == undefined || svrId == 'xxxx'){
										$('#error_alert').html("Please select Service !");
									}
									
									var cityId = $("#param1 option:selected")
											.val();
									//alert("BaS/sahaay/metadata/"+cityId+"/localities");
									if (cityId == 'xxxx') {
										//alert('clear locality list');
										$('#param2').html("");
										$('#param5').attr('disabled', true);
										$('#param2').attr('disabled', true);
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

								});

						function process_localities(response) {
							//alert(response); // for debug
							if($('#shadow').hasClass('blocker'))
								$('#shadow').removeClass('blocker'); 
							var finalData = jQuery.parseJSON(response);
							var rows = 0;
							$('#param2')
									.html(
											'<option value="xxxx">Select a Locality</option>');
							$.each(finalData, function(index, value) {
								$("#param2").append(
										'<option value="'+value+'">' + value
												+ '</option>');
								rows = rows+1;
							});
							
							if(rows < 1){
								$('#param2').html("");
								//alert('Opps !! we are yet to expand to this city !!')
							}else {
								$('#param5').attr('disabled', false);
								var date = $('param5').val();
								if(date != "" || date != 'undefined')
									$('#param2').attr('disabled', false);
								else
									$('#param2').attr('disabled', true);
							}
						}

						$('#date_picker').on('click', function() {
							$('#param5').appendDtpicker({
								//"inline" : false,
								"closeOnSelected" : true,
								"futureOnly" : true,
								"dateFormat" : "DD/MM/YYYY hh:mm"
							});
							$('#param2').attr('disabled', false);
							$('#param3').attr('disabled', false);
							$('#param4').attr('disabled', false);
							$('#btn-search').attr('disabled', false);
							
							
						});
						
						$("#param2").change(
										function(event) {
								//alert('locality changed !!');
								var localityId = $("#param2 option:selected").val();
								//alert(localityId);
								if(localityId != 'xxxx'){
									//alert('this should enable button');
									$('#btn-search').attr('disabled', false);
								}
						});
						
						$('#returningUser').on('click', function() {
							if(this.checked){
								//alert('i am a returning user');
								$('#returningUser').val("true");
								$('#pwd_field').html(" <span class='input-group-addon'>Password </span><input id='pwd' type='password' class='form-control' name='pwd' placeholder='password' ><span id='pwd_error' style='display: none' class='alert alert-danger'></span>");
								//$('#btn-login').attr('disabled',false);
							}else{
								$('#returningUser').val("false");
								$('#pwd_field').html("");
								$('#login-alert').html("");
								$('#login-alert').css('display', 'block');
								//$('#btn-login').attr('disabled',true);
							}
						});
						
						$('#signin').validate({
				              rules: {
				                userid: {
				                  required: true,
				                  email: true
				                }
				                
				              },
				              highlight: function(element) {
				                $(element).closest('.form-control').addClass('error');
				              },
				              success: function(element) {
				                element
				                .text('OK!').addClass('valid')
				                .closest('.form-control').addClass('success');
				              }
				         });
				         
				          /*  $('#signin').validate(
							  {
							    rules: {
							      name: {
							        minlength: 2,
							        required: true
							      },
							      city: {
							        minlength: 2,
							        required: true
							      },
							      state: {
							        minlength: 2,
							        required: true
							      },
							      userid: {
							        required: true,
							        email: true
							      }
							    }
							  }); */
							  
							  
							  jQuery.validator.setDefaults({
								    errorPlacement: function(error, element) {
								      // if the input has a prepend or append element, put the validation msg after the parent div
								      if(element.parent().hasClass('input-prepend') || element.parent().hasClass('input-append')) {
								        error.insertAfter(element.parent());		
								      // else just place the validation message immediatly after the input
								      } else {
								        error.insertAfter(element);
								      }
								    },
								    errorElement: "small", // contain the error msg in a small tag
								    wrapper: "div", // wrap the error message and small tag in a div
								    highlight: function(element) {
								      $(element).closest('.input-group').addClass('error'); // add the Bootstrap error class to the control group
								    },
								    success: function(element) {
								      $(element).closest('.input-group').removeClass('error'); // remove the Boostrap error class from the control group
								    }
								  });
						/* $('#btn-login').on('click', function() {
							alert('i logged in');
							var userid = $('#userid').val();
							var password = $('#pwd').val();
							var returningUser = $("#returningUser").val();
							alert(userid+" : "+password+" : "+returningUser);
							
							if(userid == null || userid == undefined){
								$('#login-alert').append("Please provide email address to proceed !");
							}
							
						}); */

					$('#customer_name').blur(
										function(event) {
										//alert('customer name');
						var name = $('#customer_name').val();
						if(name != "" && name.length > 2 && !$.isNumeric(name)){
							$('#contact_name_error').html("");
							$('#contact_name_error').css('display', 'none');
							
							$('#contact_no').focus();
						}else{
							$('#contact_name_error').html("Contact Name must be atleast 3 characters and no numbers. !");
							$('#contact_name_error').css('display', 'block');
						}					
					
					});
					
					$('#contact_no').blur(
										function(event) {
										//alert('customer no');
						var name = $('#contact_no').val();
						var mobileReg = /^0[0-9]*$/;
						
						if(mobileReg.test(name)){ 
							//alert('starts with a zero');
							$('#contact_no_error').html("");
							$('#contact_no_error').html("Please provide a valid contact number. It must not start with a zero.");
							$('#contact_no_error').css('display', 'block');	
						}else {
							$('#contact_no_error').html("");
							$('#contact_no_error').css('display', 'none');
						
							if(name != ""  && name.length == 10 && $.isNumeric(name)){
								$('#contact_no_error').html("");
								$('#contact_no_error').css('display', 'none');
								
								$('#pickup').focus();
							}else{
								$('#contact_no_error').html("Contact number must be numeric and not more than 10 digits.");
								$('#contact_no_error').css('display', 'block');
							}					
						}
					});
					
					$('#pickup').blur(
										function(event) {
						//alert('pickup');				
						var name = $('#pickup').val();
						if(name != "" && name.length > 3){
							$('#address_error').html("");
							$('#address_error').css('display', 'none');
							
							$('#out').focus();
						}else{
							$('#address_error').html("Pickup location is required and atleast 4 characters.");
							$('#address_error').css('display', 'block');
						}					
					
					});
					
					$('#out').on('click', function() {
						var out = $('#out').val();
						//alert(out);
						$('#other_prefs').focus();
						$('#btn-bookit').attr('disabled',false);
						if(out == "Yes"){
						}else if(out == "No"){
						
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
		$('#loginHandle').html("<a href='/sahaay/profileMgmt/loginRegister' class='subheading_link' style='text-decoration:none;color:#fff;'>Login/Register&nbsp;&nbsp;</a>");
	}
}
</script>

</head>
<body  onload="checkLogin()">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td style="background-image:url(${pageContext.request.contextPath}/images/top.jpg); background-repeat:repeat-x"><table align="center" border="0" cellpadding="0" cellspacing="0" width="1003">
      <tbody><tr>
        <td style="width: 646px;" class="menu_nav" height="40">
							<a href="/" class="menu_nav" style="text-decoration:none;color:#fff;">Home</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/howitworks" class="menu_nav" style="text-decoration:none;color:#fff;">How It Works </a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/services" class="menu_nav" style="text-decoration:none;color:#fff;">Services</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="/sahaay/views/aboutus" class="menu_nav" style="text-decoration:none;color:#fff;">About Us</a></td>
							<td style="width: 100px;" height="40" align='right'><a href="/sahaay/profileMgmt/loginRegister" class="subheading_link" style="text-decoration:none;color:#fff;">Login/Register&nbsp;&nbsp;</a></td>
							
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
<table width="100%" align="center" ><tr><td style="background-image:url(${pageContext.request.contextPath}/images/contact.jpg); ">

<div id="shadow"></div>
	<div class="container" style="margin-top: 20px;">
		<div class="row form-group">
			<div class="col-xs-12">
				<ul class="nav nav-pills nav-justified thumbnail setup-panel">
					<li class="active"><a href="#step-1">
							<h4 class="list-group-item-heading">Step 1</h4>
							<p class="list-group-item-text">What are you looking for</p>
					</a></li>
					<li class="disabled"><a href="#step-2">
							<h4 class="list-group-item-heading">Step 2</h4>
							<p class="list-group-item-text">Choose a provider</p>
					</a></li>
					<li class="disabled"><a href="#step-3">
							<h4 class="list-group-item-heading">Step 3</h4>
							<p class="list-group-item-text">Sign In or Register</p>
					</a></li>
					<li class="disabled"><a href="#step-4">
							<h4 class="list-group-item-heading">Step 4</h4>
							<p class="list-group-item-text">Proceed & Book</p>
					</a></li>
				</ul>
			</div>
		</div>
		<div class="row setup-content" id="step-1">
			<div class="col-xs-12">
				<div class="col-md-12 well text-center">
					<div id="signupbox" style="margin-top: 30px"
						class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
						<div class="panel panel-info">
							<div class="panel-heading">
								<div class="panel-title">Book A Service</div>
							</div>

							<div class="panel-body">
								<form id="form_search" class="form-horizontal" action="/sahaay/metadata/search">
									<div id="searchalert" style="display: none"
										class="alert alert-danger">
										<p>Error: </p>
										<span ></span>
									</div>
									<div class="form-group">
										<label for="type" class="col-md-3 control-label">I
											am looking for</label>
										<div class="col-md-9">
											<select class="form-control" id="type" name="type">
												<option value="xxxx">Choose a service</option>
												<option value="Driver">Driver</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="location" class="col-md-3 control-label">where
											?</label>
										<div class="col-md-9">
											<select class="form-control" id='param1' name='param1'
												placeholder="City/Location" disabled='disabled'>
												<option value="xxxx">which city do you need
													services</option>
												<option value="Hyderabad">Hyderabad</option>
												<option value="Bengaluru">Bangalore</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="date_time" class="col-md-3 control-label">when
											?</label>

										<div class="col-md-9">
											<div class='input-group date' id='date_picker'>
												<input type='text' class="form-control" id='param5' name='param5' disabled='disabled'/> <span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<div id="pref1"></div>
									<div id="pref2"></div>
									<div id="pref3"></div>
									<div class="form-group">
										
										<div class="col-md-offset-2 col-md-8">
											<button id="btn-search" type="button" class="btn btn-primary" disabled='disabled'>
												<i class="icon-hand-right"></i>Get me Providers
											</button>
											
										</div>
									</div>

								</form>
							</div>
						</div>

					</div>


				
			</div>
		</div>
	</div>
					<div class="row setup-content" id="step-2">
						<div class="col-xs-12">
							<div id='search_results' class="col-md-12 well">
							<!-- <h4><a href='#aboutModal' data-toggle='modal' data-target='#modifySearch'>Modify Search</a></h4> 
													<div class='col-md-2'>
															<input type='text' id='serviceid_display'  align='center' class='form-control' disabled='disabled' value='' />
														</div>
														<div class='col-md-2'>
															<input type='text' id='cityid_display' align='center' class='form-control' disabled='disabled' value='' />
														</div>
														<div class='col-md-2'>
															<input type='text'  id='localityid_display'  align='center' class='form-control' disabled='disabled' value='' />
														</div>
														<div class='col-md-2'>
															<input type='text'  id='date_display'  align='center' class='form-control' disabled='disabled' value='' />
														</div>
														<div class='col-md-2'>
															<input type='text'  id='car_display'  align='center' class='form-control' disabled='disabled' value='' />
														</div>
														<div class='col-md-2'>
															<input type='text'  id='pkg_display'  align='center' class='form-control' disabled='disabled' value='' />
														</div>
										<div class='col-md-2 pull-right'>			
								
								 <h4><a href='#' class='btn btn-primary' id='modify'>&nbsp;&nbsp;&nbsp;Modify Search&nbsp;&nbsp;&nbsp;</a></h4></div>-->
								

							</div>
						</div>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
					</div>
					<div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content modal-content-bg">
                <div class="modal-header modal-header-success">
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                    <!-- <i class="glyphicon glyphicon-thumbs-up"> --></i> <h3>Sahaay.com</h3>
                </div>
                <div class="modal-body" id="confirm_modal">
                	    	
                </div>
                <div class="modal-footer">
                    <a id="btn-success-modal" href="/" class="btn btn-success">Take me to HomePage</a> 
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    
    <div class="modal fade" id="modifySearch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content modal-content-bg">
                <div class="modal-header modal-header-success">
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                    <h3><i class="glyphicon glyphicon-thumbs-up"></i> <h3>Modify Search</h3>
                </div>
                <div class="modal-body" id="confirm_modal">
                	
												<div class='row'>
													<div class='col-md-12'>
														<div class='col-md-2'>
															<input type='text' class='form-control' value='Driver' />
														</div>
														<div class='col-md-2'>
															<input type='text' class='form-control' value='Hyderabad' />
														</div>
														<div class='col-md-2'>
															<input type='text' class='form-control' value='Driver' />
														</div>
														<div class='col-md-2'>
															<input type='text' class='form-control' value='Hyderabad' />
														</div>
														<div class='col-md-2'>
															<input type='text' class='form-control' value='Driver' />
														</div>
														<div class='col-md-2'>
															<input type='text' class='form-control' value='Hyderabad' />
														</div>
													</div>

										</div>    	
                </div>
                <div class="modal-footer">
                    <a id="btn-search1" href="#" class="btn btn-success">Search</a> 
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    
	<div class="row setup-content" id="step-3">
			<div class="col-xs-12">
				<div class="col-md-12 well">
					<div id="signupbox" style="margin-top: 30px"
						class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
						<div class="panel panel-info">
							<div class="panel-heading">
								<div class="panel-title">Sign In , and wrap it up !!</div>
							</div>

							<div class="panel-body">
								<form id="signin" name="signin" class="form-horizontal" action="sahaay/bookings/auth/signin">
									<div id="login-alert" style="display: none"
										class="alert alert-danger">
										<span ></span>
									</div>
									<div style="margin-bottom: 25px" class="input-group" >
										 <span class="input-group-addon">Email Id &nbsp;&nbsp;</span>
										 <input type="text" class="form-control" name="userid" id="userid" placeholder="email address" > 
										 <span id='userid_error' style="display: none" class="alert alert-danger"></span>
                                    </div>
                                    
									<div class="input-group" style="margin-bottom: 25px" >
										<div class="checkbox">
                                        <label>
                                          &nbsp;&nbsp;<input id="returningUser" type="checkbox" value=""> I am returning customer
                                        </label>
                                      </div>
									</div>
									
										<div style="margin-bottom: 25px" class="input-group" id="pwd_field">
										</div>
									
									
									<div class="form-group">
										<div class="col-md-offset-2 col-md-8">
											<button id="btn-login" type="button" class="btn btn-info pull-right" >
												<i class="icon-hand-right"></i>Lets finish it up
											</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div> <br><br>
				</div>
			</div>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</div>
	<div class="row setup-content" id="step-4">
		<div class="col-xs-12">
			<div class="col-md-12 well">				
				<div class="container">
				<div class="row">
					<div class="span6">
						<div class="panel-body">
							<form id="details-form" class="form-horizontal" action="/sahaay/bookings/requestABooking" method="post">
								<div id="detailsalert" style="display: none"
									class="alert alert-danger">
									<span></span>
								</div>
								<div class="form-group">
									<label for="customer_id" class="col-md-4 control-label">Contact
										Name &nbsp;&nbsp;&nbsp;<span style="color : red;">*</span></label>
									<div class="col-md-4">
										<input type='text' class="form-control error" id="customer_name" name="misc[info8]"/>
										<span id='contact_name_error' style="display: none" class="alert alert-danger"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="contact_no" class="col-md-4 control-label">
										Contact Number&nbsp;&nbsp;&nbsp;<span style="color : red;">*</span></label>
									<div class="col-md-4">
										<input type='text' class="form-control" id="contact_no" name="contact_no" />
										<span id='contact_no_error' style="display: none" class="alert alert-danger"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="misc[info3]" class="col-md-4 control-label">Pick
										up at&nbsp;&nbsp;&nbsp;<span style="color : red;">*</span></label>
									<div class="col-md-4">
										<textarea class="form-control" id="pickup" name="misc[info3]" rows="5" placeholder="Address"></textarea>
										<span id='address_error' style="display: none" class="alert alert-danger"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="package" class="col-md-4 control-label">Going
										out of station&nbsp;&nbsp;&nbsp;<span style="color : red;">*</span></label>
									<div class="col-md-4">
										<!-- <div id="misc[info1]" class="btn-group" data-toggle="buttons-radio">
											<a href="#Yes" class="btn btn-large btn-info"
												data-toggle="tab">Yes</a> <a href="#No"
												class="btn btn-large btn-info active" data-toggle="tab">No</a> -->
											<input type="radio"  id="out" name="misc[info1]" value="Yes"/> Yes
											<input type="radio"  id="out" name="misc[info1]" value="No" selected/> No
											<span id='out_error' style="display: none" class="alert alert-danger"></span>
										<!-- </div> -->
									</div>
								</div>
								
								<div class="form-group">
									<label for="cost" class="col-md-4 control-label">Tariff</label>
									<div class="col-md-4">
										<input type='text' class="form-control" id="cost" name="cost" disabled="disabled" />
									</div>
								</div>
								
								<div class="form-group">
									<label for="misc[info4]" class="col-md-4 control-label">Other Preferences I have</label>
									<div class="col-md-4">
										<input type='text' class="form-control" id="other_prefs" name="misc[info4]" />
									</div>
								</div>
								
									<div class="form-group">
										<input name="booking_status_code" id="booking_status_code" value="REQUESTED" type="hidden" />
										<input name="service_id" id="service_id" value="" type="hidden" />
										<input name="booking_startDate" id="booking_startDate" value="" type="hidden" />
										<input name="misc[info0]" id="misc_city" value="" type="hidden" />
										<input name="misc[info2]" id="misc_model" value="" type="hidden" />
										<input name="misc[info5]" id="misc_provider" value="" type="hidden" />
										<input name="misc[info6]" id="misc_loc" value="" type="hidden" />
										<input name="misc[info7]" id="misc_guestid" value="" type="hidden" />
										<input name="pkg_code" id="pkg_code" value="" type="hidden" />
										<input name="customer_id" id="customer_id" value="" type="hidden" />
										<!-- <hr> -->
									</div>

								<div class="form-group">
									<!-- Button -->
									<div class="col-md-offset-5 col-md-4">
										<button id="btn-bookit" type="button" class="btn btn-info" >
											<i class="icon-hand-right"></i>Book It For Me !
										</button>
										<!-- <span style="margin-left:8px;">or</span>   -->
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
	<br/>
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