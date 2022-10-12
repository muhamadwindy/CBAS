$(document).on("input", ".numeric", function () {
    this.value = this.value.replace(/[^\d]/g, '');
    //this.value = this.value.replace(/[^\d\.\-]/g, '');
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
    this.value = this.value.replace(/[^A-Za-z_\s\&]/g, '');
});
