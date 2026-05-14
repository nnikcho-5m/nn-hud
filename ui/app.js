window.addEventListener("message", function(event) {
    const data = event.data;

    if (data.action !== "updateHud") return;

    const mainHUD = document.getElementById("mainHUD");
    if (mainHUD && data.hudLoaded) {
        mainHUD.style.display = "block";
    }

     const carhud = document.getElementById("carHUD");
    const helihud = document.getElementById("heliHUD");

    const heliSpeed = document.getElementById("heli-speed");
    if (heliSpeed) heliSpeed.innerText = data.speed;

    const heliAltitude = document.getElementById("heli-altitude");
    if (heliAltitude) heliAltitude.innerText = data.altitude;

    const heliHeading = document.getElementById("heli-heading");
    if (heliHeading) heliHeading.innerText = data.heading;

    if (data.showCarHud) {

        if (data.isHeli) {

            if (helihud) helihud.style.display = "block";
            if (carhud) carhud.style.display = "none";

        } else {

            if (carhud) carhud.style.display = "block";
            if (helihud) helihud.style.display = "none";

        }

    } else {

        if (carhud) carhud.style.display = "none";
        if (helihud) helihud.style.display = "none";

    }

    const speed = document.getElementById("speed");
    if (speed) speed.innerText = data.speed;

    const gear = document.getElementById("gear");
    if (gear) gear.textContent = data.gear;

    const rpmBar = document.getElementById("rpm-bar");
    if (rpmBar) rpmBar.style.width = data.rpm + "%";

    const fuel = document.getElementById("fuel");
    if (fuel) fuel.style.width = data.fuel + "%";

    const fuelHeli = this.document.getElementById("fuelHeli");
    if (fuelHeli) fuelHeli.style.width = data.fuelHeli + "%";

    const healthBar = document.getElementById("health-bar");
    if (healthBar) healthBar.style.width = data.health + "%";

    const armorBar = document.getElementById("armor-bar");
    if (armorBar) armorBar.style.width = data.armor + "%";

    const hungerBar = document.getElementById("hunger-bar");
    if (hungerBar) hungerBar.style.height = data.hunger + "%";

    const waterBar = document.getElementById("water-bar");
    if (waterBar) waterBar.style.height = data.water + "%";

    const staminaBar = document.getElementById("stamina-bar");
    if (staminaBar) staminaBar.style.height = (100 - data.stamina) + "%";

    const micBar = document.getElementById("mic-bar");
    const micIcon = document.getElementById("mic-icon");

    if (micBar) micBar.style.height = data.voice + "%";

    if (data.voiceMode === 1 || data.voiceMode === 2 || data.voiceMode === 3) {
        if (micBar) micBar.style.background = "#4a7fa5";
    }

    if (data.talking) {
        if (micBar) micBar.style.background = "#37678a";
    }

    const seatbelt = document.getElementById("seatbelt");

    if (seatbelt) {
        seatbelt.style.color = data.seatbelt ? "red" : "white";
    }
});