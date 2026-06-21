<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Login | Sahaayata</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=DM+Sans:wght@600;700&display=swap" rel="stylesheet"/>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "background": "#faf8ff",
                        "on-tertiary-fixed": "#311400",
                        "on-secondary-container": "#00714d",
                        "surface-variant": "#dae2fd",
                        "on-error-container": "#93000a",
                        "tertiary": "#924700",
                        "error": "#ba1a1a",
                        "on-primary": "#ffffff",
                        "on-tertiary-container": "#fffbff",
                        "inverse-primary": "#adc6ff",
                        "primary-fixed-dim": "#adc6ff",
                        "primary": "#0058be",
                        "surface-container-low": "#f2f3ff",
                        "on-primary-fixed": "#001a42",
                        "surface-container-lowest": "#ffffff",
                        "surface-container-high": "#e2e7ff",
                        "secondary-container": "#6cf8bb",
                        "primary-fixed": "#d8e2ff",
                        "tertiary-fixed-dim": "#ffb786",
                        "error-container": "#ffdad6",
                        "on-tertiary": "#ffffff",
                        "outline": "#727785",
                        "on-secondary-fixed": "#002113",
                        "on-secondary-fixed-variant": "#005236",
                        "secondary": "#006c49",
                        "on-tertiary-fixed-variant": "#723600",
                        "on-primary-fixed-variant": "#004395",
                        "tertiary-fixed": "#ffdcc6",
                        "primary-container": "#2170e4",
                        "surface": "#faf8ff",
                        "on-secondary": "#ffffff",
                        "on-background": "#131b2e",
                        "on-primary-container": "#fefcff",
                        "surface-dim": "#d2d9f4",
                        "surface-container": "#eaedff",
                        "outline-variant": "#c2c6d6",
                        "tertiary-container": "#b75b00",
                        "on-surface-variant": "#424754",
                        "surface-container-highest": "#dae2fd",
                        "on-surface": "#131b2e",
                        "inverse-on-surface": "#eef0ff",
                        "surface-tint": "#005ac2",
                        "secondary-fixed-dim": "#4edea3",
                        "surface-bright": "#faf8ff",
                        "secondary-fixed": "#6ffbbe",
                        "on-error": "#ffffff",
                        "inverse-surface": "#283044"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "2xl": "1rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "section-padding-sm": "64px",
                        "section-padding-lg": "120px",
                        "container-max": "1280px",
                        "stack-gap": "16px",
                        "gutter": "24px"
                    },
                    "fontFamily": {
                        "body-lg": ["Inter"],
                        "headline-md": ["DM Sans"],
                        "display-lg-mobile": ["DM Sans"],
                        "display-lg": ["DM Sans"],
                        "label-sm": ["Inter"],
                        "body-md": ["Inter"]
                    },
                    "fontSize": {
                        "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}],
                        "headline-md": ["32px", {"lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                        "display-lg-mobile": ["40px", {"lineHeight": "48px", "letterSpacing": "-0.01em", "fontWeight": "700"}],
                        "display-lg": ["64px", {"lineHeight": "72px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "label-sm": ["14px", {"lineHeight": "20px", "letterSpacing": "0.02em", "fontWeight": "600"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}]
                    }
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            display: inline-block;
            vertical-align: middle;
        }
        .ai-gradient-bg {
            background: linear-gradient(135deg, #0058be 0%, #006c49 100%);
        }
        .ai-gradient-text {
            background: linear-gradient(135deg, #0058be 0%, #006c49 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .ambient-shadow {
            box-shadow: 0px 4px 20px rgba(15, 23, 42, 0.05);
        }
        .ambient-shadow-hover:hover {
            box-shadow: 0px 12px 32px rgba(15, 23, 42, 0.08);
        }
    </style>
</head>
<body class="bg-background text-on-background font-body-md min-h-screen flex flex-col">
<!-- Top Navigation (Shell Supression applied for focused journey) -->
<header class="fixed top-0 w-full z-50 bg-background/80 backdrop-blur-md px-gutter h-16 flex items-center justify-between border-b border-outline-variant/30">
    <div class="max-w-container-max mx-auto w-full flex items-center justify-between">
        <a class="flex items-center gap-0 group transition-transform duration-300 hover:scale-105" href="/">
            <img src="/images/logo.svg" alt="Sahaayata Logo" class="h-20 w-auto object-contain">
            <span class="text-3xl font-headline-md font-bold text-primary tracking-tight -ml-2 ai-gradient-text">Sahaayata</span>
        </a>
        <a class="flex items-center gap-1 sm:gap-2 text-on-surface-variant hover:text-primary transition-colors font-label-sm text-[11px] sm:text-sm whitespace-nowrap shrink-0" href="/">
            <span class="material-symbols-outlined text-base sm:text-lg">arrow_back</span>
            <span class="hidden sm:inline">Back to Home</span>
            <span class="sm:hidden">Back</span>
        </a>
    </div>
</header>

<!-- Main Content Area -->
<main class="flex-grow flex items-center justify-center pt-20 pb-6 px-gutter relative overflow-hidden">
    <!-- Ambient Decorative Background Elements -->
    <div class="absolute top-1/4 -left-20 w-96 h-96 bg-primary/5 rounded-full blur-[100px]"></div>
    <div class="absolute bottom-1/4 -right-20 w-96 h-96 bg-secondary/5 rounded-full blur-[100px]"></div>
    
    <div class="w-full max-w-md z-10">
        <!-- Header Text -->
        <div class="text-center mb-5">
            <h1 class="font-display-lg text-3xl text-on-surface mb-2" id="formHeading">
                Welcome <span class="ai-gradient-text">Back</span>
            </h1>
            <p class="font-body-md text-sm text-on-surface-variant" id="formSubHeading">
                Log in to continue your fitness journey today.
            </p>
        </div>
        
        <!-- Login Card -->
        <div class="bg-surface-container-lowest p-5 md:p-6 rounded-2xl ambient-shadow border border-outline-variant/20">
            <form class="flex flex-col gap-4" id="loginForm">
                
                <!-- Email Field -->
                <div class="flex flex-col gap-1">
                    <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="email">
                        <span class="material-symbols-outlined text-sm">mail</span>
                        Email Address
                    </label>
                    <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="email" name="email" placeholder="you@example.com" required="" type="email"/>
                </div>
                
                <!-- Password Field -->
                <div class="flex flex-col gap-1">
                    <div class="flex items-center justify-between">
                        <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="password">
                            <span class="material-symbols-outlined text-sm">lock</span>
                            Password
                        </label>
                        <a class="text-xs font-medium text-primary hover:underline" href="javascript:void(0)" id="showForgotBtn">Forgot password?</a>
                    </div>
                    <div class="relative">
                        <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="password" name="password" placeholder="••••••••" required="" type="password"/>
                        <button class="absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant hover:text-primary transition-colors" type="button" id="togglePasswordBtn">
                            <span class="material-symbols-outlined">visibility</span>
                        </button>
                    </div>
                </div>

                <div id="form-status" class="hidden text-sm font-medium text-center" aria-live="polite"></div>

                <!-- Login Button -->
                <button class="mt-2 ai-gradient-bg text-on-primary font-label-sm text-label-sm py-2.5 rounded-xl ambient-shadow ambient-shadow-hover active:scale-[0.98] transition-all flex items-center justify-center gap-2 group" type="submit">
                    <span>Login</span>
                    <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
                </button>
            </form>

            <!-- Forgot Password Form -->
            <form class="flex flex-col gap-4 hidden" id="forgotPasswordForm">
                <div class="flex flex-col gap-1" id="emailGroup">
                    <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="resetEmail">
                        <span class="material-symbols-outlined text-sm">mail</span>
                        Registered Email
                    </label>
                    <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="resetEmail" name="email" placeholder="you@example.com" required="" type="email"/>
                </div>
                
                <div class="flex flex-col gap-1 hidden" id="otpGroup">
                    <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="resetOtp">
                        <span class="material-symbols-outlined text-sm">pin</span>
                        6-Digit OTP
                    </label>
                    <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md tracking-widest text-center" id="resetOtp" name="otp" placeholder="123456" type="text" maxlength="6"/>
                </div>

                <div class="flex flex-col gap-1 hidden" id="newPassGroup">
                    <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="newPassword">
                        <span class="material-symbols-outlined text-sm">lock_reset</span>
                        New Password
                    </label>
                    <div class="relative">
                        <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="newPassword" name="newPassword" placeholder="Minimum 8 characters" type="password"/>
                    </div>
                </div>

                <div id="forgot-status" class="hidden text-sm font-medium text-center" aria-live="polite"></div>

                <button class="mt-2 ai-gradient-bg text-on-primary font-label-sm text-label-sm py-2.5 rounded-xl ambient-shadow ambient-shadow-hover active:scale-[0.98] transition-all flex items-center justify-center gap-2 group" type="button" id="sendOtpBtn">
                    <span>Send OTP</span>
                    <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">send</span>
                </button>

                <button class="mt-2 ai-gradient-bg text-on-primary font-label-sm text-label-sm py-2.5 rounded-xl ambient-shadow ambient-shadow-hover active:scale-[0.98] transition-all flex items-center justify-center gap-2 group hidden" type="submit" id="resetPassBtn">
                    <span>Reset Password</span>
                    <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">check_circle</span>
                </button>

                <div class="text-center mt-1">
                    <button type="button" id="backToLoginBtn" class="text-xs font-medium text-on-surface-variant hover:text-primary transition-colors">
                        &larr; Back to Login
                    </button>
                </div>
            </form>
            
            <!-- Register Link -->
            <div class="mt-5 pt-5 border-t border-outline-variant/30 text-center">
                <p class="font-body-md text-sm text-on-surface-variant">
                    Don't have an account? <a class="text-primary font-bold hover:underline" href="/register">Register now</a>
                </p>
            </div>
        </div>
    </div>
</main>

<!-- Simple Footer -->
<footer class="w-full py-4 bg-surface-container-lowest border-t border-outline-variant/30 mt-auto">
    <div class="max-w-container-max mx-auto px-gutter flex flex-col md:flex-row justify-between items-center gap-4 text-on-surface-variant font-label-sm text-label-sm">
        <span>© 2024 Sahaayata. All rights reserved.</span>
    </div>
</footer>

<script>
    // Micro-interaction for password visibility
    const togglePassword = document.getElementById('togglePasswordBtn');
    const passwordInput = document.getElementById('password');
    
    if (togglePassword && passwordInput) {
        const icon = togglePassword.querySelector('.material-symbols-outlined');
        togglePassword.addEventListener('click', () => {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            if (icon) {
                icon.textContent = type === 'password' ? 'visibility' : 'visibility_off';
            }
        });
    }

    // Form submission animation and actual backend integration
    const form = document.getElementById('loginForm');
    const statusEl = document.getElementById('form-status');

    if (form) {
        form.addEventListener('submit', async function (e) {
            e.preventDefault();
            
            if (statusEl) {
                statusEl.textContent = '';
                statusEl.className = 'hidden';
            }

            const submitBtn = form.querySelector('button[type="submit"]');
            const originalBtnHtml = submitBtn ? submitBtn.innerHTML : '';

            // Disable button
            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.innerHTML = `<span class="animate-spin material-symbols-outlined">sync</span> <span>Logging in...</span>`;
                submitBtn.classList.add('opacity-80');
            }

            const payload = {
                email: (document.getElementById('email') || {}).value?.trim() || '',
                password: (document.getElementById('password') || {}).value || '',
            };

            if (!payload.email || !payload.password) {
                if (statusEl) {
                    statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                    statusEl.textContent = 'Email and password required.';
                }
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalBtnHtml;
                    submitBtn.classList.remove('opacity-80');
                }
                return;
            }

            try {
                // Send Request to Backend
                const resp = await fetch('/login', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload),
                });

                // Handle Response
                if (resp.ok) {
                    const data = await resp.json();
                    if (statusEl) {
                        statusEl.className = 'mt-2 text-sm text-green-600 text-center block';
                        statusEl.textContent = 'Login successful! Redirecting...';
                    }
                    setTimeout(() => {
                        window.location.href = data.redirectUrl || '/dashboard';
                    }, 1000);
                } else {
                    // Error Case
                    const err = await resp.json().catch(() => ({}));
                    const msg = err.message || 'Invalid login credentials.';
                    if (statusEl) {
                        statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                        statusEl.textContent = msg;
                    }
                    if (submitBtn) {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = originalBtnHtml;
                        submitBtn.classList.remove('opacity-80');
                    }
                }
            } catch (networkErr) {
                if (statusEl) {
                    statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                    statusEl.textContent = 'Server error. Try again.';
                }
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalBtnHtml;
                    submitBtn.classList.remove('opacity-80');
                }
            }
        });
        
        window.addEventListener('pageshow', function(event) {
            form.reset();
            if(document.getElementById('forgotPasswordForm')) {
                document.getElementById('forgotPasswordForm').reset();
            }
        });
    }

    // Forgot Password Toggle & Submission Logic
    const showForgotBtn = document.getElementById('showForgotBtn');
    const backToLoginBtn = document.getElementById('backToLoginBtn');
    const forgotForm = document.getElementById('forgotPasswordForm');
    const formHeading = document.getElementById('formHeading');
    const formSubHeading = document.getElementById('formSubHeading');
    const registerLinkContainer = document.querySelector('.mt-5.pt-5.border-t');

    if (showForgotBtn && backToLoginBtn && forgotForm && form) {
        showForgotBtn.addEventListener('click', (e) => {
            e.preventDefault();
            form.classList.add('hidden');
            registerLinkContainer.classList.add('hidden');
            forgotForm.classList.remove('hidden');
            formHeading.innerHTML = 'Reset <span class="ai-gradient-text">Password</span>';
            formSubHeading.textContent = 'Enter your email to receive an OTP.';
            if(statusEl) statusEl.className = 'hidden';
            
            // Reset to step 1
            document.getElementById('emailGroup').classList.remove('hidden');
            document.getElementById('resetEmail').disabled = false;
            document.getElementById('otpGroup').classList.add('hidden');
            document.getElementById('newPassGroup').classList.add('hidden');
            document.getElementById('sendOtpBtn').classList.remove('hidden');
            document.getElementById('resetPassBtn').classList.add('hidden');
            document.getElementById('resetOtp').removeAttribute('required');
            document.getElementById('newPassword').removeAttribute('required');
        });

        backToLoginBtn.addEventListener('click', (e) => {
            e.preventDefault();
            forgotForm.classList.add('hidden');
            form.classList.remove('hidden');
            registerLinkContainer.classList.remove('hidden');
            formHeading.innerHTML = 'Welcome <span class="ai-gradient-text">Back</span>';
            formSubHeading.textContent = 'Log in to continue your fitness journey today.';
            const forgotStatus = document.getElementById('forgot-status');
            if(forgotStatus) forgotStatus.className = 'hidden';
        });

        const sendOtpBtn = document.getElementById('sendOtpBtn');
        const resetPassBtn = document.getElementById('resetPassBtn');
        const fStatusEl = document.getElementById('forgot-status');

        sendOtpBtn.addEventListener('click', async function () {
            const email = document.getElementById('resetEmail').value.trim();
            if (!email) {
                fStatusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                fStatusEl.textContent = 'Please enter your registered email.';
                return;
            }

            const originalBtnHtml = sendOtpBtn.innerHTML;
            sendOtpBtn.disabled = true;
            sendOtpBtn.innerHTML = `<span class="animate-spin material-symbols-outlined">sync</span> <span>Sending OTP...</span>`;
            
            try {
                const resp = await fetch('/forgot-password/send-otp', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ email })
                });

                if (resp.ok) {
                    fStatusEl.className = 'mt-2 text-sm text-green-600 text-center block';
                    fStatusEl.textContent = 'OTP sent! Please check your inbox.';
                    
                    document.getElementById('emailGroup').classList.add('hidden');
                    document.getElementById('otpGroup').classList.remove('hidden');
                    document.getElementById('newPassGroup').classList.remove('hidden');
                    sendOtpBtn.classList.add('hidden');
                    resetPassBtn.classList.remove('hidden');
                    
                    document.getElementById('resetOtp').setAttribute('required', 'true');
                    document.getElementById('newPassword').setAttribute('required', 'true');
                    formSubHeading.textContent = 'Enter the OTP and your new password.';
                } else {
                    const err = await resp.json().catch(() => ({}));
                    fStatusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                    fStatusEl.textContent = err.message || 'Failed to send OTP.';
                }
            } catch (networkErr) {
                fStatusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                fStatusEl.textContent = 'Network error. Please try again.';
            } finally {
                sendOtpBtn.disabled = false;
                sendOtpBtn.innerHTML = originalBtnHtml;
            }
        });

        forgotForm.addEventListener('submit', async function (e) {
            e.preventDefault();
            fStatusEl.textContent = '';
            fStatusEl.className = 'hidden';

            const originalBtnHtml = resetPassBtn.innerHTML;
            resetPassBtn.disabled = true;
            resetPassBtn.innerHTML = `<span class="animate-spin material-symbols-outlined">sync</span> <span>Resetting...</span>`;
            resetPassBtn.classList.add('opacity-80');

            const payload = {
                email: document.getElementById('resetEmail').value.trim(),
                otp: document.getElementById('resetOtp').value.trim(),
                newPassword: document.getElementById('newPassword').value
            };

            try {
                const resp = await fetch('/forgot-password', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload),
                });

                if (resp.ok) {
                    fStatusEl.className = 'mt-2 text-sm text-green-600 text-center block';
                    fStatusEl.textContent = 'Password reset successfully! Returning to login...';
                    setTimeout(() => {
                        backToLoginBtn.click();
                        forgotForm.reset();
                    }, 2000);
                } else {
                    const err = await resp.json().catch(() => ({}));
                    fStatusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                    fStatusEl.textContent = err.message || 'Failed to reset password.';
                }
            } catch (networkErr) {
                fStatusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                fStatusEl.textContent = 'Network error. Please try again.';
            } finally {
                resetPassBtn.disabled = false;
                resetPassBtn.innerHTML = originalBtnHtml;
                resetPassBtn.classList.remove('opacity-80');
            }
        });
    }
</script>
</body>
</html>
