document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".alert .close").forEach((btn) => {
        btn.addEventListener("click", (event) => {
            event.preventDefault();
            event.target.closest(".alert").classList.add("fade-out");
            setTimeout(() => {
                event.target.closest(".alert").remove();
            }, 250);
        });
    });
});
