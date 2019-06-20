

$(document).ready(function(){
  // Partial Functions
  function closeMain() {
	  
    $(".app").css("display","none");
	
  }
  
  function openMain() { //hide parts of ui etc
  
    $(".app").css("display","block");
	
  }
  
  function closeAll() {
	  
    $(".app").css("display","none");
	
  }
  
  function emptyEditor(){
	  
	$("textarea").val("");
	
  }
  
  function postApplication() {
	
	var _name = $.trim($(".name").val());	
	var _pres = $.trim($(".pres").val());
	var _phone = $.trim($(".phone").val());
	var _licenses = $.trim($(".licenses").val());
	var _moti = $.trim($(".moti").val());
	var _exp = $.trim($(".exp").val());
	
	var _type = "";
	
	if($("#police").is(":checked")) {
		
		_type = "police";
		
	} else if ($("#ambulance").is(":checked")) {
		
		_type = "ambulance";
		
  } else if ($("#unicorn").is(":checked")) {
		
		_type = "unicorn";
		
  } else if ($("#cardealer").is(":checked")) {
		
		_type = "cardealer";
		
  } else if ($("#mechanic").is(":checked")) {
		
		_type = "mechanic";
		
  } else if ($("#realestate").is(":checked")) {
		
		_type = "realestate";
		
  } else if ($("#taxi").is(":checked")) {
		
		_type = "taxi";
		
  } else if ($("#bus").is(":checked")) {
		
		_type = "bus";

  } else if ($("#armurier").is(":checked")) {
		
		_type = "armurier";		
		
  } else if ($("#bahama").is(":checked")) {
		
		_type = "bahama";		
		
  } else if ($("#bank").is(":checked")) {
		
		_type = "bank";	
		
  } else if ($("#casino").is(":checked")) {
		
		_type = "casino";	
		
  } else if ($("#epi").is(":checked")) {
		
		_type = "epi";	

  } else if ($("#avocat").is(":checked")) {
		
		_type = "avocat";	

  } else if ($("#prison").is(":checked")) {
		
		_type = "prison";	

  } else if ($("#oasis").is(":checked")) {
		
		_type = "oasis";

  } else if ($("#tabac").is(":checked")) {
		
		_type = "tabac";	

  } else if ($("#vigne").is(":checked")) {
		
		_type = "vigne";			
	}
	
	$.post('http://esx_joblisting2/postApplication', JSON.stringify({name : _name, pres : _pres, phone : _phone, licenses : _licenses, moti : _moti, exp : _exp, type : _type}));
	emptyEditor();
	$.post('http://esx_joblisting2/closeMenu', JSON.stringify({}));
	
  }
  
  // Listen for NUI Events
  window.addEventListener('message', function(event){

	var item = event.data;

    if(item.openMenu == true) {
      
	  openMain();
	  
    }
    
	if(item.openMenu == false) {
	  
      closeMain();
	  
    }


  });
  // On 'Esc' call close method
  document.onkeyup = function (data) {
   
   if (data.which == 27 ) {
      
	  closeMain();
	  $.post('http://esx_joblisting2/closeMenu', JSON.stringify({}));
	  
	}
  };
  
   $(".btnClose").click(function(){
    
		$.post('http://esx_joblisting2/closeMenu', JSON.stringify({}));
    
	});
	
	$(".btnSend").click(function(){
		postApplication();
	});
	

});
 