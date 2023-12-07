// Javascript pour faire allumé mon bouton


  // Variable pour définir l'état de mon bouton
  let estLike = false;
  //Fonction pour gérer le clic sur le bouton
  function gererLike () {
    const bouton = document.getElementById('boutonLike');

  if (!estLike) {
    //Si le bouton n'est pas liké, effectue l'action de liker
    bouton.innerHTML = "Unlike";
    //Ajoute d'autres actions pour "liker"
    estLike = true
  } else {
    //Si le bouton est déjà liké, effectue l'acion de unliker
    bouton.innerHTML = 'Like';
    //Ajoute d'autres action pour le "unliker"
    estLike = false
  }
}
