function addGaps(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
  }
  return x1 + x2;
}

function addCommas(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + ',<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
  }
  return x1 + x2;
}

$(document).ready(function(){
  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var cursor = $('#cursor');
  var cursorX = documentWidth / 2;
  var cursorY = documentHeight / 2;

  function UpdateCursorPos() {
      $('#cursor').css('left', cursorX);
      $('#cursor').css('top', cursorY);
  }

  function triggerClick(x, y) {
      var element = $(document.elementFromPoint(x, y));
      element.focus().click();
      return true;
  }

  // Partial Functions
  function closeMain() {
    $(".home").css("display", "none");
  }
  function openMain() {
    $(".home").css("display", "block");
  }
  function closeAll() {
    $(".body").css("display", "none");
  }
  function openImpotMenu() {
    $(".impot-container").css("display", "block");
  }
  function openEntMenu() {
    $(".ent-container").css("display", "block");
  }
  function openbtnI1(list) {
	$("#btnI1-data").css("display", "none");    
	var listimpotre = list;
	let listimpot = '' 
	for (var i=1 in listimpotre) {
		listimpot = listimpot + '['+ listimpotre[i].id +'] '+ listimpotre[i].name +'   -   '+ listimpotre[i].montant +'% - type: '+ listimpotre[i].job +'</br>';
	} 
	document.getElementById('btnI1-data').innerHTML = listimpot;
    $(".btnI1-container").css("display", "block");
	$("#btnI1-data").css("display", "block");
  }
  function openbtnI2() {
    $(".btnI2-container").css("display", "block");
  }
  function openbtnI3() {
    $(".btnI3-container").css("display", "block");
  }
  function openbtnI4(list) {
    $("#btnI4-data").css("display", "none");    
	var listgen = list;
	let listimpot = ''
	var listnb = 0
	for (var i=1 in listgen) {
		listnb = Number(listnb) + Number(listgen[i].montant)
	} 
	listimpot = listimpot + ''+ Number(listnb) +' $'
	document.getElementById('btnI4-data').innerHTML = listimpot;
    $(".btnI4-container").css("display", "block");
	$("#btnI4-data").css("display", "block");
  }
  function openbtnE1(list) {
    $("#btnE1-data").css("display", "none");    
	var listentre = list;
	let listent = ''
	for (var i=1 in listentre) {
		listent = listent + ''+ listentre[i].job +' | Responsable :'+ listentre[i].responsable +'$</br>';
	} 
	document.getElementById('btnE1-data').innerHTML = listent;
    $(".btnE1-container").css("display", "block");
	$("#btnE1-data").css("display", "block");
  }
  function openbtnE3() {
    $(".btnE3-container").css("display", "block");
  }

  function openContainer() {
    $(".gouv-container").css("display", "block");
    $("#cursor").css("display", "block");
  }
  function closeContainer() {
    $(".gouv-container").css("display", "none");
    $("#cursor").css("display", "none");
  }
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;

    if (item.hideHUD == true) {
      $('.balance').css('opacity', 0.0);
    }

    if (item.hideHUD == false) {
      $('.balance').css('opacity', 1);
    }
    if(item.openGGestion == true) {
      openContainer();
      openMain();
    }
    if(item.openGGestion == false) {
      closeContainer();
      closeMain();
    }
	if(item.openSection == "openbtnI1") {
      closeAll();
      openbtnI1(item.list);
    }
	if(item.openSection == "openbtnI4") {
      closeAll();
      openbtnI4(item.list);
    }
	if(item.openSection == "openbtnE1") {
      closeAll();
      openbtnE1(item.list);
    }
    if(item.type == "click") {
        triggerClick(cursorX - 1, cursorY - 1);
    }
  });
  $(document).mousemove(function(event) {
    cursorX = event.pageX;
    cursorY = event.pageY;
    UpdateCursorPos();
  });
  // On 'Esc' call close method
  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      $.post('http://esx_gouvernor/close', JSON.stringify({}));
    }
  };
  // Handle Button Presses
  $(".btnClose").click(function(){
      $.post('http://esx_gouvernor/close', JSON.stringify({}));
  });
  $(".btnHome").click(function(){
      closeAll();
      openMain();
  });
  $(".btnImpot").click(function(){
      closeAll();
      openImpotMenu();
  });
  $(".btnEntreprise").click(function(){
      closeAll();
      openEntMenu();
  });
  $(".btnI1").click(function(){
      $.post('http://esx_gouvernor/btnI1', JSON.stringify({}));
  });
  $(".btnI2").click(function(){
      closeAll();
      openbtnI2();
  });
  $(".btnI3").click(function(){
      closeAll();
      openbtnI3();
  });
  $(".btnI4").click(function(){
      $.post('http://esx_gouvernor/btnI4', JSON.stringify({}));
  });
  $(".btnE1").click(function(){
      $.post('http://esx_gouvernor/btnE1', JSON.stringify({}));
  });
  $(".btnE3").click(function(){
      closeAll();
      openbtnE3();
  });
  // Handle Form Submits
  $("#btnI2-form").submit(function(e) {
      e.preventDefault();
      $.post('http://esx_gouvernor/btnI2result', JSON.stringify({
		  type: $("#btnI2-form #type").val(),
		  nom: $("#btnI2-form #nom").val(),
		  montant: $("#btnI2-form #montant").val()
      }));
	  $("#btnI2-form #type").prop('disabled', true)
      $("#btnI2-form #nom").prop('disabled', true)
	  $("#btnI2-form #montant").prop('disabled', true)
      $("#btnI2-form #submit").css('display', 'none')
      setTimeout(function(){
		$("#btnI2-form #type").prop('disabled', false)  
		$("#btnI2-form #nom").prop('disabled', false)
	    $("#btnI2-form #montant").prop('disabled', false)
        $("#btnI2-form #submit").css('display', 'block')
      }, 2000)
	  $("#btnI2-form #type").val('')
      $("#btnI2-form #nom").val('')
	  $("#btnI2-form #montant").val('')
  });
  $("#btnI3-form").submit(function(e) {
      e.preventDefault();
      $.post('http://esx_gouvernor/btnI3result', JSON.stringify({
		  id: $("#btnI3-form #idimp").val()
      }));
      $("#btnI3-form #idimp").prop('disabled', true)
      $("#btnI3-form #submit").css('display', 'none')
      setTimeout(function(){
		$("#btnI3-form #idimp").prop('disabled', false)
        $("#btnI3-form #submit").css('display', 'block')
      }, 2000)
      $("#btnI3-form #idimp").val('')
  });
  $("#btnE3-form").submit(function(e) {
      e.preventDefault();
      $.post('http://esx_gouvernor/btnE3result', JSON.stringify({
		  nom: $("#btnE3-form #nom").val()
      }));
      $("#btnE3-form #nom").prop('disabled', true)
      $("#btnE3-form #submit").css('display', 'none')
      setTimeout(function(){
		$("#btnE3-form #nom").prop('disabled', false)
        $("#btnE3-form #submit").css('display', 'block')
      }, 2000)
      $("#btnE3-form #nom").val('')
  });
});
