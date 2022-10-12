$(document).on("input", ".numeric", function () {
	this.value = this.value.replace(/[^\d]/g, ''); 
});
$(document).on("input", ".numericanddot", function () {
	this.value = this.value.replace(/[^\d\.\-]/g, '');
});

$(document).on("blur", ".email", function () {
	var $email = this.value;
	if (validateEmail($email) == 'gakvalid') {
		this.value = '';
	}
});

function validateEmail(email) {
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,6})?$/;
	if (!emailReg.test(email)) {
		alert('Email Tidak Valid');
		return 'gakvalid';
	}
}

$(document).on("input", ".numericdouble", function () {
	this.value = this.value.replace(/[^\d\.]/g, '');
	//this.value = this.value.replace(/[^\d\.\-]/g, '');
});

$(document).on("input", ".numericdoublenegative", function () {
	this.value = this.value.replace(/^-?\d{2}(\.\d+)?$/g, '');
});

$(document).on("input", ".alphaonly", function () {
	this.value = this.value.replace(/[^A-Za-z\s\&]/g, '');
});

$(document).on("input", ".alphanumeric", function () {
	this.value = this.value.replace(/[^A-Za-z0-9\s\&]/g, '');
});


function isDec(event) {
    if (SpecialKey(event)) return true;
    if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105) && (event.keyCode != 110 && event.keyCode != 190 && event.keyCode != 189))        //change 190 '.' to 188 ',' for id-ID 
    {
        var isFirefox = typeof InstallTrigger !== 'undefined';
        if (event.keyCode == 173 && isFirefox) {
            return true;
        }
        return false;
    }
    else {
        return true;
    }
}

function decFormat(val, digi, dec, len) {
    var iNum = parseInt(val);
    var decstr = '';
    if (len > 0) {
        var fDec = val - iNum;
        var iDec = parseInt(fDec * Math.pow(10, len));
        if (iDec > 0) {
            var decstr = iDec.toString();
            if (decstr.length > len) decstr = decstr.substr(0, len);
            //while (decstr.length < len)
            //    decstr = decstr + '0';
            decstr = dec + decstr;
        }
    }
    var num = iNum.toString();
    var numstr = '';
    while (num.length > 3) {
        numstr = digi + num.substr(num.length - 3, 3) + numstr;
        num = num.substr(0, num.length - 3);
    }
    numstr = num + numstr;
    return numstr + decstr;
}

function currzd(sign, txt, ribuan, cent, segment, event) {
    if (SpecialKey(event) && event.keyCode != 8) return;

    if (txt.value == '-')
        return;
    var Sign = '';
    if (txt.value.substr(0, 1) == '-') {
        Sign = '-';
        txt.value = txt.value.substr(1);
    }
    if (txt.value == '') {
        txt.value = Sign;
        return;
    }
    var fValue = parseFloat(clearValue(txt.value, ribuan, cent));
    var iStr = decFormat(fValue, ribuan, cent, 0); 
    var decstr = '';
    var idx = txt.value.indexOf(cent);
    if (idx > 0) {
        decstr = txt.value.substr(idx);
        if (decstr.length > segment)
            decstr = decstr.substr(0, segment);
    }
    txt.value = Sign + iStr + decstr;
}




function SpecialKeyDec() { 
	if (event.keyCode == 46 || event.keyCode == 8) return false;

	if (
		(event.keyCode < 28 && event.keyCode > 8) 
	) return true;
}
function decimalformat(txt, dec) {
	var length = txt.value.length, code; 
	if (dec == '.')
		code = (event.keyCode != 110 && event.keyCode != 190);
	else if (dec == ',')
		code = (event.keyCode != 188); 
	if (txt.value.indexOf(dec) != txt.value.lastIndexOf(dec)
		|| txt.value.indexOf(dec) == 0)
		txt.value = txt.value.substr(0, length - 1);

	if (txt.value.indexOf(dec) != -1)
		if (length - txt.value.indexOf(dec) > 3)
			txt.value = txt.value.substr(0, length - 1);
}



function clearValue(txt, digi, dec) {
    while (txt.indexOf(' ') != -1)
        txt = txt.replace(' ', '');
    while (txt.indexOf(digi) != -1)
        txt = txt.replace(digi, '');
    txt = txt.replace(dec, '.');
    if (txt == '')
        txt = '0';
    return txt;
}