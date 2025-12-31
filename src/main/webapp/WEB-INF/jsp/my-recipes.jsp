<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 1. SECURITY CHECK --%>
<%
    // Browser caching disable karein
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // User session check
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
    <title>Sahaayata - My Recipes</title>
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
                        "foreground-light": "#112117",
                        "foreground-dark": "#f6f8f7",
                        "card-light": "#ffffff",
                        "card-dark": "#1a2e23",
                        "muted-light": "#6b7280",
                        "muted-dark": "#9ca3af",
                        "border-light": "#e5e7eb",
                        "border-dark": "#2c3e34"
                    },
                    fontFamily: { display: "Work Sans" },
                    borderRadius: { DEFAULT: "0.25rem", lg: "0.5rem", xl: "0.75rem", full: "9999px" }
                }
            }
        };
    </script>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-foreground-light dark:text-foreground-dark">
<div class="flex flex-col min-h-screen">

    <header class="sticky top-0 z-10 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-sm border-b border-border-light dark:border-border-dark">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <div class="flex items-center gap-4">
                    <svg class="h-8 w-8 text-primary" fill="none" viewbox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                        <path clip-rule="evenodd" d="M24 4H6V17.3333V30.6667H24V44H42V30.6667V17.3333H24V4Z" fill="currentColor" fill-rule="evenodd"></path>
                    </svg>
                    <h1 class="text-2xl font-bold text-foreground-light dark:text-foreground-dark">Sahaayata</h1>
                </div>

                <nav class="hidden md:flex items-center gap-6 text-sm font-medium">
                    <a class="text-muted-light dark:text-muted-dark hover:text-primary transition-colors" href="/dashboard">Dashboard</a>
                    <a class="text-primary font-semibold" href="/my-recipes">My Recipes</a>
                    <a class="text-muted-light dark:text-muted-dark hover:text-primary transition-colors" href="/community">Community</a>
                </nav>

                <div class="flex items-center gap-4">
                    <button class="p-2 rounded-full hover:bg-primary/20 transition-colors">
                        <span class="material-symbols-outlined text-muted-light dark:text-muted-dark">notifications</span>
                    </button>
                    <a href="/settings" title="Profile">
                        <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=607AFB&color=fff"
                             class="w-10 h-10 rounded-full border border-primary/20 hover:border-primary transition-colors" alt="User"/>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
            <h2 class="text-3xl font-bold text-foreground-light dark:text-foreground-dark">My Recipes</h2>

            <a href="/create-recipe" class="flex items-center gap-2 px-4 py-2 bg-primary text-white rounded-lg font-semibold hover:bg-primary/90 transition-all duration-300 transform hover:scale-105 shadow-lg">
                <span class="material-symbols-outlined">add</span>
                <span class="truncate">New Recipe</span>
            </a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">

            <c:forEach var="recipe" items="${recipeList}">
                <div class="group flex flex-col bg-card-light dark:bg-card-dark rounded-lg overflow-hidden shadow-sm hover:shadow-xl transition-shadow duration-300 border border-border-light dark:border-border-dark">
                    <div class="relative">
                        <div class="w-full h-48 bg-cover bg-center transform group-hover:scale-105 transition-transform duration-500"
                             style="background-image: url('${recipe.imageUrl}');">
                        </div>

                        <div class="absolute inset-0 bg-black/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center gap-4 backdrop-blur-[2px]">
                            <button class="bg-white/90 dark:bg-black/60 p-2 rounded-full text-foreground-light dark:text-foreground-dark hover:bg-white dark:hover:bg-black/80 transition-colors shadow-sm">
                                <span class="material-symbols-outlined text-sm">edit</span>
                            </button>
                            <button class="bg-white/90 dark:bg-black/60 p-2 rounded-full text-red-500 hover:bg-white dark:hover:bg-black/80 transition-colors shadow-sm">
                                <span class="material-symbols-outlined text-sm">delete</span>
                            </button>
                        </div>
                    </div>

                    <div class="p-4 flex-grow flex flex-col">
                        <h3 class="text-lg font-semibold text-foreground-light dark:text-foreground-dark mb-2 line-clamp-1">${recipe.title}</h3>
                        <p class="text-sm text-muted-light dark:text-muted-dark flex-grow line-clamp-3">${recipe.description}</p>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty recipeList}">
                <div class="col-span-full flex flex-col items-center justify-center py-16 text-center">
                    <div class="bg-primary/10 p-6 rounded-full mb-4">
                        <span class="material-symbols-outlined text-primary text-5xl">menu_book</span>
                    </div>
                    <h3 class="text-xl font-bold text-foreground-light dark:text-foreground-dark">No Recipes Yet</h3>
                    <p class="text-muted-light dark:text-muted-dark mt-2 max-w-sm">
                        Create your first recipe to start building your personal cookbook!
                    </p>
                </div>
            </c:if>

        </div>
    </main>
</div>
</body>
</html>