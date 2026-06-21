<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Sahaayata - Health & Fitness</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&amp;family=Inter:wght@400;600&amp;family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-secondary-fixed": "#002113",
                        "on-error": "#ffffff",
                        "surface": "#faf8ff",
                        "surface-container-low": "#f2f3ff",
                        "inverse-primary": "#adc6ff",
                        "on-primary-container": "#fefcff",
                        "tertiary-fixed": "#ffdcc6",
                        "surface-variant": "#dae2fd",
                        "on-tertiary-fixed": "#311400",
                        "on-secondary": "#ffffff",
                        "surface-container": "#eaedff",
                        "on-primary-fixed-variant": "#004395",
                        "inverse-on-surface": "#eef0ff",
                        "surface-container-lowest": "#ffffff",
                        "surface-bright": "#faf8ff",
                        "error-container": "#ffdad6",
                        "primary-container": "#2170e4",
                        "outline-variant": "#c2c6d6",
                        "tertiary-fixed-dim": "#ffb786",
                        "primary-fixed-dim": "#adc6ff",
                        "on-primary": "#ffffff",
                        "error": "#ba1a1a",
                        "secondary-fixed-dim": "#4edea3",
                        "primary-fixed": "#d8e2ff",
                        "outline": "#727785",
                        "on-tertiary-container": "#fffbff",
                        "on-secondary-fixed-variant": "#005236",
                        "tertiary": "#924700",
                        "surface-dim": "#d2d9f4",
                        "on-tertiary": "#ffffff",
                        "tertiary-container": "#b75b00",
                        "on-surface-variant": "#424754",
                        "secondary-container": "#6cf8bb",
                        "surface-container-high": "#e2e7ff",
                        "secondary": "#006c49",
                        "secondary-fixed": "#6ffbbe",
                        "on-surface": "#131b2e",
                        "on-secondary-container": "#00714d",
                        "background": "#faf8ff",
                        "primary": "#0058be",
                        "on-tertiary-fixed-variant": "#723600",
                        "on-error-container": "#93000a",
                        "on-primary-fixed": "#001a42",
                        "on-background": "#131b2e",
                        "inverse-surface": "#283044",
                        "surface-container-highest": "#dae2fd",
                        "surface-tint": "#005ac2"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "section-padding-lg": "96px",
                        "stack-gap": "16px",
                        "section-padding-sm": "48px",
                        "container-max": "1280px",
                        "gutter": "24px"
                    },
                    "fontFamily": {
                        "body-md": ["Inter", "sans-serif"],
                        "label-sm": ["Inter", "sans-serif"],
                        "display-lg-mobile": ["DM Sans", "sans-serif"],
                        "display-lg": ["DM Sans", "sans-serif"],
                        "headline-md": ["DM Sans", "sans-serif"],
                        "body-lg": ["Inter", "sans-serif"]
                    },
                    "fontSize": {
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                        "label-sm": ["14px", {"lineHeight": "20px", "letterSpacing": "0.02em", "fontWeight": "600"}],
                        "display-lg-mobile": ["36px", {"lineHeight": "44px", "letterSpacing": "-0.01em", "fontWeight": "700"}],
                        "display-lg": ["56px", {"lineHeight": "64px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "headline-md": ["28px", {"lineHeight": "36px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                        "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}]
                    }
                },
            },
        }
    </script>
<style>
        .ai-gradient-text {
            background: linear-gradient(135deg, #0058be 0%, #006c49 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body class="bg-background text-on-background font-body-md selection:bg-primary-fixed selection:text-on-primary-fixed">
<header class="fixed top-0 w-full z-50 bg-surface/80 backdrop-blur-md border-b border-outline-variant/30 shadow-sm">
<nav class="flex justify-between items-center max-w-container-max mx-auto px-gutter h-16">
<div class="flex items-center gap-0 shrink-0">
<img src="/images/logo.svg" alt="Sahaayata Logo" class="h-12 sm:h-20 w-auto object-contain">
<span class="text-2xl sm:text-3xl font-headline-md font-bold text-primary tracking-tight -ml-1 sm:-ml-2 ai-gradient-text">Sahaayata</span>
</div>
<div class="hidden md:flex items-center gap-8">
<a class="font-label-sm text-label-sm text-on-surface-variant hover:text-primary transition-colors" href="#features">Features</a>
<a class="font-label-sm text-label-sm text-on-surface-variant hover:text-primary transition-colors" href="#about">About</a>
</div>
<div class="flex items-center gap-2 sm:gap-4 shrink-0">
<a class="px-3 sm:px-5 py-2 rounded-full font-label-sm text-label-sm text-primary hover:bg-surface-container-low transition-all" href="/login">Login</a>
<a class="hidden sm:inline-flex px-5 py-2 rounded-full font-label-sm text-label-sm bg-primary text-on-primary shadow-sm hover:opacity-90 transition-all" href="/register">Get Started</a>
</div>
</nav>
</header>
<main class="pt-16">
<section class="relative overflow-hidden bg-surface-container-lowest pt-12 pb-16 md:pt-16 md:pb-20">
<div class="max-w-container-max mx-auto px-gutter grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
<div class="z-10">
<div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-secondary-container/30 text-secondary mb-4">
<span class="material-symbols-outlined text-[18px]" style="font-variation-settings: 'FILL' 1;">health_and_safety</span>
<span class="text-[12px] font-bold tracking-wider uppercase">Your Personal Nutrition Assistant</span>
</div>
<h1 class="font-display-lg-mobile md:font-display-lg text-display-lg-mobile md:text-display-lg text-on-surface mb-6 leading-tight">
                        Achieve Your Health Goals with <span class="ai-gradient-text">Sahaayata</span>
</h1>
<p class="font-body-lg text-body-lg text-on-surface-variant mb-8 max-w-xl">
                        Track your diet, fitness, and overall well-being with our intuitive app. Join thousands of users who are transforming their lives.
                    </p>
<div class="flex flex-col sm:flex-row gap-4">
<a href="/register" class="bg-primary text-on-primary px-6 py-3 rounded-2xl font-label-sm text-label-sm flex items-center justify-center gap-2 shadow-lg hover:translate-y-[-2px] transition-all">
                            Get Started
                            <span class="material-symbols-outlined">arrow_forward</span>
</a>
<a href="#features" class="bg-white text-secondary border border-secondary px-6 py-3 rounded-2xl font-label-sm text-label-sm flex items-center justify-center gap-2 hover:bg-secondary-container/10 transition-all">
                            Learn More
</a>
</div>
<div class="mt-12 flex items-center gap-6 opacity-60 grayscale hover:grayscale-0 transition-all duration-500">
<span class="text-label-sm">Trusted by healthcare pioneers</span>
<div class="flex gap-4">
<span class="material-symbols-outlined text-3xl">medical_services</span>
<span class="material-symbols-outlined text-3xl">biotech</span>
<span class="material-symbols-outlined text-3xl">monitoring</span>
</div>
</div>
</div>
<div class="relative w-full rounded-3xl shadow-2xl shadow-primary/10 overflow-hidden flex items-center justify-center bg-surface-container-low border border-outline-variant/30">
    <img src="/images/Landing_Img.jpeg" alt="Sahaayata Interface" class="w-full h-auto object-contain" />
    <div class="absolute inset-0 bg-gradient-to-t from-surface-container-lowest via-transparent to-transparent opacity-80 pointer-events-none"></div>
</div>
</div>
</section>
<section class="py-12 md:py-16 bg-background" id="features">
<div class="max-w-container-max mx-auto px-gutter text-center mb-10">
<h2 class="font-headline-md text-headline-md text-on-surface mb-4">Comprehensive Feature Suite</h2>
<p class="font-body-md text-body-md text-on-surface-variant max-w-2xl mx-auto">Sahaayata offers a complete set of tools to help you stay on track and achieve your health and fitness objectives.</p>
</div>
<div class="max-w-container-max mx-auto px-gutter grid grid-cols-1 md:grid-cols-3 gap-6">
<div class="bg-surface-container-lowest p-8 rounded-2xl border border-outline-variant/30 shadow-sm hover:shadow-lg hover:border-primary/20 transition-all group">
<div class="w-12 h-12 rounded-xl bg-primary-container/10 text-primary flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
<span class="material-symbols-outlined text-3xl" style="font-variation-settings: 'FILL' 1;">restaurant_menu</span>
</div>
<h3 class="font-headline-md text-xl text-on-surface mb-4">Recipe-First Logging</h3>
<p class="font-body-md text-body-md text-on-surface-variant leading-relaxed">Log your daily meals and nutritional intake seamlessly by focusing on whole recipes. Keep track of macros and calories with ease.</p>
</div>
<div class="bg-surface-container-lowest p-8 rounded-2xl border border-outline-variant/30 shadow-sm hover:shadow-lg hover:border-secondary/20 transition-all group">
<div class="w-12 h-12 rounded-xl bg-secondary-container/20 text-secondary flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
<span class="material-symbols-outlined text-3xl" style="font-variation-settings: 'FILL' 1;">auto_awesome</span>
</div>
<h3 class="font-headline-md text-xl text-on-surface mb-4">AI Recommendations</h3>
<p class="font-body-md text-body-md text-on-surface-variant leading-relaxed">Get intelligent, personalized meal suggestions and nutritional advice powered by AI to help you achieve specific health goals.</p>
</div>
<div class="bg-surface-container-lowest p-8 rounded-2xl border border-outline-variant/30 shadow-sm hover:shadow-lg hover:border-primary/20 transition-all group">
<div class="w-12 h-12 rounded-xl bg-primary-container/10 text-primary flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
<span class="material-symbols-outlined text-3xl" style="font-variation-settings: 'FILL' 1;">groups</span>
</div>
<h3 class="font-headline-md text-xl text-on-surface mb-4">Community Sharing</h3>
<p class="font-body-md text-body-md text-on-surface-variant leading-relaxed">Connect with others, share your favorite healthy recipes, and get inspired by a supportive community on the same journey.</p>
</div>
</div>
</section>
<section class="py-8 md:py-10">
<div class="max-w-container-max mx-auto px-gutter">
<div class="bg-inverse-surface rounded-[2.5rem] p-8 md:p-12 text-center relative overflow-hidden">
<div class="absolute top-0 left-0 w-full h-full opacity-5 pointer-events-none">
<div class="absolute top-10 left-10 w-64 h-64 border-4 border-white rounded-full"></div>
<div class="absolute bottom-10 right-10 w-96 h-96 border-4 border-white rounded-full"></div>
</div>
<h2 class="font-display-lg-mobile md:text-5xl font-bold text-white mb-6 relative z-10">Ready to Begin <br class="hidden md:block"/><span class="text-secondary-fixed-dim">Your Health Journey?</span></h2>
<p class="font-body-md md:text-lg text-white/70 mb-8 max-w-xl mx-auto relative z-10">Sign up today and take the first step towards a healthier, stronger, and happier you.</p>
<div class="flex flex-col sm:flex-row justify-center gap-6 relative z-10">
<a class="bg-secondary-fixed text-on-secondary-fixed px-8 py-4 rounded-2xl font-label-sm text-label-sm font-bold shadow-xl hover:scale-105 transition-transform" href="/register">Create Your Free Account</a>
</div>
</div>
</div>
</section>
</main>
<footer id="about" class="w-full py-8 md:py-12 bg-surface-container-lowest border-t border-outline-variant">
<div class="max-w-container-max mx-auto px-gutter flex flex-col md:flex-row justify-between items-start md:items-center gap-stack-gap">
<div class="flex flex-col gap-4">
<div class="flex items-center gap-0">
<img src="/images/logo.svg" alt="Sahaayata Logo" class="h-10 w-auto object-contain">
<span class="text-2xl font-headline-md font-bold text-primary tracking-tight -ml-1">Sahaayata</span>
</div>
<p class="text-on-surface-variant font-label-sm max-w-xs">© 2024 Sahaayata. All rights reserved. Your companion for tracking diet, fitness, and overall well-being.</p>
</div>
<div class="grid grid-cols-2 sm:grid-cols-3 gap-12 mt-8 md:mt-0">
<div class="flex flex-col gap-3">
<h6 class="font-bold text-on-surface text-sm uppercase tracking-wider">Product</h6>
<a class="text-on-surface-variant hover:text-secondary hover:underline transition-all text-sm" href="#features">Features</a>
<a class="text-on-surface-variant hover:text-secondary hover:underline transition-all text-sm" href="#">Support</a>
</div>
<div class="flex flex-col gap-3">
<h6 class="font-bold text-on-surface text-sm uppercase tracking-wider">Legal</h6>
<a class="text-on-surface-variant hover:text-secondary hover:underline transition-all text-sm" href="#">Privacy Policy</a>
<a class="text-on-surface-variant hover:text-secondary hover:underline transition-all text-sm" href="#">Terms of Service</a>
<a class="text-on-surface-variant hover:text-secondary hover:underline transition-all text-sm" href="#">Cookie Policy</a>
</div>
<div class="flex flex-col gap-3">
<h6 class="font-bold text-on-surface text-sm uppercase tracking-wider">Connect</h6>
<a class="text-on-surface-variant hover:text-secondary hover:underline transition-all text-sm" href="#">Twitter</a>
<a class="text-on-surface-variant hover:text-secondary hover:underline transition-all text-sm" href="#">LinkedIn</a>
<a class="text-on-surface-variant hover:text-secondary hover:underline transition-all text-sm" href="#">Contact Us</a>
</div>
</div>
</div>
</footer>
</body>
</html>