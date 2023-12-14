document.addEventListener("DOMContentLoaded", function () {
    const nav = document.getElementById("site-navbar");

    nav.querySelector(".navbar-burger").addEventListener("click", () => {
        nav.querySelector(".navbar-burger").classList.toggle("opened");
        nav.querySelector(".navbar-links").classList.toggle("opened");
        nav.querySelector(".navbar-links").classList.contains("opened")
            ? nav.querySelector(".navbar-links").classList.add("animated")
            : setTimeout(
                  () =>
                      nav
                          .querySelector(".navbar-links")
                          .classList.remove("animated"),
                  300
              );
    });
});
