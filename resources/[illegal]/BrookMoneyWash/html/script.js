$(function() {

  var active = false,
      booted = false,
      transactionInProgress = false,
      transactionComplete = false;

  var Boot = function(options) {
    booted = false;
    var content = $('.content').html("");
    
    typer(content[0])
      .cursor({block: true})
      .line("H:\\> ", { speed: 0 })
      .line("DARKSPIDER.EXE", { min: 50, max: 250 })
      .line([
        "<br>FORCE: XX0022. ENCYPT://000.222.2345<br>",
        "TRYPASS: ********* AUTH CODE: ALPHA GAMMA: 1___ PRIORITY 1<br>",
        "scanning ports...<br>",
        "BACKDOOR FOUND (23.45.23.12.00000000)<br>",
        "BACKDOOR FOUND (13.66.23.12.00110000)<br>",
        "BACKDOOR FOUND (13.66.23.12.00110044)<br>",
        "En attente d'une réponse",
      ])
      .line("...", {speed: 400})    
      .line([
        "<br><br>write_block1:<br>",
        "	stc<br>",
        "	ret<br>",
        "write_block endp<br>",
        "init_buffs proc near<br>",
        "	call	read_block<br>",
        "	xor	ax,ax<br>",
        "	mov	output_ptr,ax<br>",
        "	ret<br>",
        "init_buffs endp<br>",
        "flush_buffs proc near<br>",
        "	mov	cx,output_ptr<br>",
        "	or	cx,cx<br>",
        "	jz	flush_buffs1<br>",
        "	mov	bx,output_handle<br>",
        "	mov	dx,offset output_buffer<br>",
        "	mov	ah,40h<br>",
        "	int	21h<br>",
        "	cmp	ax,output_ptr<br>",
        "	jnz	flush_buffs2<br>",
        "flush_buffs1: <br>",
        "	clc<br>",
        "	ret<br>",
        "flush_buffs2:<br>",
        "	stc<br>",
        "	ret<br>",
        "flush_buffs endp<br>",
        "sign_on proc	near<br>",
        "	mov	dx,offset msg6<br>",
        "	mov	ah,9<br>",
        "	int	21h<br>",
        "	mov	dx,offset msg7<br>",
        "	mov	ah,9<br>",
        "	int	21h<br>",
        "	mov	dx,offset input_name<br>",
        "	call	pasciiz<br>",
        "	mov	dx,offset msg8<br>",
        "	mov	ah,9<br>",
        "	int	21h<br>",
        "	mov	dx,offset output_name<br>",
        "	call	pasciiz<br>",
        "	mov	dx,offset msg9<br>",
        "	mov	ah,9<br>",
        "	int	21h<br>",
        "	ret<br>",
        "sign_on	endp<br><br>"
      ], {speed: 20})

      .line([
        "...locating vulnerabilities...<br>",
        "...vulnerabilities found...<br>",
        "MCP/> DEPLOY CLU<br>",
        "SCAN: __ 0100.0000.0554.0080<br>",
        "SCAN: __ 0020.0000.0553.0080<br>",
        "SCAN: __ 0001.0000.0554.0550<br>",
        "SCAN: __ 0012.0000.0553.0030<br>",
        "SCAN: __ 0100.0000.0554.0080<br>",
        "SCAN: __ 0020.0000.0553.0080<br>",
        "Connected!"
      ], {speed: 200})

      .end(function() {

        content.html("");
        typer(content[0])
          .cursor({block: true})
          .line([
            '  \/ _ \\<br>',
            '\\_\\(_)\/_\/<br>',
            ' _\/\/\"\\\\_<br>',
            '  \/   \\<br><br>',
            "Vous êtes désormais dans le système","contact with Dark Spider. ","We can wash your ","dirty money for a ","reasonable price. Beware that ","any interruptions during the ","wash process will CANCEL ","the wash and DESTROY ","chunks of your black money.<br><br>",
          ])
          .line(options.amount > 25000 ? ["You have $"+options.amount+" dirty ","money that will be ","exchanged into $"+Math.floor(options.amount*(1-options.fee))+" cash. ETA ",Math.floor(options.timer/1000)+" seconds.<br><br>", "Press <em>ENTER</em> if you want to continue"] : ["You only have $"+config.amount+" dirty money. You need at least $25000 to make a transaction.<br><br>", "Press <em>ENTER</em> to exit"])
          .end(function() {
            booted = true;
          })

      })

  };

  var Confirm = function(options) {
    var content = $('.content').html("");
    transactionInProgress = true;
    typer(content[0])
      .cursor({block: true})
      .line([
        '  \/ _ \\<br>',
        '\\_\\(_)\/_\/<br>',
        ' _\/\/\"\\\\_<br>',
        '  \/   \\<br><br>',
        'Transaction en cours...<br>'
      ])
      .line([
        "5%<br>",
        "10%<br>",
        "15%<br>",
        "20%<br>",
        "25%<br>",
        "30%<br>",
        "35%<br>",
        "40%<br>",
        "45%<br>",
        "50%<br>",
        "55%<br>",
        "60%<br>",
        "65%<br>",
        "70%<br>",
        "75%<br>",
        "80%<br>",
        "85%<br>",
        "90%<br>",
        "95%<br>",
        "Transaction complete. Appuie sur <em>ENTER</em> pour quitter"
      ], { speed: options.timer/20 }).end()
  };

  var config = {}

  window.addEventListener('message', function(event) {
    let data = event.data;
    if (data.show) {
      transactionInProgress = false;
      $('.fullscreen').show();
      active = true;
      config = {
        amount: data.amount,
        fee: data.fee,
        timer: data.timer
      };
      Boot(config);
    } else if (data.hide) {
      $('.fullscreen').hide();
      active = false;
      const kill = new Event('killTyper');
      document.body.dispatchEvent(kill);
    } else if (data.endTransaction) {
      transactionInProgress = false;
      config.amount = 0;
    }
  });

  document.onkeyup = function(data) {
    if (data.which == 13 && booted && !transactionInProgress) {
      if (config.amount > 10000) {
        Confirm(config);
        $.post('http://esx_darkspider/transaction', '{}');
      } else {
        $.post('http://esx_darkspider/escape', '{}');
      }
    }
    if (data.which == 27) {
      $.post('http://esx_darkspider/escape', '{}');
    }
  };

  /*$('.fullscreen').css('display', 'block');
  Boot({
    amount: 1200499,
    fee: 0.3,
    timer: 20000
  });
  setTimeout(function() {
    Confirm({
      amount: 1200499,
      fee: 0.3,
      timer: 20000
    });
  }, 15000);*/
});



!function(e,n){"object"==typeof exports?module.exports=n():"function"==typeof define&&define.amd?define(function(){return n()}):e.typer=n()}(this,function(){"use strict";function e(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function n(n,r){function i(e){return{}.toString.call(e).slice(8,-1)}function o(e){var n=i(e);if("html"!==n.slice(0,4).toLowerCase()&&"String"!==n)throw"You need to provide a string selector, such as '.some-class', or an html element.";return n}function u(e){var n=i(e);if(void 0===e)return D.speedSet?r:70;if("Number"===n&&!isNaN(e))return e;if("Object"===n){var t=e.hasOwnProperty("min"),o=e.hasOwnProperty("max"),u=e.hasOwnProperty("speed");if(u&&!isNaN(e.speed))return e.speed;if(t&&o&&e.min<e.max)return e;if(!Object.keys(e).length&&D.speedSet)return r;if(!t&&!o&&!u)return r}throw Error("You have provided an invalid value for speed.")}function c(e,t){D.style&&D.style.remove(),D.newDiv&&a(),n.removeAttribute("data-typer"),A.removeEventListener("killTyper",L),D.newDiv&&D.newDiv.classList.add("white-space"),D.newDiv="","function"==typeof e?e(n):"function"==typeof t&&t(n),!0!==e&&!0!==t||A.dispatchEvent(new Event("typerFinished"))}function a(){["typer","cursor-block","cursor-soft","cursor-hard","no-cursor"].forEach(function(e){D.newDiv.classList.remove(e)})}function l(e,n){return Math.floor(Math.random()*(n-e+1)+e)}function s(e,n){D.style=document.createElement("style"),D.style.appendChild(document.createTextNode("")),document.head.appendChild(D.style);var t=document.styleSheets[document.styleSheets.length-1];"insertRule"in t?t.insertRule(e+"{"+n+"}",0):t.addRule(e,n)}function d(n,t,r){function o(){var t,r=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},o=arguments[1],a=r.container,l=!o&&("String"===i(a)?document.querySelector(a).textContent:a.textContent);return t={},e(t,n,o||l),e(t,"speed",u(r)),e(t,"html",!1!==r.html),e(t,"element",c?r.element:null),t}var c="line"===n,a="continue"===n;if(t||r)if("Object"===i(t))(c||a&&t.container)&&D.push(o(t));else if(isNaN(r))D.push(o(r,t));else{var l;D.push((l={},e(l,n,t),e(l,"speed",u(r)),e(l,"html",!0),l))}else c&&D.push({line:1})}function f(){if(D.item>=0||(D.item=0),D.item===D.length)return A.removeEventListener("killTyper",L);D.ks||(D.ks=!0,A.addEventListener("killTyper",L)),D.cursor||(D.cursor="cursor-soft"),D.type=setInterval(function(){if(!D.length)return clearInterval(D.type);var e=D[D.item];e.line?v(e):e.continue?p(e):e.pause?y(e):e.emit?w(e):e.listen?g(e):e.back?N(e):e.empty?b():e.run?E(e):e.end&&k()},0)}function v(e){clearInterval(D.type),D.newDiv&&(a(),D.newDiv.classList.add("white-space"),D.newDiv.innerHTML||(D.newDiv.innerHTML=" "));var t=document.createElement(e.element||"div");if(t.setAttribute("data-typer-child",D.uuid),t.className=D.cursor,t.classList.add("typer"),t.classList.add("white-space"),n.appendChild(t),D.newDiv=t,1===e.line)return D.item++,f();m(e)}function p(e){clearInterval(D.type),m(e)}function h(e,n,t){var r="Object"===i(e)?l(e.min,e.max):e;D.iterator=setTimeout(function(){return n(t)},r)}function m(e){function n(e,t){var r=[];e=Array.from(e);for(var i=0;i<e.length;i++){var o=e[i],u=o.nodeName;"#text"===u?r.push({parent:t,content:o.textContent}):o.childNodes.length?function(){var e=document.createElement(u);Array.from(o.attributes).forEach(function(n){e.setAttribute(n.name,n.value)}),r.push({parent:t,newNode:e}),r=r.concat(n(o.childNodes,e))}():D.voids.includes(u)&&r.push({parent:t,voidNode:o})}return r}function t(){return clearInterval(D.iterator),D.item++,f()}var r=e.line||e.continue,o=document.createElement("div");if(Array.isArray(r))return function(n){function i(){var c=r[u++];o.textContent=c,D.newDiv.innerHTML+=n?c:o.innerHTML,u===r.length?t():h(e.speed,i)}var u=0;h(e.speed,i)}(e.html);o.innerHTML=r,e.html?function(){function r(){if(!a)return t();a.content?(a.parent.innerHTML+=a.content[c++],c===a.content.length&&(c=0,a=i[u++])):(a.parent.appendChild(a.voidNode||a.newNode),a=i[u++]),h(e.speed,r)}var i=n(o.childNodes,D.newDiv),u=0,c=0,a=i[u++];h(e.speed,r)}():function(){function n(){if(u===r.length)return t();var c=r[u];"String"!==i(r)&&(o.textContent=c,c=o.innerHTML),D.newDiv.innerHTML+=c,u++,h(e.speed,n)}var u=0;h(e.speed,n)}()}function y(e){clearInterval(D.type),D.pause=setTimeout(function(){D.item++,f()},e.pause)}function w(e){clearInterval(D.type),e.el.dispatchEvent(new Event(e.emit)),D.item++,f()}function g(e){function n(t){e.el.removeEventListener(t.type,n),D.killed||(D.item++,f())}clearInterval(D.type),e.el.addEventListener(e.listen,n),M={el:e.el,type:e.listen,fxn:n}}function N(e){function n(e){var n=0,r=t(e||D.newDiv).reverse();return function(){var t=r[0];D.voids.includes(t.nodeName)?(t.remove(),r.shift()):(t.textContent=t.textContent.slice(0,-1),t.length||r.shift()),e||++n===u&&(clearInterval(D.goBack),i(D.newDiv),D.item++,f())}}function t(e){var n=[],r=Array.from(e.childNodes);return r.length?(r.forEach(function(e){e.childNodes.length?n=n.concat(t(e)):n.push(e)}),n):n}function i(e){Array.from(e.childNodes).forEach(function(e){D.voids.includes(e.nodeName)||(e.childNodes.length&&i(e),"#text"===e.nodeName||e.innerHTML.length||e.remove(),"#text"!==e.nodeName||e.length||e.remove())})}function o(e){var n=0;return Array.from(e.childNodes).forEach(function(e){D.voids.includes(e.nodeName)&&n++,e.childNodes.length&&(n+=o(e))}),n}var u=e.back,c=e.speed;if(clearInterval(D.type),!D.newDiv||!D.newDiv.textContent)return D.item++,f();var a=o(D.newDiv),l=D.newDiv.textContent.length;if("empty"===u){if(!c||c>=l)D.newDiv.innerHTML="";else{var s=D.newDiv.cloneNode(!0),d=n(s);c<0&&(c+=l);for(var v=0;v<c;v++)d();i(s),D.newDiv.innerHTML=s.innerHTML}return D.item++,f()}u>l+a&&(u="all"),"all"===u&&(u=l+a),u<0&&(u=l+a- -1*u),D.goBack=setInterval(n(),c||r)}function b(){n.innerHTML="",v({line:1})}function E(e){var t=e.run;clearInterval(D.type),t(n),D.item++,f()}function k(){clearInterval(D.type),D.cb()}function L(){return M.el&&M.el.removeEventListener(M.type,M.fxn),clearInterval(D.iterator),clearInterval(D.goBack),clearTimeout(D.pause),D.length=0,c(),T("kill")}function T(e){function n(e){return console.warn(t,e),x}var t='WARNING: you tried to call ".%s" after ".'+e+'" has already been called.\nThe public API has been nullified.';return Object.keys(x).forEach(function(t){"kill"===t&&"end"===e||(x[t]=n.bind(null,t))}),"kill"===e&&(D.killed&&n(),D.killed=!0),x}var D=[],A=document.body,M={};if("String"===o(n)&&(n=document.querySelector(n)),n.getAttribute("data-typer"))throw"You've already called Typer on this element.";r=u(r),D.speedSet=!0,D.voids=["AREA","BASE","BR","COL","COMMAND","EMBED","HR","IMG","INPUT","KEYGEN","LINK","META","PARAM","SOURCE","TRACK","WBR"],D.classNames=["typer","cursor-block","cursor-soft","cursor-hard","no-cursor"],D.uuid=t(),n.setAttribute("data-typer",D.uuid);var x={cursor:function(e){if(D.cursorRan)return console.warn('You can only call ".cursor" once.'),this;if(D.cursorRan=!0,void 0===e&&(e=!0),!1===e)return D.cursor="no-cursor",this;var n=e,t=n.color,r=n.blink,i=n.block,o=[],u='[data-typer="'+D.uuid+'"]';return t&&s(u+" .typer::after","background-color:"+t),o.push("cursor-"+("hard"===r?"hard":"soft")),!0===i&&o.push("cursor-block"),D.cursor=o.join(" "),this},line:function(e,n){return d("line",e,n),D.typing||(D.typing=!0,f()),this},continue:function(e,n){return d("continue",e,n),this},pause:function(e){return D.push({pause:+e||500}),this},emit:function(e,n){return n?"String"===o(n)&&(n=document.querySelector(n)):n=A,D.push({emit:e,el:n}),this},listen:function(e,n){return n?"String"===o(n)&&(n=document.querySelector(n)):n=A,D.push({listen:e,el:n}),this},back:function(e,n){return D.push({back:e,speed:n}),this},empty:function(){return D.push({empty:!0}),this},run:function(e){return D.push({run:e}),this},end:function(e,n){return D.push({end:!0}),D.cb=function(){return c(e,n)},T("end")},kill:L};return x}var t=function e(n){return n?(n^16*Math.random()>>n/4).toString(16):([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g,e)};return n});