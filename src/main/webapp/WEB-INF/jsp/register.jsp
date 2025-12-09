<%--
    JSP page for Sahaayata - Registration form.
    This content is a direct conversion from register.html.
--%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Sahaayata - Register</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#607AFB",
                        "background-light": "#f5f6f8",
                        "background-dark": "#0f1323",
                        "foreground-light": "#111714",
                        "foreground-dark": "#f6f8f7",
                        "card-light": "#ffffff",
                        "card-dark": "#1a2e22",
                        "border-light": "#e0e7e3",
                        "border-dark": "#2a3f33",
                        "muted-foreground-light": "#648772",
                        "muted-foreground-dark": "#9abcb0",
                    },
                    fontFamily: {
                        display: "Work Sans",
                        body: ["Montserrat", "sans-serif"],
                    },
                    borderRadius: {
                        DEFAULT: "0.25rem",
                        lg: "0.5rem",
                        xl: "0.75rem",
                        full: "9999px",
                    },
                },
            },
        };
    </script>
    <link href="https://fonts.googleapis.com" rel="preconnect" />
    <link crossorigin="" href="" rel="preconnect" />
    <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&amp;family=Montserrat:wght@400;500;700&amp;display=swap"
            rel="stylesheet"
    />
</head>
<body
        class="font-body bg-background-light dark:bg-background-dark text-foreground-light dark:text-foreground-dark"
>
<div class="min-h-screen flex flex-col items-center justify-center p-4">
    <div class="w-full max-w-md">
        <div class="text-center mb-8">
            <h1 class="font-display text-4xl font-bold text-primary">
                Sahaayata
            </h1>
            <p
                    class="text-muted-foreground-light dark:text-muted-foreground-dark mt-2"
            >
                Create your account to start your fitness journey.
            </p>
        </div>
        <div class="bg-card-light dark:bg-card-dark p-8 rounded-xl shadow-lg">
            <form id="register-form" class="space-y-6" action="/register" method="POST" novalidate>
                <div>
                    <div>
                        <label
                                class="block text-sm font-medium text-foreground-light dark:text-foreground-dark mb-2"
                                for="username"
                        >Username</label
                        >
                        <input
                                class="form-input w-full px-4 py-3 rounded-lg bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark focus:ring-primary focus:border-primary placeholder:text-muted-foreground-light dark:placeholder:text-muted-foreground-dark"
                                id="username"
                                name="username"
                                placeholder=""
                                type="text"
                        />
                    </div>
                </div>
                <div>
                    <label
                            class="block text-sm font-medium text-foreground-light dark:text-foreground-dark mb-2"
                            for="email"
                    >Email</label
                    >
                    <input
                            class="form-input w-full px-4 py-3 rounded-lg bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark focus:ring-primary focus:border-primary placeholder:text-muted-foreground-light dark:placeholder:text-muted-foreground-dark"
                            id="email"
                            name="email"
                            placeholder="you@example.com"
                            type="email"
                    />
                </div>
                <div>
                    <label
                            class="block text-sm font-medium text-foreground-light dark:text-foreground-dark mb-2"
                            for="password"
                    >Password</label
                    >
                    <input
                            class="form-input w-full px-4 py-3 rounded-lg bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark focus:ring-primary focus:border-primary placeholder:text-muted-foreground-light dark:placeholder:text-muted-foreground-dark"
                            id="password"
                            name="password"
                            placeholder=""
                            type="password"
                    />
                </div>

                <div>
                    <button
                            class="w-full bg-primary text-background-dark font-bold py-3 px-4 rounded-lg hover:bg-primary/90 transition-colors duration-300"
                            type="submit"
                    >
                        Register
                    </button>
                </div>
            </form>
            <div id="form-status" class="mt-4 text-sm" aria-live="polite"></div>
            <p
                    class="mt-6 text-center text-sm text-muted-foreground-light dark:text-muted-foreground-dark"
            >
                Already have an account?
                <a class="font-medium text-primary hover:underline" href="/login"
                >Log in</a
                >
            </p>
        </div>
    </div>
</div>
</body>
<script>
    (function () {
        const form = document.getElementById('register-form');
        const statusEl = document.getElementById('form-status');
        if (!form) return;

        form.addEventListener('submit', async function (e) {
            e.preventDefault();
            if (statusEl) {
                statusEl.textContent = '';
                statusEl.className = 'mt-4 text-sm';
            }

            const submitBtn = form.querySelector('button[type="submit"]');
            const originalBtnText = submitBtn ? submitBtn.textContent : '';
            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.textContent = 'Registering...';
            }

            // ✅ ✅ ✅ FIX IS HERE (fullName → username)
            const payload = {
                username: (document.getElementById('username') || {}).value?.trim() || '',
                email: (document.getElementById('email') || {}).value?.trim() || '',
                password: (document.getElementById('password') || {}).value || '',
            };

            // Basic validation
            if (!payload.username || !payload.email || !payload.password) {
                if (statusEl) {
                    statusEl.className = 'mt-4 text-sm text-red-600';
                    statusEl.textContent = 'Please complete all fields.';
                }
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.textContent = originalBtnText;
                }
                return;
            }

            const headers = { 'Content-Type': 'application/json' };

            const csrfMeta = document.querySelector('meta[name="_csrf"]');
            const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
            if (csrfMeta) {
                const token = csrfMeta.getAttribute('content');
                const headerName = csrfHeaderMeta ? csrfHeaderMeta.getAttribute('content') : 'X-CSRF-TOKEN';
                if (token) headers[headerName] = token;
            }

            try {
                const resp = await fetch(form.action || '/register', {
                    method: 'POST',
                    headers,
                    body: JSON.stringify(payload),
                });

                if (resp.ok) {
                    const data = await resp.json().catch(() => null);
                    if (statusEl) {
                        statusEl.className = 'mt-4 text-sm text-green-600';
                        statusEl.textContent = (data && data.message) || 'Registration successful.';
                    }

                    setTimeout(() => {
                        window.location.href = '/login';
                    }, 1000);
                } else {
                    const err = await resp.json().catch(() => null);
                    const msg = (err && (err.message || err.error)) || 'Registration failed. Please try again.';
                    if (statusEl) {
                        statusEl.className = 'mt-4 text-sm text-red-600';
                        statusEl.textContent = msg;
                    }
                }
            } catch (networkErr) {
                if (statusEl) {
                    statusEl.className = 'mt-4 text-sm text-red-600';
                    statusEl.textContent = 'Network error. Please check your connection.';
                }
            } finally {
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.textContent = originalBtnText;
                }
            }
        });
    })();
</script>

</html>