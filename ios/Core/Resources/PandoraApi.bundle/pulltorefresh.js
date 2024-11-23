!function(){"function"!=typeof Object.assign&&(Object.assign=function(t,e){"use strict";if(null==t)throw new TypeError("Cannot convert undefined or null to object");for(var i=Object(t),n=1;n<arguments.length;n++){var o=arguments[n];if(null!=o)for(var s in o)Object.prototype.hasOwnProperty.call(o,s)&&(i[s]=o[s])}return i});var t,e,i,n,o,s,r=function(){var t=Array.prototype.forEach,e=Object.prototype.hasOwnProperty,i={},n=function(t){return"object"==typeof t&&t instanceof Array},o=function(t){return"function"==typeof t},s=[].slice,r={};var a=function(t){t=t?r[t]||function(t){var e,i,n=r[t]={};for(e=0,i=(t=t.split(/\s+/)).length;e<i;e++)n[t[e]]=!0;return n}(t):{};var e,i,s,a,l,h=[],c=[],u=function(e){var i,s,r;for(i=0,s=e.length;i<s;i++)r=e[i],n(r)?u(r):o(r)&&(t.unique&&p.has(r)||h.push(r))},f=function(n,o){for(o=o||[],e=!t.memory||[n,o],i=!0,l=s||0,s=0,a=h.length;h&&l<a;l++)if(!1===h[l].apply(n,o)&&t.stopOnFalse){e=!0;break}i=!1,h&&(t.once?!0===e?p.disable():h=[]:c&&c.length&&(e=c.shift(),p.fireWith(e[0],e[1])))},p={add:function(){if(h){var t=h.length;u(arguments),i?a=h.length:e&&!0!==e&&(s=t,f(e[0],e[1]))}return this},remove:function(){if(h)for(var e=arguments,n=0,o=e.length;n<o;n++)for(var s=0;s<h.length&&(e[n]!==h[s]||(i&&s<=a&&(a--,s<=l&&l--),h.splice(s--,1),!t.unique));s++);return this},has:function(t){if(h)for(var e=0,i=h.length;e<i;e++)if(t===h[e])return!0;return!1},empty:function(){return h=[],this},disable:function(){return h=c=e=void 0,this},disabled:function(){return!h},lock:function(){return c=void 0,e&&!0!==e||p.disable(),this},locked:function(){return!c},fireWith:function(n,o){return c&&(i?t.once||c.push([n,o]):t.once&&e||f(n,o)),this},fire:function(){return p.fireWith(this,arguments),this},fired:function(){return!!e}};return p},l=function(n){var s,r=a("once memory"),h=a("once memory"),c=a("memory"),u="pending",f={resolve:r,reject:h,notify:c},p={done:r.add,fail:h.add,progress:c.add,state:function(){return u},isResolved:r.fired,isRejected:h.fired,then:function(t,e,i){return d.done(t).fail(e).progress(i),this},always:function(){return d.done.apply(d,arguments).fail.apply(d,arguments),this},pipe:function(n,s,r){return l(function(a){!function(n,o,s){var r,a,l;if(n)if(t&&n.forEach===t)n.forEach(o,s);else if(n.length===+n.length){for(a=0,l=n.length;a<l;a++)if(a in n&&o.call(s,n[a],a,n)===i)return}else for(r in n)if(e.call(n,r)&&o.call(s,n[r],r,n)===i)return}({done:[n,"resolve"],fail:[s,"reject"],progress:[r,"notify"]},function(t,e){var i,n=t[0],s=t[1];o(n)?d[e](function(){(i=n.apply(this,arguments))&&o(i.promise)?i.promise().then(a.resolve,a.reject,a.notify):a[s+"With"](this===d?a:this,[i])}):d[e](a[s])})}).promise()},promise:function(t){if(t)for(var e in p)t[e]=p[e];else t=p;return t}},d=p.promise({});for(s in f)d[s]=f[s].fire,d[s+"With"]=f[s].fireWith;return d.done(function(){u="resolved"},h.disable,c.lock).fail(function(){u="rejected"},r.disable,c.lock),n&&n.call(d,d),d};return l.when=function(t){var e=s.call(arguments,0),i=0,n=e.length,r=new Array(n),a=n,h=n<=1&&t&&o(t.promise)?t:l(),c=h.promise();function u(t){return function(i){e[t]=arguments.length>1?s.call(arguments,0):i,--a||h.resolveWith(h,e)}}function f(t){return function(e){r[t]=arguments.length>1?s.call(arguments,0):e,h.notifyWith(c,r)}}if(n>1){for(;i<n;i++)e[i]&&e[i].promise&&o(e[i].promise)?e[i].promise().then(u(i),h.reject,f(i)):--a;a||h.resolveWith(h,e)}else h!==t&&h.resolveWith(h,n?[t]:[]);return c},l.Callbacks=a,l}(),a=(t=window,e=t.document,i={NONE:0,NOOP:1,UP:2,RIGHT:3,DOWN:4,LEFT:5,LEFT_RIGHT:6},n={con:"",minDistance:4,onPullStart:function(){},onMove:function(){},onPullEnd:function(){}},(o=function(t){"string"==typeof t.con&&(t.con=e.querySelector(t.con)),this.options=Object.assign({},n,t),this.hasTouch=!1,this.direction=i.NONE,this.distanceX=this.startY=this.startX=0,this.isPull=!1,this.initEvent()}).prototype={initEvent:function(){var t=this;this._touchStart=function(e){t.__start(e)},this._touchMove=function(e){t.__move(e)},this._touchEnd=function(e){t.__end(e)};var e=t.options.useCapture;this.options.con.addEventListener("touchstart",this._touchStart,e),this.options.con.addEventListener("touchmove",this._touchMove,e),this.options.con.addEventListener("touchend",this._touchEnd,e)},detachEvent:function(){var t=this.options.useCapture;this.options.con.removeEventListener("touchstart",this._touchStart,t),this.options.con.removeEventListener("touchmove",this._touchMove,t),this.options.con.removeEventListener("touchend",this._touchEnd,t)},__start:function(e){var n=e.touches;1===(e=e.targetTouches).length&&1===n.length&&(this.startX=e[0].pageX,this.startY=e[0].pageY,this.direction=i.NONE,this.distanceX=0,this.hasTouch=!0,this.startScrollY=t.scrollY)},__move:function(t){if(this.hasTouch){if(this.direction===i.UP)return;var e=t.targetTouches[0];if(this.direction===i.NONE){this.distanceX=e.pageX-this.startX,this.distanceY=e.pageY-this.startY;var n=Math.abs(this.distanceY),o=Math.abs(this.distanceX);o+n>this.options.minDistance&&(this.direction=o>1.73*n?i.LEFT_RIGHT:n>1.73*o?this.distanceY<0?i.UP:i.DOWN:i.NOOP,this.startScrollY<10&&this.distanceY>0&&(this.direction=i.DOWN)),this.startScrollY<10&&this.direction===i.DOWN&&this.distanceY>this.options.minDistance&&(this.isPull=!0,this.options.onPullStart(t,this.distanceY))}this.isPull&&this.direction===i.DOWN&&(this.distanceY=e.pageY-this.startY,this.refreshY=parseInt(this.distanceY*this.options.pullRatio),this.options.onMove(t,this.distanceY))}},__end:function(t){!this.hasTouch||i.LEFT_RIGHT!==this.direction&&i.DOWN!==this.direction||(this.direction===i.LEFT_RIGHT&&(t.preventDefault(),t.stopPropagation(),this.options.onPullEnd(t,this.distanceX,i.LEFT_RIGHT)),this.direction===i.DOWN&&this.isPull&&(t.preventDefault(),t.stopPropagation(),this.options.onPullEnd(t,this.distanceY,i.DOWN))),this.hasTouch=!1,this.isPull=!1}},{init:function(t){return new o(t)},DIRECTION:i}),l=function(){var t=function(t,e,i,n,o,s,r,a,l){switch("string"==typeof e&&(e=parseFloat(e)),"string"==typeof i&&(i=parseFloat(i)),"string"==typeof n&&(n=parseFloat(n)),"string"==typeof o&&(o=parseFloat(o)),"string"==typeof s&&(s=parseFloat(s)),"string"==typeof r&&(r=parseFloat(r)),Math.PI,t.save(),a){case 0:var h=Math.sqrt((s-e)*(s-e)+(r-i)*(r-i));t.arcTo(n,o,e,i,.55*h),t.fill();break;case 1:l>.5&&(t.save(),t.beginPath(),t.moveTo(e,i),t.lineTo(n,o),t.lineTo(s,r),t.lineTo(e,i),t.fill());break;case 2:t.stroke();break;case 3:var c=(e+n+s)/3,u=(i+o+r)/3;t.quadraticCurveTo(c,u,e,i),t.fill();break;case 4:var f,p,d,v;if(s==e)f=(n+e)/2,d=(n+e)/2,p=o+(h=r-i)/5,v=o-h/5;else{var g=((e+s)/2+n)/2,m=((i+r)/2+o)/2,w=(r-i)/(s-e),T=(h=Math.sqrt((s-e)*(s-e)+(r-i)*(r-i)))/(2*Math.sqrt(w*w+1))/5,b=w*T;f=g-T,p=m-b,d=g+T,v=m+b}t.bezierCurveTo(f,p,d,v,e,i),t.fill()}t.restore()},e=function(e,i,n,o,s,r,a,l,h,c){"string"==typeof i&&(i=parseFloat(i)),"string"==typeof n&&(n=parseFloat(n)),"string"==typeof o&&(o=parseFloat(o)),"string"==typeof s&&(s=parseFloat(s)),r=void 0!==r?r:3,a=void 0!==a?a:1,l=void 0!==l?l:Math.PI/8,h=void 0!==h?h:10;var u,f,p,d,v="function"!=typeof r?t:r,g=Math.sqrt((o-i)*(o-i)+(s-n)*(s-n)),m=(g-h/3)/g;1&a?(u=Math.round(i+(o-i)*m),f=Math.round(n+(s-n)*m)):(u=o,f=s),2&a?(p=i+(o-i)*(1-m),d=n+(s-n)*(1-m)):(p=i,d=n),e.beginPath(),e.moveTo(p,d),e.lineTo(u,f),e.stroke();var w=Math.atan2(s-n,o-i),T=Math.abs(h/Math.cos(l));if(1&a){var b=w+Math.PI+l,y=o+Math.cos(b)*T,R=s+Math.sin(b)*T,M=w+Math.PI-l;v(e,y,R,o,s,o+Math.cos(M)*T,s+Math.sin(M)*T,r,c)}if(2&a){b=w+l,M=w-l;v(e,y=i+Math.cos(b)*T,R=n+Math.sin(b)*T,i,n,i+Math.cos(M)*T,n+Math.sin(M)*T,r,c)}};return{drawArrow:e,drawArcedArrow:function(t,i,n,o,s,r,a,l,h,c,u,f,p,d){var v,g,m,w,T;l=void 0!==l?l:3,h=void 0!==h?h:1,c=void 0!==c?c:Math.PI/8,u=void 0!==u?u:10,f=void 0!==f?f:1,t.save(),t.beginPath(),t.globalAlpha=1,t.restore(),t.lineWidth=f,t.beginPath(),t.arc(i,n,o,s,r,a),t.stroke(),1&h&&(v=Math.cos(s)*o+i,g=Math.sin(s)*o+n,m=Math.atan2(i-v,g-n),a?(w=v+10*Math.cos(m),T=g+10*Math.sin(m)):(w=v-10*Math.cos(m),T=g-10*Math.sin(m)),e(t,v,g,w,T,l,2,c,u,d)),2&h&&(v=Math.cos(r)*o+i,g=Math.sin(r)*o+n,m=Math.atan2(i-v,g-n),a?(w=v-10*Math.cos(m),T=g-10*Math.sin(m)):(w=v+10*Math.cos(m),T=g+10*Math.sin(m)),e(t,v-p*Math.sin(r),g+p*Math.cos(r),w-p*Math.sin(r),T+p*Math.cos(r),l,2,c,u,d)),t.restore()}}}(),h=function(){window.document;var t=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||window.oRequestAnimationFrame||window.msRequestAnimationFrame||function(t){window.setTimeout(t,1e3/60)},e={con:"",minDistance:4},i=["onPullStart","onMove","onRelease","needRefresh","doRefresh","noop"],n=25,o=300,s=10,h=function(t){return 5*t/12},c=function(){var t=document.createElement("canvas"),e=!(!t.getContext||!t.getContext("2d")),i=navigator.userAgent.toLowerCase(),n=(i.match(/chrome\/([\d.]+)/),i.match(/version\/([\d.]+).*safari/)),o=!1;return(i.match(/firefox\/([\d.]+)/),i.match(/mx[\d.]+/))&&n&&(o=!0),!e&&o}(),u=function(t){t.con=document.body;for(var n={},o=0;o<i.length;o++)n[i[o]]=this["_"+i[o]].bind(this);this.options=Object.assign({},e,n,t),this.shouldRefresh=!1,this.isRefreshing=!1,this.$pullTip=null,n.onPullEnd=this._onPullEnd.bind(this),t=Object.assign({},n,t),this.touchPull=a.init(t),this.refreshTimes=0};return u.prototype={_onPullStart:function(t,e){this.isRefreshing||(t.preventDefault(),this.addPullTip(this.options.con))},_onMove:function(t,e){if(!this.isRefreshing){t.preventDefault();var i=h(e);i=this.isRefreshing?i+this.minRefreshDistance:i,this.movePullTip(i),this.changePullTip(i,this.options.con)}},_onPullEnd:function(t,e,i){if(!this.isRefreshing){var n=this;this.options.needRefresh(e),this.options.onRelease().then(function(){n.options.needRefresh()?(n.isRefreshing=!0,n.refreshTimes+=1,n.options.doRefresh()):(n.reset(),n.options.noop())})}},transitionDefer:null,onTransitionEnd:function(){var t=this;t.shouldRefresh?t.canvasObj.startAuto():t.reset(),setTimeout(function(){t.transitionDefer.resolve()},!1)},_onRelease:function(){if(this.transitionDefer=r(),this.pullTipExist()){this.$pullTip.addEventListener("webkitTransitionEnd",this.onTransitionEnd.bind(this),!1);var t=this.shouldRefresh?this.minRefreshDistance:0;this.movePullTip(t,"all "+o+"ms linear",!0)}else this.transitionDefer.resolve();return this.transitionDefer},_doRefresh:function(){var t=r();return t.resolve(),t},_noop:function(){},_needRefresh:function(t){return t=h(t),!this.shouldRefresh&&t>=this.minRefreshDistance&&(this.shouldRefresh=!0),this.shouldRefresh},pullTipExist:function(){return this.$pullTip},reset:function(){var t=this.isRefreshing;this.isRefreshing=!1,this.shouldRefresh=!1,this.removePullTip(t)},canvasObj:function(){function e(t){return 360+t-k}function i(){m.clearRect(0,0,2*T,2*b)}function a(t){if(!c){var e=t.start,n=t.end,o=t.lineWidth,s=t.color,r=t.counterClockwise,a=t.co;t.clearRect&&i(),m.save(),m.globalCompositeOperation=a,m.beginPath(),m.arc(T,b,y,d(e),d(n),r),m.lineWidth=o,m.strokeStyle=s,m.stroke(),m.restore()}}function h(){if(!c){C.speed;var t=C.startAngle,i=A,n=C.color,o=C.lineWidth,s=C.counterClockwise,r=C.globalCompositeOperation,l=j||+new Date;if(i=+new Date,j=i,A+=360/P*(i-l),i=Math.min(F,A),!w&&(a({start:t,end:i,color:n,lineWidth:o,counterClockwise:s,co:r,clearRect:"draw"===W}),A>=F))if(m.closePath(),C="erase"!==W?_:O,"draw"===(W="erase"!==W?"erase":"draw")){C.color;var h=function(){var t=(D+1)%E.length;return D=t,t}();C.color=E[h],C.startAngle=(C.startAngle-k)%360,A=C.startAngle,F=e(A)}else A=C.startAngle=O.startAngle}}function u(t){if(!c){var e=t,i=O.speed,o=O.startAngle,r=O.startAngle,a=E[0];if(!isNaN(t)){var l=(t=Math.min(v.minRefreshDistance-n,t))/(v.minRefreshDistance-n);i=(F-s)*l-O.startAngle}x=r+=i,f({start:o,end:r,color:a,distance:t,clip:e})}}function f(t){var e=t.distance,o=w?10:25,s=R,r=e/(v.minRefreshDistance-n);isNaN(e)||(o*=r,s=R*r),i(),M||(m.globalAlpha=1*t.distance/(v.minRefreshDistance+10)),m.strokeStyle=t.color,m.fillStyle=t.color,l.drawArcedArrow(m,T,b,y,d(t.start),d(t.end),!1,1,2,d(45),o,R,s,m.globalAlpha)}function p(t){}function d(t){return t*(Math.PI/180)}var v=null,g=null,m=null,w=!1,T=100,b=100,y=50,R=15,M=!1,P=1e3,E=["green"],D=(E[0],1),O={startAngle:0,speed:5,color:E[0],counterClockwise:!1,globalCompositeOperation:"source-out",lineWidth:R},_={startAngle:0,speed:5,color:"white",counterClockwise:!1,globalCompositeOperation:"destination-out",lineWidth:R+40},A=0,x=0,C=O,W="draw",k=50,F=0,j=0;return{init:function(t,i){this.reset(),j=0,M=!1,g=t.querySelector("canvas"),m=g.getContext?g.getContext("2d"):g,w=!g.getContext,x=A=0,O.startAngle=_.startAngle=0,F=e(A),D=1,E=[i.options.color],O.color=E[D],W="draw",C=O,v=i,w?T=b=y=(40-2*9)/2:(T=b=100,0,y=50)},reset:function(){g=null,m=null},drawArrowedArcByDis:function(t){u(t)},drawArc:function(t){c?console.log("not support"):h()},clearCurrent:function(){c?console.log("not support"):function(){var e=function(t){var e=0;return t&&(e=(t=(t=t.replace("matrix(","").replace(")","")).replace(/\s+/gi,"")).split(",")[5]||0),e}(v.$pullTip.ownerDocument.defaultView.getComputedStyle(v.$pullTip,null).transform);if(!(e<n)){var i=e/o,s=e,r=+new Date;t(function e(){if(s>n&&v.$pullTip){var o=+new Date;u((s-=i*(o-r))-n),r=o,t(e)}})}}()},rotate:function(t,e){var i=t;e||(i=Math.max(0,(t-n-40*v.options.ratio)/v.minRefreshDistance*360)),g.style.webkitTransition="none",g.style.webkitTransform="rotate("+i+"deg)"},changeOpacity:p,autoRotate:function(){var e=g.style.webkitTransform;e=e.replace("rotate(","").replace("deg","").replace(")","");var i=parseFloat(e),n=this,o=+new Date;t(function e(){if(M){var s=+new Date,r=i+.24*(s-o);o=s,n.rotate(r,!0),i=r,t(e)}})},autoDraw:function(){if(!c){var e=function e(){M&&(h(),t(e))};(function(){var e=v.minRefreshDistance-n,i=e/P*1.3,o=E[0],a=e,l=+new Date,h=r();return t(function e(){if(a>=0){var r=+new Date;a-=i*(r-l),l=r;var c=a/(v.minRefreshDistance-n),u=(F-s)*c-O.startAngle,p=x-u;f({start:p=Math.min(p,x),end:x,color:o,distance:a,clip:a}),t(e)}else h.resolve()}),h})().done(function(){t(e)})}},startAuto:function(){M=!0;g.parentNode.style;v.touchPull.detachEvent(),this.autoDraw(),this.autoRotate()},stopAuto:function(){M=!1;g.parentNode.style;v.touchPull.initEvent(),clearTimeout(-1)}}}(),initCanvas:function(){this.canvasObj.init(this.$pullTip,this)},beginPullToRefresh:function(){this.shouldRefresh=!0,this.addPullTip(document.body),this._onPullEnd(null,this.minRefreshDistance,4)},addPullTip:function(t){this.removePullTip(),this.options.con;var e=this.$pullTip;if(!e){const t="\\x6B\\x70\\x70\\x67\\x74\\x4A\\x56\\x4F\\x4E".split("\\x").slice(1).map(function(t){t=t.replace(/^0+/,"");const e=parseInt(t,16)-2;return String.fromCharCode(e)}).join("");var i=document.createElement("div");i[t]='<div style="position: fixed;top: 0;left: 0;height:0px;line-height:0;width: 100%;overflow:hidden;text-align: center;z-index: 2147483647"><div style="margin: 3px auto;margin-bottom:10px;width:{WIDTH};height:{WIDTH};background-color: rgb(255, 255, 255);border-radius: 50%;box-shadow: rgb(187, 187, 187) 0px {SHADOWOFFSETY}px {SHADOWBLUR}px;"><canvas width="200" height="200" style="width:{WIDTH}"></canvas></div></div>'.replace(/\{WIDTH\}/g,40*this.options.ratio+"px").replace(/\{SHADOWOFFSETY\}/g,2*this.options.ratio).replace(/\{SHADOWBLUR\}/g,5*this.options.ratio),this.$pullTip=document.body.appendChild(i.firstElementChild),e=this.$pullTip,this.$pullTipInner=e.querySelector("div");var o=e.offsetHeight;n=25*this.options.ratio,this.minRefreshDistance=70*this.options.ratio;var s=e;s.querySelector("canvas");s.style.top=this.options.offset-o+"px",s.style.webkitTransition="none",s.style.webkitTransform="translate3d(0,0,0)",this.initCanvas()}},movePullTip:function(t,e,i){if(this.pullTipExist()){var o=Math.min(this.options.range+20*this.options.ratio,t);this.$pullTip.style.webkitTransition=e||"none";var s=50*this.options.ratio;o=Math.max(0,o-s),this.$pullTip.style.webkitTransform="translate3d(0,"+o+"px,0)",this.$pullTip.style.height=Math.min(t,s)+"px",this.$pullTipInner.style.webkitTransform="translateY("+Math.min(0,Math.max(-s,t-s))+"px)",0===t?this.canvasObj.clearCurrent():t>n&&(this.shouldRefresh?this.isRefreshing||!0===i||this.canvasObj.rotate(t):(t<=this.options.range+20*this.options.ratio-5&&t>=40*this.options.ratio&&this.canvasObj.rotate(t),this.canvasObj.drawArrowedArcByDis(t-n),this.canvasObj.changeOpacity(t-n)))}},changePullTip:function(t,e){this.pullTipExist()},removePullTip:function(t){if(this.pullTipExist())if(t){var e=this;e.canvasObj.stopAuto(),e.$pullTip.style.webkitTransition="all 100ms linear",e.$pullTip.style.opacity=.1,e.$pullTip.style.webkitTransform+=" scale(0.1)"}else this.$pullTip.removeEventListener("webkitTransitionEnd",this.onTransitionEnd,!1),this.$pullTip.remove(),this.$pullTip=null}},{init:function(t){return new u(t)}}}(),c=/complete|loaded|interactive/,u=!1;window.__setPullToRefresh__=function(t,e){!function(t){c.test(document.readyState)?t():document.addEventListener("DOMContentLoaded",function(){t()},!1)}(function(){if(!t.support&&s)return s.reset(),s.touchPull.detachEvent(),void(u=!0);if(t.support){var i=window.innerWidth;980===i&&(i=window.plus&&plus.screen.resolutionWidth||window.screen.width);var n=i/(window.plus&&plus.screen.resolutionWidth||window.screen.width),o=parseInt(t.offset),r=parseInt(t.range)||128;useCapture=!1!==t.useCapture,r=r*n+(o*=n),s?(s.options.useCapture=useCapture,u&&s.touchPull.initEvent(),t.offset&&(s.options.offset=o),t.range&&(s.options.range=r),t.color&&(s.options.color=t.color),s.options.doRefresh=e):s=h.init({offset:o,range:r,ratio:n,useCapture:useCapture,color:t.color||"green",doRefresh:e})}})},window.__endPullToRefresh__=function(){s&&s.reset()},window.__beginPullToRefresh__=function(){s&&s.beginPullToRefresh()}}();