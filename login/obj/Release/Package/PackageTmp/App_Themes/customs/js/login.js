/* ======================================================================== 
 * Author : Muhamad Windy Sulistiyo
 * Copyright © 2014-2016 Skyworx Indonesia. All rights reserved.
 * ======================================================================== */



if (top != self) {top.location = self.location; }
        function kutip_satu() {
            if ((event.keyCode == 35) || (event.keyCode == 39)) {
                return false;
}
            else {
                return true;
}
}

// convert all characters to lowercase to simplify testing
var agt = navigator.userAgent.toLowerCase();

// *** BROWSER VERSION ***
// Note: On IE5, these return 4, so use is_ie5up to detect IE5.
var is_major = parseInt(navigator.appVersion);
var is_minor = parseFloat(navigator.appVersion);

var is_ie = ((agt.indexOf("msie") != -1) && (agt.indexOf("opera") == -1));
        var is_ie3 = (is_ie && (is_major < 4));
    var is_ie4 = (is_ie && (is_major == 4) && (agt.indexOf("msie 4") != -1));
    var is_ie4up = (is_ie && (is_major >= 4));
    var is_ie5 = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.0") != -1));
    var is_ie5_5 = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.5") != -1));
    var is_ie5up = (is_ie && !is_ie3 && !is_ie4);
    var is_ie5_5up = (is_ie && !is_ie3 && !is_ie4 && !is_ie5);
    var is_ie6 = (is_ie && (is_major == 4) && (agt.indexOf("msie 6.") != -1));
    var is_ie6up = (is_ie && !is_ie3 && !is_ie4 && !is_ie5 && !is_ie5_5);

        function checkIE() {
            if (!is_ie6up) {
        window.location = "invalidbrowser.html";
    }
}
