// Javascript pour faire allumer mon bouton

document.addEventListener("DOMContentLoaded", function () {
    // Récupération des boutons
    var likeButtons = document.querySelectorAll("like-btn");

    // Ajout d'un écouteur d'évènement sur chaque bouton
    likeButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            // Ajout de l'animation CSS sur le bouton
            button.classList.toggle("active");
        });
    });
});
