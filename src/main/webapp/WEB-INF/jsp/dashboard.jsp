<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>

<%-- 1. SECURITY & NO-CACHE LOGIC --%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    userCredential user = (userCredential) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("/login");
        return;
    }

    // 2. TDEE CALCULATION
    double bmr = 0;
    if ("Male".equalsIgnoreCase(user.getGender())) {
        bmr = (10 * user.getWeight()) + (6.25 * user.getHeight()) - (5 * user.getAge()) + 5;
    } else {
        bmr = (10 * user.getWeight()) + (6.25 * user.getHeight()) - (5 * user.getAge()) - 161;
    }

    double activityMultiplier = 1.2;
    try {
        activityMultiplier = Double.parseDouble(user.getActivityLevel());
    } catch (Exception e) { activityMultiplier = 1.2; }

    int tdee = (int) (bmr * activityMultiplier);

    // Dummy Data
    int consumed = 0;
    int remaining = tdee - consumed;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Sahaayata - Dashboard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;700&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#607AFB",
                        "background-light": "#f5f6f8",
                        "background-dark": "#0f1923",
                        "foreground-light": "#111714",
                        "foreground-dark": "#f0f4f2",
                        "card-light": "#ffffff",
                        "card-dark": "#1a2e23",
                        "muted-light": "#648772",
                        "muted-dark": "#a0b8ac",
                        "border-light": "#e3e8e5",
                        "border-dark": "#2a4033"
                    },
                    fontFamily: {
                        display: "Work Sans",
                        body: ["Montserrat", "sans-serif"]
                    },
                    borderRadius: {
                        DEFAULT: "0.25rem", lg: "0.5rem", xl: "0.75rem", full: "9999px"
                    }
                }
            }
        };
    </script>
    <style>
        .progress-ring__circle {
            transition: stroke-dashoffset 0.35s;
            transform: rotate(-90deg);
            transform-origin: 50% 50%;
        }
    </style>
</head>

<body class="font-body bg-background-light dark:bg-background-dark text-foreground-light dark:text-foreground-dark">
<div class="flex flex-col min-h-screen">

    <header class="sticky top-0 z-10 bg-card-light/80 dark:bg-card-dark/80 backdrop-blur-sm border-b border-border-light dark:border-border-dark">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">

                <div class="flex items-center gap-4">
                    <svg class="h-8 w-8 text-primary" fill="none" viewbox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                        <path clip-rule="evenodd" d="M24 4H6V17.3333V30.6667H24V44H42V30.6667V17.3333H24V4Z" fill="currentColor" fill-rule="evenodd"></path>
                    </svg>
                    <h1 class="text-2xl font-display font-bold text-foreground-light dark:text-foreground-dark">Sahaayata</h1>
                </div>

                <nav class="hidden md:flex items-center gap-8">
                    <a class="text-sm font-medium text-primary dark:text-primary" href="/dashboard">Dashboard</a>

                    <a class="text-sm font-medium text-muted-light dark:text-muted-dark hover:text-primary transition-colors" href="/my-recipes">Recipes</a>

                    <a class="text-sm font-medium text-muted-light dark:text-muted-dark hover:text-primary transition-colors" href="/community">Community</a>
                </nav>

                <div class="flex items-center gap-4">
                    <a href="/settings" class="hidden md:block text-sm font-semibold text-foreground-light hover:text-primary transition-colors">
                        <%= user.getUsername() %>
                    </a>

                    <a href="/logout" title="Logout" class="p-2 rounded-full hover:bg-red-50 text-muted-light hover:text-red-600 transition-colors">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15M12 9l-3 3m0 0l3 3m-3-3h12" />
                        </svg>
                    </a>

                    <a href="/settings" class="block" title="Profile & Settings">
                        <img alt="User avatar" class="w-10 h-10 rounded-full border border-primary hover:ring-2 hover:ring-primary/50 transition-all"
                             src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=607AFB&color=fff"/>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="flex-1 container mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

            <div class="lg:col-span-2 space-y-8">

                <div class="bg-card-light dark:bg-card-dark p-6 rounded-xl shadow-sm">
                    <h2 class="font-display text-xl font-bold mb-4">Daily Calorie Target</h2>
                    <div class="flex items-center justify-center">
                        <div class="relative w-48 h-48">
                            <svg class="w-full h-full" viewbox="0 0 100 100">
                                <circle class="text-primary/20 dark:text-primary/30" cx="50" cy="50" fill="transparent" r="45" stroke="currentColor" stroke-width="10"></circle>
                                <circle id="calorie-ring" class="progress-ring__circle text-primary" cx="50" cy="50" fill="transparent" r="45" stroke="currentColor" stroke-dasharray="282.74" stroke-dashoffset="282.74" stroke-linecap="round" stroke-width="10"></circle>
                            </svg>
                            <div class="absolute inset-0 flex flex-col items-center justify-center">
                                <span class="font-display text-3xl font-bold text-primary"><%= consumed %></span>
                                <span class="text-sm text-muted-light dark:text-muted-dark">/ <%= tdee %> kcal</span>
                            </div>
                        </div>
                    </div>
                    <p class="text-center mt-4 text-muted-light dark:text-muted-dark">
                        Target based on your stats: <span class="font-bold"><%= tdee %> kcal</span>.
                        <br>Start logging your meals to see progress!
                    </p>
                </div>

                <div class="bg-card-light dark:bg-card-dark p-6 rounded-xl shadow-sm">
                    <h2 class="font-display text-xl font-bold mb-6">Macronutrients (Goals)</h2>
                    <div class="space-y-6">
                        <div>
                            <div class="flex justify-between items-baseline mb-1">
                                <p class="font-medium">Protein</p>
                                <p class="text-sm text-muted-light">0g / <%= (int)(tdee * 0.3 / 4) %>g</p>
                            </div>
                            <div class="w-full bg-primary/20 rounded-full h-2.5">
                                <div class="bg-primary h-2.5 rounded-full" style="width: 0%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between items-baseline mb-1">
                                <p class="font-medium">Carbs</p>
                                <p class="text-sm text-muted-light">0g / <%= (int)(tdee * 0.4 / 4) %>g</p>
                            </div>
                            <div class="w-full bg-primary/20 rounded-full h-2.5">
                                <div class="bg-primary h-2.5 rounded-full" style="width: 0%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between items-baseline mb-1">
                                <p class="font-medium">Fats</p>
                                <p class="text-sm text-muted-light">0g / <%= (int)(tdee * 0.3 / 9) %>g</p>
                            </div>
                            <div class="w-full bg-primary/20 rounded-full h-2.5">
                                <div class="bg-primary h-2.5 rounded-full" style="width: 0%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bg-card-light dark:bg-card-dark p-6 rounded-xl shadow-sm h-fit">
                <h2 class="font-display text-xl font-bold mb-4">Today's Log</h2>
                <div class="space-y-4">
                    <div class="flex items-center justify-between p-4 rounded-lg bg-background-light dark:bg-background-dark">
                        <div>
                            <p class="font-medium">Breakfast</p>
                            <p class="text-sm text-muted-light">Empty</p>
                        </div>
                        <button class="text-primary font-bold text-sm hover:text-primary/80 transition-colors">+ Add</button>
                    </div>
                    <div class="flex items-center justify-between p-4 rounded-lg bg-background-light dark:bg-background-dark">
                        <div>
                            <p class="font-medium">Lunch</p>
                            <p class="text-sm text-muted-light">Empty</p>
                        </div>
                        <button class="text-primary font-bold text-sm hover:text-primary/80 transition-colors">+ Add</button>
                    </div>
                    <div class="flex items-center justify-between p-4 rounded-lg bg-background-light dark:bg-background-dark">
                        <div>
                            <p class="font-medium">Dinner</p>
                            <p class="text-sm text-muted-light">Empty</p>
                        </div>
                        <button class="text-primary font-bold text-sm hover:text-primary/80 transition-colors">+ Add</button>
                    </div>
                    <div class="flex items-center justify-between p-4 rounded-lg bg-background-light dark:bg-background-dark">
                        <div>
                            <p class="font-medium">Snacks</p>
                            <p class="text-sm text-muted-light">Empty</p>
                        </div>
                        <button class="text-primary font-bold text-sm hover:text-primary/80 transition-colors">+ Add</button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <button class="fixed bottom-8 right-8 bg-primary text-white rounded-full h-16 w-16 flex items-center justify-center shadow-lg hover:bg-primary/90 transition-transform transform hover:scale-105">
        <svg fill="currentColor" height="28" viewbox="0 0 256 256" width="28" xmlns="http://www.w3.org/2000/svg">
            <path d="M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z"></path>
        </svg>
    </button>
</div>

<script>
    const circle = document.getElementById('calorie-ring');
    const radius = circle.r.baseVal.value;
    const circumference = 2 * Math.PI * radius;
    circle.style.strokeDasharray = `${circumference} ${circumference}`;

    const consumed = <%= consumed %>;
    const target = <%= tdee %>;
    const percent = Math.min(consumed / target, 1);
    const offset = circumference - (percent * circumference);
    circle.style.strokeDashoffset = offset;
</script>

</body>
</html>