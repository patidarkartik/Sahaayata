<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 1. SECURITY CHECK --%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    userCredential user = (userCredential) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Sahaayata - Community</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#607AFB",
                        "background-light": "#f5f6f8",
                        "background-dark": "#0f1323",
                        "text-light": "#112117",
                        "text-dark": "#f6f8f7",
                        "text-muted-light": "#586e63",
                        "text-muted-dark": "#a0b5a9"
                    },
                    fontFamily: {display: "Work Sans"},
                    borderRadius: {DEFAULT: "0.25rem", lg: "0.5rem", xl: "0.75rem", full: "9999px"}
                }
            }
        };
    </script>
    <style>
        body { font-family: "Work Sans", sans-serif; }
        .material-symbols-outlined { font-variation-settings: "FILL" 0, "wght" 400, "GRAD" 0, "opsz" 24; }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-text-light dark:text-text-dark">
<div class="flex min-h-screen flex-col">

    <header class="border-b border-black/10 dark:border-white/10 sticky top-0 z-10 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-sm">
        <div class="container mx-auto flex items-center justify-between px-4 py-3 sm:px-6 lg:px-8">
            <div class="flex items-center gap-6">
                <a class="flex items-center gap-2 text-xl font-bold text-text-light dark:text-text-dark" href="/dashboard">
                    <span class="text-primary">
                        <svg class="h-8 w-8" fill="currentColor" viewbox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 16.5V15H8v-2h3v-2.1c0-2.3.94-4.4 2.8-4.4h2.2v2H14.5c-.41 0-1.1.25-1.1 1.1V13h3l-.5 2h-2.5v3.5h-2z"></path>
                        </svg>
                    </span>
                    Sahaayata
                </a>

                <nav class="hidden items-center gap-6 md:flex">
                    <a class="text-sm font-medium text-text-muted-light dark:text-text-muted-dark hover:text-primary" href="/dashboard">Dashboard</a>
                    <a class="text-sm font-medium text-text-muted-light dark:text-text-muted-dark hover:text-primary" href="/my-recipes">My Recipes</a>
                    <a class="text-sm font-medium text-primary dark:text-primary" href="/community">Community</a>
                </nav>
            </div>

            <div class="flex items-center gap-3">
                <button class="rounded-full p-2 text-text-muted-light dark:text-text-muted-dark hover:bg-primary/20">
                    <span class="material-symbols-outlined"> search </span>
                </button>
                <a href="/settings">
                    <img alt="User avatar" class="size-10 rounded-full border border-primary/20"
                         src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=607AFB&color=fff"/>
                </a>
            </div>
        </div>
    </header>

    <main class="container mx-auto flex-grow px-4 py-8 sm:px-6 lg:px-8">
        <div class="mb-8 text-center">
            <h1 class="text-4xl font-bold tracking-tight text-text-light dark:text-text-dark sm:text-5xl">Explore Community Recipes</h1>
            <p class="mt-4 text-lg text-text-muted-light dark:text-text-muted-dark">Discover delicious and healthy meals shared by our amazing community.</p>
        </div>

        <div class="mb-8 flex flex-wrap items-center justify-center gap-4">
            <div class="relative">
                <button class="flex items-center gap-2 rounded-full border border-black/10 bg-white px-4 py-2 text-sm font-medium shadow-sm dark:border-white/10 dark:bg-background-dark hover:bg-primary/10 dark:hover:bg-primary/20">
                    <span>Veg/Non-Veg</span>
                    <span class="material-symbols-outlined text-base"> expand_more </span>
                </button>
            </div>
            <div class="relative">
                <button class="flex items-center gap-2 rounded-full border border-black/10 bg-white px-4 py-2 text-sm font-medium shadow-sm dark:border-white/10 dark:bg-background-dark hover:bg-primary/10 dark:hover:bg-primary/20">
                    <span>Meal Type</span>
                    <span class="material-symbols-outlined text-base"> expand_more </span>
                </button>
            </div>
        </div>

        <div class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-x-8">

            <c:forEach var="recipe" items="${communityRecipes}">
                <div class="group cursor-pointer">
                    <div class="aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-lg bg-gray-200 xl:aspect-h-8 xl:aspect-w-7 relative">
                        <img alt="${recipe.title}"
                             class="h-full w-full object-cover object-center transition-transform duration-300 group-hover:scale-105"
                             src="${recipe.imageUrl}"/>
                    </div>
                    <h3 class="mt-4 text-base font-semibold text-text-light dark:text-text-dark truncate">${recipe.title}</h3>
                    <div class="mt-1 flex items-center text-sm text-text-muted-light dark:text-text-muted-dark justify-between">
                        <div class="flex items-center">
                            <span class="material-symbols-outlined text-base text-primary">star</span>
                            <span class="ml-1">4.5</span>
                        </div>
                        <span class="mx-2">•</span>
                        <span class="truncate">by ${recipe.user.username}</span>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty communityRecipes}">
                <div class="col-span-full text-center py-10">
                    <p class="text-xl text-text-muted-light">No recipes shared yet. Be the first one!</p>
                    <a href="/create-recipe" class="mt-4 inline-block px-6 py-2 bg-primary text-white rounded-full font-bold hover:bg-blue-600 transition">Share Recipe</a>
                </div>
            </c:if>

        </div>
    </main>

    <footer class="bg-background-light dark:bg-background-dark">
        <div class="container mx-auto border-t border-black/10 px-4 py-8 dark:border-white/10 sm:px-6 lg:px-8">
            <div class="flex flex-col items-center justify-between gap-4 sm:flex-row">
                <p class="text-sm text-text-muted-light dark:text-text-muted-dark">© 2024 Sahaayata. All rights reserved.</p>
            </div>
        </div>
    </footer>
</div>
</body>
</html>