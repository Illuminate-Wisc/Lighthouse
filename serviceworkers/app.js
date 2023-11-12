async function registerServiceWorker() {
    if (!("serviceWorker" in navigator)) {
        return;
    }

    try {
        const registration = await navigator.serviceWorker.register(
            "coi-sw.js"
        );

        if (registration.installing) {
            console.log("COI service worker installing");
            window.location.reload(); // Reload so the SW can intercept requests.
        } else if (registration.waiting) {
            console.log("COI service worker installed");
        } else if (registration.active) {
            console.log("COI service worker active");
        }
    } catch (error) {
        console.error(`Registration failed with ${error}`);
    }
}

registerServiceWorker();
