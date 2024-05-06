//Allow only Numbers and Letters
function allowOnlyLettersandnum(e, t) {
    if (window.event) {
        var charCode = window.event.keyCode;
    }
    else if (e) {
        var charCode = e.which;
    }
    else { return true; }
    if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 32 || (charCode > 47 && charCode < 58))
        return true;
    else {
        return false;
    }
}

//Allow only Numbers and Letters and specil ('(,),-')
function allowOnlyLettersandnumspl(e, t) {
    if (window.event) {
        var charCode = window.event.keyCode;
    }
    else if (e) {
        var charCode = e.which;
    }
    else { return true; }
    if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 32 || (charCode > 47 && charCode < 58) || charCode == 40 || charCode == 41 || charCode == 45)
        return true;
    else {
        return false;
    }
}

//Allow only Letters
function allowOnlyLetters(e, t) {
    if (window.event) {
        var charCode = window.event.keyCode;
    }
    else if (e) {
        var charCode = e.which;
    }
    else { return true; }
    if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 32 || charCode == 39)
        return true;
    else {
        return false;
    }
}

//Allow only Numbers 
function allowonlynumbers(m, n) {
    if (window.event) {
        var phn = window.event.keyCode;
    }
    else if (m) {
        var phn = m.which;
    }
    else { return true; }
    if (phn > 47 && phn < 58)
        return true;
    else {
        return false;
    }
}

//Using MaxLength with TextMode="Number"
function validateNumericInput(inputElement) {
    var inputValue = inputElement.value;
    var maxLength = parseInt(inputElement.maxLength);

    if (inputValue.length > maxLength) {
        inputElement.value = inputValue.slice(0, maxLength);
    }
}

//Accept Only Number 1,2,3 and 4
function validateInput(inputElement) {
    var inputValue = inputElement.value;

    var regex = /^[1-4]*$/;

    if (!regex.test(inputValue)) {
        inputElement.value = '';
    }
}

