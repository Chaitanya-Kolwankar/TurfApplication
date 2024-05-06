const sun = "img/sun.svg";
const moon = "img/moon.svg"

const container = document.getElementsByClassName("theme-container")[0];
const themeIcon = document.getElementById("theme-icon");
container.addEventListener("click", setTheme);

// Set initial value to "dark"
container.dataset.setting = "color-mode";
container.dataset.name = "color";
container.dataset.value = "dark";

function setTheme() {
    switch (container.dataset.value) {
        case "dark":
            setLight();
            container.dataset.value = "light";
            break;
        case "light":
            setDark();
            container.dataset.value = "dark";
            break;
    }
}

function setLight() {
    container.classList.remove("shadow-dark");
    setTimeout(() => {
        container.classList.add("shadow-light");
        themeIcon.classList.remove("change");
    }, 300);
    themeIcon.classList.add("change");
    themeIcon.src = sun;
}

function setDark() {
    container.classList.remove("shadow-light");
    setTimeout(() => {
        container.classList.add("shadow-dark");
        themeIcon.classList.remove("change");
    }, 300);
    themeIcon.classList.add("change");
    themeIcon.src = moon;
}