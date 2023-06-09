function verifyFieldsInvestor() {
    var genderM = document.getElementById("genderM");
    var genderF = document.getElementById("genderF");
    var genderO = document.getElementById("genderO");
    var firstname = document.getElementById("firstname").value;
    var lastname = document.getElementById("lastname").value;
    var email = document.getElementById("email").value;
    var birthdate = document.getElementById("birthdate").value;
    var acceptCGU = document.getElementById("cgu");
    var errorMessage = "";

    if (!genderM.checked && !genderF.checked && !genderO.checked) {
      errorMessage += "<li>Veuillez sélectionner un genre.</li>";
    }

    if (!firstname.match(/^[a-zàâçéèêëîïôûùüÿñæœ .-]{2,60}$/i)) {
        document.getElementById("firstname").style.border = "2px solid red";
        errorMessage += "<li>Prénom invalide.</li>";
    } else {
        document.getElementById("firstname").style.border = "2px solid green";
    }

    if (!lastname.match(/^[a-zàâçéèêëîïôûùüÿñæœ .-]{2,60}$/i)) {
        document.getElementById("lastname").style.border = "2px solid red";
        errorMessage += "<li>Nom invalide.</li>";
    } else {
        document.getElementById("lastname").style.border = "2px solid green";
    }

    if (!email.match(/^[a-z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$/i)) {
        document.getElementById("email").style.border = "2px solid red";
        errorMessage += "<li>Email invalide.</li>";
    } else {
        document.getElementById("email").style.border = "2px solid green";
    }

    if (!birthdate.match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/i)) {
        document.getElementById("birthdate").style.border = "2px solid red";
        errorMessage += "<li>Date de naissance invalide.</li>";
    } else {
        document.getElementById("birthdate").style.border = "2px solid green";
    }

    if (!acceptCGU.checked) {
        errorMessage += "<li>Veuillez accepter les CGU.</li>";
        acceptCGU.classList.add("error");
    } else {
        acceptCGU.classList.add("success");
    }
        
    var submitButton = document.getElementById("submit");
    var cardFooter = document.getElementById("card-footer");

    if (errorMessage !== "") {
        cardFooter.innerHTML = "<ul>" + errorMessage + "</ul>";
        submitButton.disabled = true;
    } else {
        cardFooter.innerHTML = "";
        submitButton.disabled = false;
    }
}




function nextStep(currentStep, nextStep) {
    var currentStepElement = document.querySelector('.' + currentStep);
    var nextStepElement = document.querySelector('.' + nextStep);
    var progressBar = document.querySelector('.progress-bar');

    currentStepElement.classList.add('slide-left');
    setTimeout(function () {
        currentStepElement.style.display = "none";
        nextStepElement.style.display = "block";
        nextStepElement.classList.add('slide-from-left');
    }, 500);

    progressBar.style.width = (parseInt(progressBar.style.width) + 33) + "%";
}

function previousStep(currentStep, previousStep) {
    var currentStepElement = document.querySelector('.' + currentStep);
    var previousStepElement = document.querySelector('.' + previousStep);
    var progressBar = document.querySelector('.progress-bar');


    currentStepElement.classList.add('slide-right');
    setTimeout(function () {
        currentStepElement.style.display = "none";
        previousStepElement.style.display = "block";
        previousStepElement.classList.add('slide-from-right');
    }, 500);

    progressBar.style.width = (parseInt(progressBar.style.width) - 33) + "%";
    if (progressBar.style.width == "0%") {
        progressBar.style.width = "33%";
    }
}