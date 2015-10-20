// ******** Date-time picker ********* -->
$(function() {
	$.datetimepicker.setLocale('es');

	$('.datetimepicker').datetimepicker({
		lazyint : true,
		format : 'd/m/Y H:i'

	});

	$('.date-picker').datetimepicker({
		lazyint : true,
		timepicker : false,
		//mask:true,
		format : 'd/m/Y',
		closeOnDateSelect : true,
		scrollInput : false
	});

	//Mask del datetimepicker
	$('.date-picker').mask('00/00/0000');
	$('.datetimepicker').mask('00/00/0000 00:00');
});
// ********Autocomplete (remoto JSON) ********* -->
$(function() {
	function log(message) {
		$("<div>").text(message).prependTo("#log");
		$("#log").scrollTop(0);
	}


	//$("#autocomplete").autocomplete({
	//	source : function(request, response) {
	//		$.ajax({
	//			url : "/thing_parts.json",
	//			dataType : "json",
	//			data : {
	//				term : request.term,
//
	//			},
	//			success : function(data) {
//
	//				dataMapped = $.map(data, function(item) {
	//					return {
	//						label : item.name,
	//						value : item.name,
	//						id : item.id
//
	//					};
//
	//				});
	//				response(dataMapped);
//
	//			}
	//		});
	//	},
	//	minLength : 1,
	//	select : function(event, ui) {
	//		log(ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
	//	},
	//	open : function() {
	//		$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
	//	},
	//	close : function() {
	//		$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
	//	}
	//});
});

//AUTOCOMPLETE DROPDOWN

$(function() {

	var temp = [{
		"id" : 6,
		"name" : "test3",
		"field1" : "test3"
	}, {
		"id" : 5,
		"name" : "test2",
		"field1" : "test2"
	}, {
		"id" : 4,
		"name" : "test1",
		"field1" : "fild1"
	}];

	var $select = $('#multiple-select');
	$select.find('option').remove();
	$.each(temp, function(key, value) {

		//$select.append('<option value=' + key + '>' + value + '</option>');
	});
});
//Mostrar / ocutar detalles en timeline
$(function() {

	$(".show-details").click(function(event) {
		event.preventDefault();
		var elem = $(this).closest("p").next(".detalles");

		$(elem).toggle("slow");

		if ($(this).text() == 'Mostrar detalles') {
			$(this).text('Ocultar detalles');
		} else {
			$(this).text('Mostrar detalles');
		}

	});
});

// TOUR
$(function() {
	// Check width size - Hide for small screens
	function checkWidth() {
		var windowsize = $(window).width();
		if (windowsize < 768) {
			$(".div-tour").hide();

		} else {
			$(".div-tour").show();
		}
	}

	// Execute on load
	checkWidth();
	// Bind event listener
	$(window).resize(checkWidth);

	if ($('[data-step]').length < 4) {
		var ultima = "Sig. Página";
		var multi = true;
	} else {
		var ultima = "Terminar";
		var multi = false;
	}

	if (RegExp('tour2', 'gi').test(window.location.search)) {

		var currentStep = $('[data-step]').length;

		introJs().setOptions({
			'exitOnOverlayClick' : 'true',
			'skipLabel' : 'Cancelar',
			'doneLabel' : ultima,
			'tooltipPosition' : 'auto',
			'positionPrecedence' : ['right', 'left', 'bottom', 'top'],
			'nextLabel' : 'Siguiente',
			'prevLabel' : 'Anterior'
		}).goToStep(currentStep).start().oncomplete(function() {
			checkTour();
		});
	}

	$("#start-tour").click(function(event) {
		event.preventDefault();
		introJs().setOptions({
			'exitOnOverlayClick' : 'true',
			'skipLabel' : 'Cancelar',
			'doneLabel' : ultima,
			'tooltipPosition' : 'auto',
			'positionPrecedence' : ['right', 'left', 'bottom', 'top'],
			'nextLabel' : 'Siguiente',
			'prevLabel' : 'Anterior'
		}).start().oncomplete(function() {
			checkTour();
		});
	});

	function checkTour() {
		if (multi == true) {
			window.location.href = '/welcome/prueba.html?tour2=true';
		} else {
			window.location.search = "";
		}
	}

});

// Tooltips
$(document).ready(function() {

	$('[data-toggle="tooltip"]').tooltip();
	$('a.tooltipwithnofollow[rel="tooltip nofollow"]').tooltip();

});

// ******** Menu Minified ?? ********* -->
$(function() {

	$(".minifyme").click(function() {

		if (Cookies.get('nav') != "min") {

			Cookies.set('nav', 'min', {
				path : '/'
			});
		} else if (Cookies.get('nav') == "min") {
			Cookies.set('nav', 'max', {
				path : '/'
			});
		}
	});

});
$(document).ready(function() {

	//Bootstrap Wizard Validations
	var $validator = $("#wizard-1").validate({

		rules : {
			email : {
				required : true,
				email : "Your email address must be in the format of name@domain.com"
			},
			fname : {
				required : true
			},
			lname : {
				required : true
			},
			country : {
				required : true
			},
			city : {
				required : true
			},
			postal : {
				required : true,
				minlength : 4
			},
			wphone : {
				required : true,
				minlength : 10
			},
			hphone : {
				required : true,
				minlength : 10
			}
		},

		messages : {
			fname : "Please specify your First name",
			lname : "Please specify your Last name",
			email : {
				required : "We need your email address to contact you",
				email : "Your email address must be in the format of name@domain.com"
			}
		},

		highlight : function(element) {
			$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		},
		unhighlight : function(element) {
			$(element).closest('.form-group').removeClass('has-error').addClass('has-success');
		},
		errorElement : 'span',
		errorClass : 'help-block',
		errorPlacement : function(error, element) {
			if (element.parent('.input-group').length) {
				error.insertAfter(element.parent());
			} else {
				error.insertAfter(element);
			}
		}
	});
});

$(document).ready(function() {
	$('#bootstrap-wizard-1').bootstrapWizard({
		'tabClass' : 'form-wizard',
		'onNext' : function(tab, navigation, index) {
			var $valid = $("#wizard-1").valid();
			if (!$valid) {
				$validator.focusInvalid();
				return false;
			} else {
				$('#bootstrap-wizard-1').find('.form-wizard').children('li').eq(index - 1).addClass('complete');
				$('#bootstrap-wizard-1').find('.form-wizard').children('li').eq(index - 1).find('.step').html('<i class="fa fa-check"></i>');
			}
		}
	});

	// fuelux wizard
	var wizard = $('.wizard').wizard();

	wizard.on('finished', function(e, data) {
		//$("#fuelux-wizard").submit();
		//console.log("submitted!");
		$.smallBox({
			title : "Congratulations! Your form was submitted",
			content : "<i class='fa fa-clock-o'></i> <i>1 seconds ago...</i>",
			color : "#5F895F",
			iconSmall : "fa fa-check bounce animated",
			timeout : 4000
		});

	});
});
// Filtros
$(function() {
	$("#filtrar").click(function(event) {
		$("#filter-zone").slideToggle("slow");
	});
});

// Login (remember-me)
$(function() {
	$("input[name='user[remember_me]']").val('1');

	//alert($("input[name='user[remember_me]']").val());

	$("input[name='remember']").change(function() {

		if ($("input[name='user[remember_me]']").val() == '0') {
			$("input[name='user[remember_me]']").val('1');
		} else {
			$("input[name='user[remember_me]']").val('0');
		}

		//alert($("input[name='user[remember_me]']").val());
	});

});


