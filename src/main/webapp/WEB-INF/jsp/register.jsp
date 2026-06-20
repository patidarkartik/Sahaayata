<%--
    JSP page for Sahaayata - Registration form.
    Features: Tailwind CSS, JSON submission, Backend Integration.
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
                        primary: "#607AFB", // Sahaayata Blue
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
                },
            },
        };
    </script>
    <link href="https://fonts.googleapis.com" rel="preconnect" />
    <link crossorigin="" href="" rel="preconnect" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&amp;family=Montserrat:wght@400;500;700&amp;display=swap" rel="stylesheet" />
</head>

<body class="font-body bg-background-light dark:bg-background-dark text-foreground-light dark:text-foreground-dark">
<div class="min-h-screen flex flex-col items-center justify-center p-4">
    <a href="/" class="absolute top-6 left-6 md:top-8 md:left-8 flex items-center gap-2 text-sm font-medium hover:text-primary transition-colors">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 18l-6-6 6-6"/></svg>
        Back to Home
    </a>
    <div class="w-full max-w-md mt-12 md:mt-0">

        <div class="text-center mb-8">
            <a href="/" class="inline-block">
                <h1 class="font-display text-4xl font-bold text-primary hover:opacity-90 transition-opacity">
                    Sahaayata
                </h1>
            </a>
            <p class="text-muted-foreground-light dark:text-muted-foreground-dark mt-2">
                Create your account to start your fitness journey.
            </p>
        </div>

        <div class="bg-card-light dark:bg-card-dark p-8 rounded-xl shadow-lg">

            <form id="register-form" class="space-y-6" novalidate>

                <div>
                    <label class="block text-sm font-medium text-foreground-light dark:text-foreground-dark mb-2" for="username">Username</label>
                    <input class="form-input w-full px-4 py-3 rounded-lg bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark focus:ring-primary focus:border-primary placeholder:text-muted-foreground-light dark:placeholder:text-muted-foreground-dark"
                           id="username" name="username" type="text" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-foreground-light dark:text-foreground-dark mb-2" for="email">Email</label>
                    <input class="form-input w-full px-4 py-3 rounded-lg bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark focus:ring-primary focus:border-primary placeholder:text-muted-foreground-light dark:placeholder:text-muted-foreground-dark"
                           id="email" name="email" placeholder="you@example.com" type="email" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-foreground-light dark:text-foreground-dark mb-2" for="password">Password</label>
                    <input class="form-input w-full px-4 py-3 rounded-lg bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark focus:ring-primary focus:border-primary placeholder:text-muted-foreground-light dark:placeholder:text-muted-foreground-dark"
                           id="password" name="password" type="password" />
                </div>

                <div>
                    <button class="w-full bg-primary text-background-dark font-bold py-3 px-4 rounded-lg hover:bg-primary/90 transition-colors duration-300" type="submit">
                        Register
                    </button>
                </div>
            </form>

            <div id="form-status" class="mt-4 text-sm font-medium text-center" aria-live="polite"></div>

            <p class="mt-6 text-center text-sm text-muted-foreground-light dark:text-muted-foreground-dark">
                Already have an account?
                <a class="font-medium text-primary hover:underline" href="/login">Log in</a>
            </p>
        </div>
    </div>
</div>

<script>
    (function () {
        const form = document.getElementById('register-form');
        const statusEl = document.getElementById('form-status');
        if (!form) return;

        form.addEventListener('submit', async function (e) {
            e.preventDefault();

            // Clear previous messages
            if (statusEl) {
                statusEl.textContent = '';
                statusEl.className = 'mt-4 text-sm font-medium text-center';
            }

            const submitBtn = form.querySelector('button[type="submit"]');
            const originalBtnText = submitBtn ? submitBtn.textContent : '';

            // Disable button
            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.textContent = 'Registering...';
            }

            // Create Payload (Matches userCredential.java fields)
            const payload = {
                username: (document.getElementById('username') || {}).value?.trim() || '',
                email: (document.getElementById('email') || {}).value?.trim() || '',
                password: (document.getElementById('password') || {}).value || '',
            };

            // Basic Validation
            if (!payload.username || !payload.email || !payload.password) {
                if (statusEl) {
                    statusEl.className = 'mt-4 text-sm text-red-600 text-center';
                    statusEl.textContent = 'Please complete all fields.';
                }
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.textContent = originalBtnText;
                }
                return;
            }

            try {
                // Send Request to Backend
                const resp = await fetch('/register', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload),
                });

                // Handle Response
                if (resp.ok) {
                    // Success Case
                    if (statusEl) {
                        statusEl.className = 'mt-4 text-sm text-green-600 text-center';
                        statusEl.textContent = 'Registration successful! Redirecting to login...';
                    }
                    setTimeout(() => {
                        window.location.href = '/login';
                    }, 1500);
                } else {
                    // Error Case (e.g., Email already exists)
                    const err = await resp.json().catch(() => null);
                    const msg = (err && (err.message || err.error)) || 'Registration failed. Please try again.';
                    if (statusEl) {
                        statusEl.className = 'mt-4 text-sm text-red-600 text-center';
                        statusEl.textContent = msg;
                    }
                }
            } catch (networkErr) {
                if (statusEl) {
                    statusEl.className = 'mt-4 text-sm text-red-600 text-center';
                    statusEl.textContent = 'Network error. Please check your connection.';
                }
            } finally {
                // Re-enable button (unless success, then we redirect anyway)
                if (submitBtn && statusEl && !statusEl.classList.contains('text-green-600')) {
                    submitBtn.disabled = false;
                    submitBtn.textContent = originalBtnText;
                }
            }
        });
    })();
    window.addEventListener('pageshow', function(event) {
        var form = document.getElementById('register-form');
        if (form) {
            form.reset();
        }
    });
</script>
</body>
</html>