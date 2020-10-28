(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-dapp-event"],{"142b":function(t,e,n){"use strict";n.r(e);var r=n("8338"),a=n("3e1b");for(var o in a)"default"!==o&&function(t){n.d(e,t,(function(){return a[t]}))}(o);n("4ca0");var s,i=n("f0c5"),u=Object(i["a"])(a["default"],r["b"],r["c"],!1,null,"5a94e6cf",null,!1,r["a"],s);e["default"]=u.exports},"1d59":function(t,e,n){"use strict";(function(t){n("ac1f"),n("5319"),Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var r,a=n("e335"),o={name:"event",data:function(){return{title:"记录",list:[],log:"",type:"",hxaddress:null}},onLoad:function(t){r=this,r.log=t.log,r.type=t.type},created:function(){r=this,r.hxaddress=r.$common.tronWeb.defaultAddress.hex,r.hxaddress=r.hxaddress.substring(2,r.hxaddress.length),"contract"==r.type&&r.initContractContract(),"token"==r.type&&r.initTokenContract()},methods:{initContractContract:function(){uni.request({url:"/static/abi/GAME.json",method:"GET",success:function(t){r.$common.contractContract=r.$common.tronWeb.contract(t.data,r.$common.contract_contract_address),r.getContract()}})},initTokenContract:function(){uni.request({url:"/static/abi/FPT.json",method:"GET",success:function(t){r.$common.tokenContract=r.$common.tronWeb.contract(t.data,r.$common.contract_address),r.getContract()}})},getEvent:function(t,e,n,a){"token"==t?r.$common.contract_address:r.$common.contract_contract_address,r.$common.getEvent(e,n,(function(t){a(t)}))},getContract:function(){switch(r.log){case"Buyer":r.title=r.$t("overview.purchaseRecords");var e={buyer:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(t){r.list=[];for(var e=0;e<t.length;e++){var n=[],o=[];n.push(r.$t("event.amount")),o.push(r.fromSun(t[e].amount)+" TRX"),n.push(r.$t("event.number")),o.push(r.fromSun(t[e].tokens)+" FPT"),n.push(r.$t("event.time")),o.push((0,a.formatDate)(t[e].timeStamp,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:n,v:o})}}));break;case"InvitBuy":r.title=r.$t("overview.refundRecord");e={inviter:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(t){r.list=[];for(var e=0;e<t.length;e++){var n=[],o=[];n.push(r.$t("event.referrer"));var s=t[e].buyer.replace("0x","41");o.push(r.fromHex(s)),n.push(r.$t("event.purchasingPrice")),o.push(r.fromSun(t[e].amount)+" TRX"),n.push(r.$t("event.number")),o.push(r.fromSun(t[e].invit)+" FPT"),n.push(r.$t("event.time")),o.push((0,a.formatDate)(t[e].timeStamp,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:n,v:o})}}));break;case"TeamRewardEvent":r.title=r.$t("overview.refundRecord");e={_player:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(e){t.log(e),r.list=[];for(var n=0;n<e.length;n++){var o=[],s=[];o.push(r.$t("event.referrer"));var i=e[n]._invit.replace("0x","41");s.push(r.fromHex(i)),o.push(r.$t("event.level")),s.push(e[n]._level),o.push(r.$t("event.reward")),s.push(r.fromSun(e[n]._rewardAmount)),o.push(r.$t("event.time")),s.push((0,a.formatDate)(e[n].time,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:o,v:s})}}));break;case"InvitEvent":r.title=r.$t("overview.recommendationRecord");e={_from:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(t){r.list=[];for(var e=0;e<t.length;e++){var n=[],o=[];n.push(r.$t("event.referrer"));var s=t[e]._player.replace("0x","41");o.push(r.fromHex(s)),n.push(r.$t("event.time")),o.push((0,a.formatDate)(t[e].time,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:n,v:o})}}));break;case"JoinEvent":r.title=r.$t("overview.participationRecord");e={_player:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(t){r.list=[];for(var e=0;e<t.length;e++){var n=[],o=[];n.push(r.$t("event.number")),o.push(r.fromSun(t[e]._joinAmount)+" TRX"),n.push(r.$t("event.time")),o.push((0,a.formatDate)(t[e].time,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:n,v:o})}}));break;case"ProfitEvent":r.title=r.$t("overview.commissionWithdrawalRecord");e={_player:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(t){r.list=[];for(var e=0;e<t.length;e++){var n=[],o=[];n.push(r.$t("event.number"));var s=r.fromSun(t[e]._rewardAmount);s=Math.floor(1e4*s)/1e4,o.push(s+" TRX"),n.push(r.$t("event.time")),o.push((0,a.formatDate)(t[e].time,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:n,v:o})}}));break;case"PrizeEvent":r.title=r.$t("overview.winningRecord");e={_player:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(t){r.list=[];for(var e=0;e<t.length;e++){var n=[],o=[];n.push(r.$t("event.prizePool")),o.push(r.fromSun(t[e]._jackpot)),n.push(r.$t("event.awards")),o.push(t[e]._prize),n.push(r.$t("event.number")),o.push(r.fromSun(t[e]._amount)+" TRX"),n.push(r.$t("event.time")),o.push((0,a.formatDate)(t[e].time,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:n,v:o})}}));break;case"WithdrawEvent":r.title=r.$t("overview.revenueWithdrawalRecord");e={_player:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(t){r.list=[];for(var e=0;e<t.length;e++){var n=[],o=[];n.push(r.$t("event.number"));var s=r.fromSun(t[e]._amount);o.push(Math.floor(1e4*s)/1e4),n.push(r.$t("event.time")),o.push((0,a.formatDate)(t[e].time,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:n,v:o})}}));break;case"SuperPlayerEvent":r.title=r.$t("overview.superNodeRevenueRecord");e={_player:"0x"+r.hxaddress};r.getEvent(r.type,r.log,e,(function(t){r.list=[];for(var e=0;e<t.length;e++){var n=[],o=[];n.push(r.$t("event.total")),o.push(r.fromSun(t[e]._total)+" TRX"),n.push(r.$t("event.number")),o.push(r.fromSun(t[e]._amount)+" TRX"),n.push(r.$t("event.time")),o.push((0,a.formatDate)(t[e].time,"yyyy-MM-dd hh:mm:ss")),r.list.push({k:n,v:o})}}));break;default:return void uni.showToast({title:r.$t("maximumPurchase"),icon:"none",duration:1750})}},fromSun:function(t){return r.$common.tronWeb.fromSun(t)},toDecimal:function(t){return r.$common.tronWeb.toDecimal(t)},toSun:function(t){return r.$common.tronWeb.toSun(t)},fromHex:function(t){return r.$common.tronWeb.address.fromHex(t)}}};e.default=o}).call(this,n("5a52")["default"])},"28ec":function(t,e,n){var r=n("7758");"string"===typeof r&&(r=[[t.i,r,""]]),r.locals&&(t.exports=r.locals);var a=n("4f06").default;a("34f48a09",r,!0,{sourceMap:!1,shadowMode:!1})},"3e1b":function(t,e,n){"use strict";n.r(e);var r=n("1d59"),a=n.n(r);for(var o in r)"default"!==o&&function(t){n.d(e,t,(function(){return r[t]}))}(o);e["default"]=a.a},"4ca0":function(t,e,n){"use strict";var r=n("28ec"),a=n.n(r);a.a},7758:function(t,e,n){var r=n("24fb");e=r(!1),e.push([t.i,".cont[data-v-5a94e6cf]{background:url(/static/index-bg.png) no-repeat 50%;background-size:100% 100%;min-height:100vh}.event_list[data-v-5a94e6cf]{padding:%?20?%}.list_body[data-v-5a94e6cf]{height:calc(100vh - %?140?%)}.list_header uni-view[data-v-5a94e6cf]{display:inline-block;text-align:center}.list_cont[data-v-5a94e6cf]{border-top:rgba(0,0,0,.1) solid %?1?%;background:#fff;width:96%;-webkit-border-radius:%?20?%;border-radius:%?20?%;margin:0 auto;padding:%?20?% %?30?%;margin-bottom:%?20?%;-webkit-box-shadow:%?10?% %?10?% %?10?% rgba(0,0,0,.1);box-shadow:%?10?% %?10?% %?10?% rgba(0,0,0,.1)}.no_data[data-v-5a94e6cf]{margin-top:%?150?%;text-align:center}.no_data uni-image[data-v-5a94e6cf]{width:%?200?%;height:%?150?%}.item[data-v-5a94e6cf]{display:-webkit-box;display:-webkit-flex;display:flex;line-height:%?60?%;-webkit-box-pack:justify;-webkit-justify-content:space-between;justify-content:space-between}.item uni-view[data-v-5a94e6cf]:first-child{width:30%}",""]),t.exports=e},8338:function(t,e,n){"use strict";var r;n.d(e,"b",(function(){return a})),n.d(e,"c",(function(){return o})),n.d(e,"a",(function(){return r}));var a=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("v-uni-view",{staticClass:"cont"},[n("v-uni-scroll-view",{staticClass:"page",attrs:{"scroll-y":!0}},[n("cu-custom",{attrs:{bgColor:"bg-gradual-pink",isBack:"true"}},[n("template",{attrs:{slot:"back"},slot:"back"}),n("template",{attrs:{slot:"content"},slot:"content"},[t._v(t._s(t.title))])],2),n("v-uni-view",{staticClass:"event_list"},[t.list.length>0?n("v-uni-view",[n("v-uni-scroll-view",{staticClass:"list_body",attrs:{"scroll-y":!0}},t._l(t.list,(function(e,r){return n("v-uni-view",{staticClass:"list_cont"},[t._l(e.k,(function(r,a){return n("v-uni-view",{staticClass:"item"},[n("v-uni-view",{staticStyle:{color:"#000","font-weight":"400"}},[t._v(t._s(r))]),n("v-uni-view",{staticStyle:{overflow:"hidden",color:"#464646"}},[t._v(t._s(e.v[a]))])],1)}))],2)})),1)],1):n("v-uni-view",{staticClass:"no_data"},[n("v-uni-view",[n("v-uni-image",{attrs:{src:"/static/null.png"}})],1),n("v-uni-view",{staticStyle:{color:"#FFFFFF"}},[t._v(t._s(t.$t("event.noData"))+"...")])],1)],1)],1)],1)},o=[]}}]);