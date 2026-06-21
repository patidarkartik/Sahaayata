<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sahaayata.minorproject.model.UserCredential" %>

<%-- 🛑 SECURITY & NO-CACHE LOGIC --%>
<%
    // 1. Browser ko bolo: Cache mat karo (Logout security ke liye)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // 2. Check: User Login hai ya nahi?
    UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Personalize Plan | Sahaayata</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@600;700&display=swap" rel="stylesheet"/>
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

<!-- Top Navigation (No external links as requested) -->
<header class="fixed top-0 w-full z-50 bg-background/80 backdrop-blur-md px-gutter h-16 flex items-center justify-between border-b border-outline-variant/30">
    <div class="max-w-container-max mx-auto w-full flex items-center justify-start">
        <div class="flex items-center gap-0">
            <img src="/images/logo.svg" alt="Sahaayata Logo" class="h-20 w-auto object-contain">
            <span class="text-3xl font-headline-md font-bold text-primary tracking-tight -ml-2 ai-gradient-text">Sahaayata</span>
        </div>
    </div>
</header>

<!-- Main Content Area -->
<main class="flex-grow flex items-center justify-center pt-20 pb-6 px-gutter relative overflow-hidden">
    <!-- Ambient Decorative Background Elements -->
    <div class="absolute top-1/4 -left-20 w-96 h-96 bg-primary/5 rounded-full blur-[100px]"></div>
    <div class="absolute bottom-1/4 -right-20 w-96 h-96 bg-secondary/5 rounded-full blur-[100px]"></div>
    
    <div class="w-full max-w-lg z-10">
        <!-- Header Text -->
        <div class="text-center mb-5">
            <h1 class="font-display-lg text-3xl text-on-surface mb-2">
                Let's know you <span class="ai-gradient-text">better</span>
            </h1>
            <p class="font-body-md text-sm text-on-surface-variant">
                We need these details to calculate your perfect diet plan.
            </p>
        </div>

        <!-- Onboarding Card -->
        <div class="bg-surface-container-lowest p-5 md:p-6 rounded-2xl ambient-shadow border border-outline-variant/20">
            <form action="/save-onboarding" method="post" class="flex flex-col gap-5">
                
                <!-- Gender Selection -->
                <div class="flex flex-col gap-2">
                    <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2">
                        <span class="material-symbols-outlined text-sm">wc</span>
                        Gender
                    </label>
                    <div class="grid grid-cols-2 gap-3">
                        <label class="cursor-pointer">
                            <input type="radio" name="gender" id="male" value="Male" class="peer sr-only" required checked>
                            <div class="flex flex-col items-center justify-center p-4 rounded-xl border border-outline-variant bg-white peer-checked:border-primary peer-checked:bg-primary/5 peer-checked:text-primary text-on-surface-variant hover:bg-surface-container transition-all">
                                <span class="material-symbols-outlined text-3xl mb-1">man</span>
                                <span class="font-label-sm text-sm">Male</span>
                            </div>
                        </label>
                        <label class="cursor-pointer">
                            <input type="radio" name="gender" id="female" value="Female" class="peer sr-only">
                            <div class="flex flex-col items-center justify-center p-4 rounded-xl border border-outline-variant bg-white peer-checked:border-primary peer-checked:bg-primary/5 peer-checked:text-primary text-on-surface-variant hover:bg-surface-container transition-all">
                                <span class="material-symbols-outlined text-3xl mb-1">woman</span>
                                <span class="font-label-sm text-sm">Female</span>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Age, Weight, Height -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="flex flex-col gap-1">
                        <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="age">
                            Age (Years)
                        </label>
                        <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="age" name="age" type="number" min="1" placeholder="e.g. 25" required>
                    </div>
                    
                    <div class="flex flex-col gap-1">
                        <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="weight">
                            Weight (kg)
                        </label>
                        <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="weight" name="weight" type="number" min="1" step="0.1" placeholder="e.g. 70" required>
                    </div>
                    
                    <div class="flex flex-col gap-1">
                        <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="height">
                            Height (cm)
                        </label>
                        <input class="w-full h-10 px-3 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md" id="height" name="height" type="number" min="1" step="0.1" placeholder="e.g. 175" required>
                    </div>
                </div>

                <!-- Activity Level -->
                <div class="flex flex-col gap-1">
                    <label class="font-label-sm text-label-sm text-on-surface-variant flex items-center gap-2" for="activityLevel">
                        <span class="material-symbols-outlined text-sm">directions_run</span>
                        How active are you?
                    </label>
                    <div class="relative">
                        <select class="w-full h-10 px-3 pr-10 rounded-xl border border-outline-variant bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all font-body-md text-body-md appearance-none" id="activityLevel" name="activityLevel" required>
                            <option value="" selected disabled>Select Activity Level</option>
                            <option value="1.2">Sedentary (Office Job, No Exercise)</option>
                            <option value="1.375">Lightly Active (Exercise 1-3 days/week)</option>
                            <option value="1.55">Moderately Active (Exercise 3-5 days/week)</option>
                            <option value="1.725">Very Active (Heavy Exercise 6-7 days/week)</option>
                            <option value="1.9">Extra Active (Physical Job + Training)</option>
                        </select>
                        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-3 text-on-surface-variant">
                            <span class="material-symbols-outlined text-lg">expand_more</span>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <button class="ai-gradient-bg text-on-primary font-label-sm text-label-sm py-2.5 mt-2 rounded-xl ambient-shadow ambient-shadow-hover active:scale-[0.98] transition-all flex items-center justify-center gap-2 group" type="submit">
                    <span>Calculate My Plan</span>
                    <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
                </button>
            </form>
        </div>
    </div>
</main>

<!-- Simple Footer -->
<footer class="w-full py-4 bg-surface-container-lowest border-t border-outline-variant/30">
    <div class="max-w-container-max mx-auto px-gutter flex justify-center items-center text-on-surface-variant font-label-sm text-label-sm">
        <span>© 2024 Sahaayata. All rights reserved.</span>
    </div>
</footer>

</body>
</html>