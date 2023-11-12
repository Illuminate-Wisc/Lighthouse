self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (e) => e.waitUntil(self.clients.claim()));

self.addEventListener("fetch", (e) => {
    const request = e.request;

    if (
        request.cache === "only-if-cached" && request.mode !== "same-origin"
    ) {
        return; // Request to another origin; drop request.
    }

    e.respondWith(
        fetch(request)
            .then((response) => {
                if (response.status === 0) {
                    return response; // Illegal cross-origin request
                }

                const coHeaders = new Headers(response.headers);

                coHeaders.set("Cross-Origin-Embedder-Policy", "require-corp");
                coHeaders.set("Cross-Origin-Opener-Policy", "same-origin");

                return new Response(response.body, {
                    status: response.status,
                    statusText: response.statusText,
                    headers: coHeaders
                });
            })
            .catch((e) => console.error(e))
    );
});
