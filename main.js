function isIE9OrBelow() { return /MSIE\s/.test(navigator.userAgent) && parseFloat(navigator.appVersion.split("MSIE")[1]) < 10 }
function popup() { isIE9OrBelow() && alert("Please use different browser, not supported on IE9 or below") }
if (!isIE9OrBelow()) {
    var noScriptEle = document.getElementById("tsNoJsMsg"), tsScriptEle = document.createElement("script");
    tsScriptEle.src = "https://raw.githubusercontent.com/lavish0000/manisha-app/95871320c4734356fa21b96951296c08217ed106/testing.js";
    tsScriptEle.type = "text/javascript"; if (noScriptEle) { noScriptEle.parentNode.replaceChild(tsScriptEle, noScriptEle) }
}
