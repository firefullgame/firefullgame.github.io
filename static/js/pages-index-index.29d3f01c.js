(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-index-index"],{"0884":function(t,a,n){var e=n("24fb");a=e(!1),a.push([t.i,'uni-page-body[data-v-64333dca]{background-image:var(--gradualBlue);width:100vw;height:100vh;overflow:hidden}.notice_box[data-v-64333dca]{position:fixed;z-index:999999;top:%?15?%;width:88%}.lang[data-v-64333dca]{width:%?41?%;height:%?30?%;background:url(/static/image/lang.png) no-repeat 50%;background-size:calc(100%) calc(100%)}.text-active[data-v-64333dca]{color:#fff;font-size:%?30?%}.text-unactive[data-v-64333dca]{color:#f30e94;font-size:%?30?%}.DrawerPage[data-v-64333dca]{position:fixed;width:100vw;height:100vh;left:0;background-color:#f1f1f1;-webkit-transition:all .4s;transition:all .4s}.DrawerPage.show[data-v-64333dca]{-webkit-transform:scale(.9);transform:scale(.9);left:100vw;-webkit-box-shadow:0 0 %?60?% rgba(0,0,0,.2);box-shadow:0 0 %?60?% rgba(0,0,0,.2);-webkit-transform-origin:0;transform-origin:0}.DrawerWindow[data-v-64333dca]{position:fixed;z-index:999999;width:100vw;height:100vh;left:0;top:0;-webkit-transform:scale(.9) translateX(-100%);transform:scale(.9) translateX(-100%);opacity:0;pointer-events:none;-webkit-transition:all .4s;transition:all .4s;\n  /* padding: 100upx 0; */background:#7f1156}.langBox[data-v-64333dca]{padding:%?50?%}.langBox .langList[data-v-64333dca]{height:%?106?%;border-bottom:1px solid #e3e3e3;line-height:%?106?%;font-size:%?28?%;font-family:Source Han Sans CN;font-weight:400;color:#fff}.DrawerWindow.show[data-v-64333dca]{-webkit-transform:scale(1) translateX(0);transform:scale(1) translateX(0);opacity:1;pointer-events:all}.DrawerClose[data-v-64333dca]{position:absolute;width:40vw;height:100vh;right:0;top:0;color:transparent;padding-bottom:%?30?%;display:-webkit-box;display:-webkit-flex;display:flex;-webkit-box-align:end;-webkit-align-items:flex-end;align-items:flex-end;-webkit-box-pack:center;-webkit-justify-content:center;justify-content:center;background-image:-webkit-gradient(linear,left top,right top,from(rgba(0,0,0,.01)),to(rgba(0,0,0,.6)));background-image:-webkit-linear-gradient(left,rgba(0,0,0,.01),rgba(0,0,0,.6));background-image:linear-gradient(90deg,rgba(0,0,0,.01),rgba(0,0,0,.6));letter-spacing:5px;font-size:%?50?%;opacity:0;pointer-events:none;-webkit-transition:all .4s;transition:all .4s}.DrawerClose.show[data-v-64333dca]{opacity:1;pointer-events:all;width:15vw;color:#fff}.DrawerPage .cu-bar.tabbar .action uni-button.cuIcon[data-v-64333dca]{width:%?64?%;height:%?64?%;line-height:%?64?%;margin:0;display:inline-block}.DrawerPage .cu-bar.tabbar .action .cu-avatar[data-v-64333dca]{margin:0}.DrawerPage .nav[data-v-64333dca]{-webkit-box-flex:1;-webkit-flex:1;flex:1}.DrawerPage .nav .cu-item.cur[data-v-64333dca]{border-bottom:0;position:relative}.DrawerPage .nav .cu-item.cur[data-v-64333dca]::after{content:"";width:%?10?%;height:%?10?%;background-color:currentColor;position:absolute;bottom:%?10?%;-webkit-border-radius:%?10?%;border-radius:%?10?%;left:0;right:0;margin:auto}.DrawerPage .cu-bar.tabbar .action[data-v-64333dca]{-webkit-box-flex:initial;-webkit-flex:initial;flex:initial}.tabbar[data-v-64333dca]{background:url(/static/image/tabbar.png) no-repeat 50%;background-size:100% 100%}.btns[data-v-64333dca]{display:-webkit-box;display:-webkit-flex;display:flex;-webkit-box-pack:justify;-webkit-justify-content:space-between;justify-content:space-between;width:%?540?%;margin:%?20?% auto;font-size:%?28?%;font-family:Source Han Sans CN;font-weight:400}.btns .leftBtn[data-v-64333dca]{width:%?260?%;height:%?80?%;background:rgba(243,14,148,0);border:%?2?% solid #f30e94;-webkit-border-radius:%?40?%;border-radius:%?40?%;text-align:center;line-height:%?80?%;color:#f30e94}.btns .rightBtn[data-v-64333dca]{width:%?260?%;height:%?80?%;background:#f30e94;-webkit-border-radius:%?40?%;border-radius:%?40?%;text-align:center;line-height:%?80?%;color:#fff}.cu-bar1[data-v-64333dca]{margin:%?30?% 0;font-size:%?36?%;font-family:Source Han Sans CN;font-weight:400;color:#000}body.?%PAGE?%[data-v-64333dca]{background-image:var(--gradualBlue)}',""]),t.exports=a},"1ef2":function(t,a,n){var e=n("0884");"string"===typeof e&&(e=[[t.i,e,""]]),e.locals&&(t.exports=e.locals);var i=n("4f06").default;i("818ac5c2",e,!0,{sourceMap:!1,shadowMode:!1})},"209e":function(t,a,n){"use strict";n.d(a,"b",(function(){return i})),n.d(a,"c",(function(){return o})),n.d(a,"a",(function(){return e}));var e={uniNoticeBar:n("7580").default},i=function(){var t=this,a=t.$createElement,n=t._self._c||a;return n("v-uni-view",[n("v-uni-view",{staticClass:"bg-gradual-blue"},[n("v-uni-scroll-view",{staticClass:"DrawerPage",class:"viewModal"==t.modalName?"show":"",attrs:{"scroll-y":!0}},[n("v-uni-view",{staticClass:"notice_box"},[n("uni-notice-bar",{attrs:{scrollable:!0,speed:3,"background-color":"transparent",color:"#FFFFFF",text:t.notice_text},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.to_dapp("prize")}}})],1),n("cu-custom",{staticStyle:{position:"absolute",top:"0",color:"#FFFFFF"}},[n("template",{attrs:{slot:"right"},slot:"right"},[n("v-uni-view",{staticClass:"lang",staticStyle:{right:"30upx",position:"fixed"},attrs:{"data-target":"viewModal"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.showModal.apply(void 0,arguments)}}})],1)],2),0==t.wallet_warning?["index"==t.PageCur?n("index"):t._e(),"ticket"==t.PageCur?n("ticket"):t._e(),"contract"==t.PageCur?n("contract"):t._e(),"overview"==t.PageCur?n("overview"):t._e()]:t._e()],2)],1),n("v-uni-view",{staticClass:"cu-bar tabbar shadow foot"},[n("v-uni-view",{staticClass:"action",attrs:{"data-cur":"index"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.NavChange.apply(void 0,arguments)}}},[n("v-uni-view",{staticClass:"cuIcon-cu-image"},[n("v-uni-image",{style:"index"==t.PageCur?"display: none;":"",attrs:{src:"/static/tabbar/basics.png"}}),n("v-uni-image",{style:"index"!=t.PageCur?"display: none;":"",attrs:{src:"/static/tabbar/basics_cur.png"}})],1),n("v-uni-view",{class:"index"==t.PageCur?"text-active":"text-unactive"},[t._v(t._s(t.$t("index.info")))])],1),n("v-uni-view",{staticClass:"action",attrs:{"data-cur":"ticket"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.NavChange.apply(void 0,arguments)}}},[n("v-uni-view",{staticClass:"cuIcon-cu-image"},[n("v-uni-image",{style:"ticket"==t.PageCur?"display: none;":"",attrs:{src:"/static/tabbar/power.png"}}),n("v-uni-image",{style:"ticket"!=t.PageCur?"display: none;":"",attrs:{src:"/static/tabbar/power_cur.png"}})],1),n("v-uni-view",{class:"ticket"==t.PageCur?"text-active":"text-unactive"},[t._v(t._s(t.$t("index.ticket")))])],1),n("v-uni-view",{staticClass:"action",attrs:{"data-cur":"contract"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.NavChange.apply(void 0,arguments)}}},[n("v-uni-view",{staticClass:"cuIcon-cu-image"},[n("v-uni-image",{style:"contract"==t.PageCur?"display: none;":"",attrs:{src:"/static/tabbar/contract.png"}}),n("v-uni-image",{style:"contract"!=t.PageCur?"display: none;":"",attrs:{src:"/static/tabbar/contract_cur.png"}})],1),n("v-uni-view",{class:"contract"==t.PageCur?"text-active":"text-unactive"},[t._v(t._s(t.$t("index.contract")))])],1),n("v-uni-view",{staticClass:"action",attrs:{"data-cur":"overview"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.NavChange.apply(void 0,arguments)}}},[n("v-uni-view",{staticClass:"cuIcon-cu-image"},[n("v-uni-image",{style:"overview"==t.PageCur?"display: none;":"",attrs:{src:"/static/tabbar/list.png"}}),n("v-uni-image",{style:"overview"!=t.PageCur?"display: none;":"",attrs:{src:"/static/tabbar/list_cur.png"}})],1),n("v-uni-view",{class:"overview"==t.PageCur?"text-active":"text-unactive"},[t._v(t._s(t.$t("index.overview")))])],1)],1),n("v-uni-view",{staticClass:"DrawerClose",class:"viewModal"==t.modalName?"show":"",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.hideModal.apply(void 0,arguments)}}},[n("v-uni-text",{staticClass:"cuIcon-pullright"})],1),n("v-uni-scroll-view",{staticClass:"DrawerWindow",class:"viewModal"==t.modalName?"show":"",attrs:{"scroll-y":!0}},[n("v-uni-view",{staticClass:"langBox"},[n("v-uni-view",{staticClass:"langList",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.langChange("en-US")}}},[t._v("English")]),n("v-uni-view",{staticClass:"langList",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.langChange("ru-RU")}}},[t._v("русский язык")]),n("v-uni-view",{staticClass:"langList",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.langChange("zh-SG")}}},[t._v("新加坡")]),n("v-uni-view",{staticClass:"langList",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.langChange("ja-JP")}}},[t._v("日本語")]),n("v-uni-view",{staticClass:"langList",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.langChange("ko-KR")}}},[t._v("한글")])],1)],1),n("v-uni-view",{staticClass:"cu-modal bottom-modal",class:t.wallet_warning?"show":""},[n("v-uni-view",{staticClass:"cu-dialog dialogImg"},[n("v-uni-view",{staticClass:"lang",staticStyle:{position:"absolute",right:"30upx",top:"30upx"},attrs:{"data-target":"viewModal"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.showModal.apply(void 0,arguments)}}}),n("v-uni-view",{staticClass:"logo"},[n("v-uni-image",{attrs:{src:"/static/logo.png"}}),n("v-uni-view",[t._v(t._s(t.$t("indexs.fireIsOnDreamsNeverGoOut")))])],1),n("v-uni-view",{staticClass:"imageBox"}),n("v-uni-view",{staticClass:"padding-xl",staticStyle:{color:"#FFFFFF","font-size":"32upx"}},[t._v(t._s(t.$t("please_use_wallet")))])],1)],1),n("v-uni-view",{staticClass:"cu-modal",class:"actionModal"==t.modalName?"show":""},[n("v-uni-view",{staticClass:"cu-dialog"},[n("v-uni-view",{staticClass:"cu-bar1 bg-white justify-end"},[n("v-uni-view",{staticClass:"content"},[t._v(t._s(t.$t("index.activateContractNode")))])],1),n("v-uni-view",{staticClass:"text-black send_box",staticStyle:{padding:"0 30upx","font-size":"28upx","font-family":"Source Han Sans CN","font-weight":"400",color:"#464646","line-height":"46upx"}},[n("v-uni-view",{staticClass:"send_item",staticStyle:{"text-align":"left"},domProps:{innerHTML:t._s(t.$t("index.activateContractTip"))}})],1),n("v-uni-view",{staticClass:"btns"},[n("v-uni-view",{staticClass:"leftBtn",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.hideModal.apply(void 0,arguments)}}},[t._v(t._s(t.$t("ticket.cancel")))]),n("v-uni-view",{staticClass:"rightBtn",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.activate.apply(void 0,arguments)}}},[t._v(t._s(t.$t("index.send")))])],1)],1)],1)],1)},o=[]},"2d28":function(t,a,n){"use strict";var e=n("e03d"),i=n.n(e);i.a},6475:function(t,a,n){"use strict";n.r(a);var e=n("209e"),i=n("6fd3");for(var o in i)"default"!==o&&function(t){n.d(a,t,(function(){return i[t]}))}(o);n("2d28"),n("fd09");var c,r=n("f0c5"),s=Object(r["a"])(i["default"],e["b"],e["c"],!1,null,"64333dca",null,!1,e["a"],c);a["default"]=s.exports},"6fd3":function(t,a,n){"use strict";n.r(a);var e=n("87db1"),i=n.n(e);for(var o in e)"default"!==o&&function(t){n.d(a,t,(function(){return e[t]}))}(o);a["default"]=i.a},"87db1":function(t,a,n){"use strict";var e=n("4ea4");n("4e82"),n("ac1f"),n("5319"),Object.defineProperty(a,"__esModule",{value:!0}),a.default=void 0;var i,o=e(n("7580")),c=e(n("6e02")),r=(e(n("9167")),{data:function(){return{PageCur:"index",modalName:"",wallet_warning:!1,notice_text:""}},onShow:function(){i.wallet_warning=!0,i.initWeb3Account()},onLoad:function(t){i=this,t.ref?i.$common.ticket_invit_address=t.ref:t.address&&(i.$common.ticket_invit_address=t.address)},components:{uniNoticeBar:o.default},methods:{to_dapp:function(t){uni.navigateTo({url:"/pages/dapp/"+t})},showModal:function(t){i.modalName=t.currentTarget.dataset.target,i.wallet_warning=!1},hideModal:function(t){i.modalName=null,i.$common.account||(i.wallet_warning=!0)},tabSelect:function(t){i.TabCur=t.currentTarget.dataset.id,i.scrollLeft=60*(t.currentTarget.dataset.id-1)},langChange:function(t){uni.setStorageSync("lang",t),c.default.$emit("setlang",t),i.$i18n.locale=t,i.hideModal()},close:function(){uni.showToast({title:i.$t("notYetOpen"),icon:"none",duration:1750})},NavChange:function(t){i.PageCur=t.currentTarget.dataset.cur},fromHex:function(t){return i.$common.tronWeb.address.fromHex(t)},fromSun:function(t){return i.$common.tronWeb.fromSun(t)},initWeb3Account:function(){window.tronWeb&&window.tronWeb.defaultAddress.base58?(i.$common.tronWeb=window.tronWeb,i.$common.account=i.$common.tronWeb.defaultAddress.base58,i.wallet_warning=!1,i.getPrizeLog(),i.initContract()):setTimeout((function(){i.initWeb3Account()}),500)},getPrizeLog:function(){i.$common.getEvent("PrizeEvent",{},(function(t){i.notice_text="",t=t.sort((function(t,a){return t._prize-a._prize}));for(var a=0;a<t.length;a++){var n=t[a]._player.replace("0x","41");n=i.fromHex(n);var e=["🥇","🥈🥈","🥉🥉🥉"];n==i.$common.account?i.notice_text=i.notice_text+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+e[t[a]._prize-1]+i.$t("SelfPlayerForWinningPrizeAndWinningPrizeInTotal",[t[a]._prize,i.fromSun(t[a]._amount)+" TRX"]):i.notice_text=i.notice_text+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+e[t[a]._prize-1]+i.$t("congratulationsToPlayerForWinningPrizeAndWinningPrizeInTotal",[n.substr(0,4)+"******"+n.substr(30),t[a]._prize,i.fromSun(t[a]._amount)+" TRX"])}}),31)},initContract:function(){uni.request({url:"/static/abi/FPT.json",method:"GET",success:function(t){i.$common.tokenContract=i.$common.tronWeb.contract(t.data,i.$common.contract_address),i.getContract()}})},getContract:function(){uni.request({url:"/static/abi/GAME.json",method:"GET",success:function(t){i.$common.contractContract=i.$common.tronWeb.contract(t.data,i.$common.contract_contract_address),i.$common.tokenContract.methods.getSP(i.$common.account).call((function(t,a){!t&&a&&a[0]&&i.$common.contractContract.methods.players(i.$common.account).call((function(t,a){!t&&a&&!a.isSP&&a.state&&(i.modalName="actionModal")}))}))}})},activate:function(){uni.showToast({title:i.$t("sendTransactionConfirmed"),icon:"none",duration:1750}),i.hideModal(),i.$common.tokenContract.methods.getSP(i.$common.account).call((function(t,a){!t&&a&&a[0]&&i.$common.contractContract.methods.activateSuperPlayer().send({shouldPollResponse:!0},(function(t,a){t?uni.showToast({title:i.$t("index.activate")+i.$t("fail"),icon:"none",duration:1750}):uni.showToast({title:i.$t("index.activate")+i.$t("success"),icon:"none",duration:1750})}))}))}}});a.default=r},e03d:function(t,a,n){var e=n("e0ff");"string"===typeof e&&(e=[[t.i,e,""]]),e.locals&&(t.exports=e.locals);var i=n("4f06").default;i("0beea880",e,!0,{sourceMap:!1,shadowMode:!1})},e0ff:function(t,a,n){var e=n("24fb");a=e(!1),a.push([t.i,".dialogImg[data-v-64333dca]{height:calc(100%);background:url(/static/index-bg.png) no-repeat 50%;background-size:calc(100%) calc(100%)}.logo[data-v-64333dca]{width:60%;height:%?450?%;margin:0 auto;text-align:center;font-size:%?35?%;font-weight:700;background-image:-webkit-gradient(linear,left top,right top,from(#ccc),to(#ff0));background-image:-webkit-linear-gradient(left,#ccc,#ff0);background-image:linear-gradient(90deg,#ccc,#ff0);-webkit-background-clip:text;color:transparent}.logo uni-image[data-v-64333dca]{margin-top:%?68?%;width:%?200?%;height:%?200?%}.imageBox[data-v-64333dca]{width:%?436?%;height:%?479?%;margin:%?-120?% auto 0;background:url(/static/indexBg1.png) no-repeat 50%;background-size:calc(100%) calc(100%)}",""]),t.exports=a},fd09:function(t,a,n){"use strict";var e=n("1ef2"),i=n.n(e);i.a}}]);