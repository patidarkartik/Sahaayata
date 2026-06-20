<%--
    JSP page for Sahaayata - Login form.
    Fixed: JSON submit, error/success messages, redirect, form ID.
--%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Sahaayata - Login</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <link href="https://fonts.googleapis.com" rel="preconnect" />
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
    <link
            href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap"
            rel="stylesheet"
    />
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#607AFB",
                        "background-light": "#f5f6f8",
                        "background-dark": "#0f1323",
                        "foreground-light": "#112117",
                        "foreground-dark": "#f6f8f7",
                        "subtle-light": "#e3e8e5",
                        "subtle-dark": "#2a3f34",
                        "muted-light": "#6b8277",
                        "muted-dark": "#8a9f94",
                    },
                    fontFamily: { display: "Work Sans" },
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
    <style>
        .form-input {
            --tw-ring-offset-shadow: 0 0 #0000;
            --tw-ring-shadow: 0 0 #0000;
            --tw-shadow: 0 0 #0000;
            --tw-shadow-colored: 0 0 #0000;
            outline: 2px solid transparent;
            outline-offset: 2px;
            border-width: 1px;
        }
        .form-input:focus,
        .form-input:focus-within {
            border-color: #20df6c;
            box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
            var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
            --tw-ring-color: #20df6c;
            --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0
            var(--tw-ring-offset-width) var(--tw-ring-offset-color);
            --tw-ring-shadow: var(--tw-ring-inset) 0 0 0
            calc(1px + var(--tw-ring-offset-width)) var(--tw-ring-color);
            box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow),
            var(--tw-shadow, 0 0 #0000);
        }
    </style>
</head>
<body
        class="bg-background-light dark:bg-background-dark font-display text-foreground-light dark:text-foreground-dark"
>
<div class="flex flex-col min-h-screen">
    <header
            class="absolute top-0 left-0 right-0 z-10 p-6 md:px-12 md:py-6 flex items-center justify-between"
    >
        <a class="flex items-center gap-3" href="/">
            <svg
                    class="h-8 w-8 text-primary"
                    fill="currentColor"
                    viewbox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
            >
                <path
                        clip-rule="evenodd"
                        d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM16.6 14.79L13.88 12.07L13.88 7.3H12V12.72L15.19 15.91L16.6 14.79Z"
                        fill-rule="evenodd"
                ></path>
            </svg>
            <span
                    class="text-2xl font-bold text-foreground-light dark:text-foreground-dark"
            >Sahaayata</span
            >
        </a>
        <div class="flex items-center gap-4">
            <a class="text-sm font-medium hover:text-primary transition-colors" href="/">Home</a>
            <a
                    class="px-6 py-2 text-sm font-semibold rounded-full bg-primary text-background-dark hover:bg-primary/90 transition-colors"
                    href="/register"
            >
                Sign Up
            </a>
        </div>
    </header>
    <main class="flex-grow flex items-center justify-center px-4 py-20">
        <div
                class="w-full max-w-md p-8 md:p-12 space-y-8 bg-background-light dark:bg-background-dark border border-subtle-light dark:border-subtle-dark rounded-xl shadow-lg"
        >
            <div class="text-center">
                <h1 class="text-3xl md:text-4xl font-bold tracking-tight">
                    Welcome Back
                </h1>
                <p class="mt-3 text-muted-light dark:text-muted-dark">
                    Log in to continue your fitness journey.
                </p>
            </div>

            <!-- ✅ Added ID for JS -->
            <form id="login-form" class="space-y-6">

                <div>
                    <label
                            class="text-sm font-medium text-foreground-light dark:text-foreground-dark"
                            for="email"
                    >Email Address</label
                    >
                    <input
                            autocomplete="email"
                            class="form-input mt-2 block w-full px-4 py-3 bg-subtle-light dark:bg-subtle-dark border-subtle-light dark:border-subtle-dark rounded-lg text-foreground-light dark:text-foreground-dark placeholder-muted-light dark:placeholder-muted-dark focus:outline-none focus:ring-primary focus:border-primary"
                            id="email"
                            name="email"
                            placeholder="you@example.com"
                            required=""
                            type="email"
                    />
                </div>
                <div>
                    <div class="flex items-center justify-between">
                        <label
                                class="text-sm font-medium text-foreground-light dark:text-foreground-dark"
                                for="password"
                        >Password</label
                        >
                        <a
                                class="text-sm font-medium text-primary hover:underline"
                                href="#"
                        >Forgot password?</a
                        >
                    </div>
                    <input
                            autocomplete="current-password"
                            class="form-input mt-2 block w-full px-4 py-3 bg-subtle-light dark:bg-subtle-dark border-subtle-light dark:border-subtle-dark rounded-lg text-foreground-light dark:text-foreground-dark placeholder-muted-light dark:placeholder-muted-dark focus:outline-none focus:ring-primary focus:border-primary"
                            id="password"
                            name="password"
                            placeholder=""
                            required=""
                            type="password"
                    />
                </div>
                <div>
                    <button
                            class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-base font-semibold text-background-dark bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary focus:ring-offset-background-light dark:focus:ring-offset-background-dark transition-colors"
                            type="submit"
                    >
                        Login
                    </button>
                </div>
            </form>

            <!-- ✅ Added for JS status messages -->
            <div id="form-status" class="mt-4 text-center text-sm"></div>

            <p class="text-center text-sm text-muted-light dark:text-muted-dark">
                Don't have an account?
                <a class="font-semibold text-primary hover:underline" href="/register"
                >Register now</a
                >
            </p>
        </div>
    </main>
</div>

<!-- ✅ ✅ JS: send JSON to backend, display messages, redirect -->
<script>
    (function () {
        const form = document.getElementById('login-form');
        const statusEl = document.getElementById('form-status');
        if (!form) return;

        form.addEventListener('submit', async function (e) {
            e.preventDefault();

            const payload = {
                email: document.getElementById('email').value.trim(),
                password: document.getElementById('password').value
            };

            if (!payload.email || !payload.password) {
                statusEl.className = 'mt-4 text-center text-sm text-red-600';
                statusEl.textContent = 'Email and password required.';
                return;
            }

            try {
                const resp = await fetch('/login', {
                    method: 'POST',
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(payload)
                });

                if (resp.ok) {
                    statusEl.className = 'mt-4 text-center text-sm text-green-600';
                    statusEl.textContent = 'Login successful!';
                    setTimeout(() => window.location.href = '/dashboard', 1000);
                } else {
                    const err = await resp.text();
                    statusEl.className = 'mt-4 text-center text-sm text-red-600';
                    statusEl.textContent = err || 'Invalid login credentials.';
                }
            } catch (e) {
                statusEl.className = 'mt-4 text-center text-sm text-red-600';
                statusEl.textContent = 'Server error. Try again.';
            }
        });
    })();
    window.addEventListener('pageshow', function(event) {
        var form = document.getElementById('login-form');
        if (form) {
            form.reset(); // Saare fields empty kar dega
        }
    });
</script>
</body>
</html>
