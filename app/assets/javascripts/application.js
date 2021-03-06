// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).on('ready page:load', function () {

	/*
	var oNextFormInput = null;
	$("form.login input[type=password]:first").focus();
	$("form.login input[type=password]").not($("form.login input[type=password]:last")).keypress(function(){
		
		oNextFormInput = $(this).next();
		setTimeout(function() {
			$(oNextFormInput).focus().blur().focus();
		}, 20);

	});
	$("form.login input[type=password]:last").keypress(function(){

		setTimeout(function() {
			$("form.login #pin").val($("form.login #pinA").val() + $("form.login #pinB").val() + $("form.login #pinC").val() + $("form.login #pinD").val());
			$("form.login").submit();
		}, 50);

	});
	*/

	$("form.login input[type=password]").focus();

	$("form.login input[type=password]").keypress(function(){

		setTimeout(function() {
			console.log($("form.login input[type=password]").val().length)
			if($("form.login input[type=password]").val().length == 4){
				$("form.login").submit();
			}
		}, 50);

	});

}).on("page:change", function(){
	$("#main").removeClass("animated fadeInDown fadeOutUp").addClass("animated fadeInDown");
	NProgress.done();
}).on("page:fetch", function(){
	$("#main").removeClass("animated fadeInDown fadeOutUp").addClass("animated fadeOutUp");
	NProgress.start();
}).on('page:restore', function(){
	NProgress.remove();
});