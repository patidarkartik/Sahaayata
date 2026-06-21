<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Register | Sahaayata</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&amp;family=DM+Sans:wght@600;700&amp;display=swap" rel="stylesheet"/>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
<!-- Top Navigation (Shell Supression applied for focused journey, but logo & back link retained) -->
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
<h1 class="font-display-lg text-3xl text-on-surface mb-2">
                    Join the <span class="ai-gradient-text">Sahaayata</span> of Health 
                </h1>
<p class="font-body-md text-sm text-on-surface-variant">
                    Create your account to start your fitness journey today.
                </p>
</div>
<!-- Registration Card -->
<div class="bg-surface-container-lowest p-5 md:p-6 rounded-2xl ambient-shadow border border-outline-variant/20">
<form class="flex flex-col gap-4" id="registrationForm">
<!-- Username Field -->
<div class="flex flex-col gap-1">
<label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="username">
<span class="material-symbols-outlined text-sm">person</span>
                            Username
                        </label>
<input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="username" name="username" placeholder="fitness_enthusiast" required="" type="text"/>
</div>
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
<label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="password">
<span class="material-symbols-outlined text-sm">lock</span>
                            Password
                        </label>
<div class="relative">
<input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="password" name="password" placeholder="••••••••" required="" type="password"/>
<button class="absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant hover:text-primary transition-colors" type="button">
<span class="material-symbols-outlined">visibility</span>
</button>
</div>
</div>

                        <!-- OTP Field (Hidden Initially) -->
                        <div class="flex flex-col gap-1 hidden" id="otpGroup">
                            <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="regOtp">
                                <span class="material-symbols-outlined text-sm">pin</span>
                                Email Verification OTP
                            </label>
                            <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md tracking-widest text-center" id="regOtp" name="otp" placeholder="123456" type="text" maxlength="6"/>
                            <p class="text-xs text-on-surface-variant text-center mt-1">Please check your email for the 6-digit code.</p>
                        </div>

                        <div id="form-status" class="hidden text-sm font-medium text-center" aria-live="polite"></div>

<!-- Terms Checkbox -->
<div class="flex items-start gap-2 mt-1">
<input class="mt-1 w-5 h-5 rounded border-outline-variant text-primary focus:ring-primary" id="terms" type="checkbox"/>
<label class="font-label-sm text-xs text-on-surface-variant" for="terms">
                            I agree to the <a class="text-primary hover:underline" href="#">Terms of Service</a> and <a class="text-primary hover:underline" href="#">Privacy Policy</a>.
                        </label>
</div>
<!-- Register Button -->
<button class="ai-gradient-bg text-on-primary font-label-sm text-label-sm py-2.5 rounded-xl ambient-shadow ambient-shadow-hover active:scale-[0.98] transition-all flex items-center justify-center gap-2 group" type="submit" id="mainSubmitBtn">
<span>Register Account</span>
<span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
</button>
</form>
<!-- Login Link -->
<div class="mt-5 pt-5 border-t border-outline-variant/30 text-center">
<p class="font-body-md text-body-md text-on-surface-variant">
                        Already have an account? <a class="text-primary font-bold hover:underline" href="/login">Log in</a>
</p>
</div>
</div>
</div>
</main>
<!-- Simple Footer (Focused Journey) -->
<footer class="w-full py-4 bg-surface-container-lowest border-t border-outline-variant/30">
<div class="max-w-container-max mx-auto px-gutter flex flex-col md:flex-row justify-between items-center gap-4 text-on-surface-variant font-label-sm text-label-sm">
<span>© 2024 Sahaayata. All rights reserved.</span>
</div>
</footer>
<script>
        // Micro-interaction for password visibility
        const togglePassword = document.querySelector('button[type="button"]');
        const passwordInput = document.querySelector('#password');
        const icon = togglePassword.querySelector('.material-symbols-outlined');

        togglePassword.addEventListener('click', () => {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            icon.textContent = type === 'password' ? 'visibility' : 'visibility_off';
        });

        // Form submission animation and actual backend integration
        const form = document.getElementById('registrationForm');
        const statusEl = document.getElementById('form-status');

        form.addEventListener('submit', async function (e) {
            e.preventDefault();
            
            const termsChecked = document.getElementById('terms').checked;
            if (!termsChecked) {
                statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                statusEl.textContent = 'Please agree to the Terms of Service and Privacy Policy.';
                return;
            }

            if (statusEl) {
                statusEl.textContent = '';
                statusEl.className = 'hidden';
            }

            const submitBtn = document.getElementById('mainSubmitBtn');
            const originalBtnHtml = submitBtn ? submitBtn.innerHTML : '';
            const otpGroup = document.getElementById('otpGroup');
            const isOtpStep = !otpGroup.classList.contains('hidden');

            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.innerHTML = `<span class="animate-spin material-symbols-outlined">sync</span> <span>Processing...</span>`;
                submitBtn.classList.add('opacity-80');
            }

            if (!isOtpStep) {
                // STEP 1: Request OTP
                const payload = {
                    username: (document.getElementById('username') || {}).value?.trim() || '',
                    email: (document.getElementById('email') || {}).value?.trim() || '',
                    password: (document.getElementById('password') || {}).value || '',
                };

                if (!payload.username || !payload.email || !payload.password) {
                    if (statusEl) {
                        statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                        statusEl.textContent = 'Please complete all fields.';
                    }
                    if (submitBtn) {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = originalBtnHtml;
                        submitBtn.classList.remove('opacity-80');
                    }
                    return;
                }

                try {
                    const resp = await fetch('/register/send-otp', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(payload),
                    });

                    if (resp.ok) {
                        statusEl.className = 'mt-2 text-sm text-green-600 text-center block';
                        statusEl.textContent = 'OTP sent! Please check your email inbox.';
                        
                        // Switch to step 2 UI
                        document.getElementById('username').disabled = true;
                        document.getElementById('email').disabled = true;
                        document.getElementById('password').disabled = true;
                        document.getElementById('terms').disabled = true;
                        
                        otpGroup.classList.remove('hidden');
                        document.getElementById('regOtp').setAttribute('required', 'true');
                        
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = `<span>Verify OTP & Complete</span><span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">check_circle</span>`;
                        submitBtn.classList.remove('opacity-80');
                    } else {
                        const err = await resp.json().catch(() => ({}));
                        const msg = err.message || 'Failed to send OTP.';
                        statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                        statusEl.textContent = msg;
                        if (submitBtn) {
                            submitBtn.disabled = false;
                            submitBtn.innerHTML = originalBtnHtml;
                            submitBtn.classList.remove('opacity-80');
                        }
                    }
                } catch (networkErr) {
                    statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                    statusEl.textContent = 'Network error. Please try again.';
                    if (submitBtn) {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = originalBtnHtml;
                        submitBtn.classList.remove('opacity-80');
                    }
                }
            } else {
                // STEP 2: Verify OTP and Register
                const payload = {
                    email: document.getElementById('email').value.trim(),
                    otp: document.getElementById('regOtp').value.trim(),
                };

                try {
                    const resp = await fetch('/register', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(payload),
                    });

                    if (resp.ok) {
                        const data = await resp.json();
                        statusEl.className = 'mt-2 text-sm text-green-600 text-center block';
                        statusEl.textContent = 'Account created successfully! Taking you to onboarding...';
                        setTimeout(() => {
                            window.location.href = data.redirectUrl || '/onboarding';
                        }, 1500);
                    } else {
                        const err = await resp.json().catch(() => ({}));
                        const msg = err.message || 'Verification failed. Please try again.';
                        statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                        statusEl.textContent = msg;
                        if (submitBtn) {
                            submitBtn.disabled = false;
                            submitBtn.innerHTML = `<span>Verify OTP & Complete</span><span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">check_circle</span>`;
                            submitBtn.classList.remove('opacity-80');
                        }
                    }
                } catch (networkErr) {
                    statusEl.className = 'mt-2 text-sm text-red-600 text-center block';
                    statusEl.textContent = 'Network error. Please check your connection.';
                    if (submitBtn) {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = `<span>Verify OTP & Complete</span><span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">check_circle</span>`;
                        submitBtn.classList.remove('opacity-80');
                    }
                }
            }
        });
        
        window.addEventListener('pageshow', function(event) {
            if (form) {
                form.reset();
            }
        });
    </script>
</body>
</html>