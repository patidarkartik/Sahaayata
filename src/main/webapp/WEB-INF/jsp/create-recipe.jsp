<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>

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
    <title>Sahaayata - Create Recipe</title>
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#607AFB",
                        "background-light": "#f5f6f8",
                        "background-dark": "#0f1323"
                    },
                    fontFamily: {display: "Work Sans"},
                    borderRadius: {DEFAULT: "0.25rem", lg: "0.5rem", xl: "0.75rem", full: "9999px"}
                }
            }
        };
    </script>
    <style>
        .toggle-checkbox:checked {
            right: 0.125rem;
            left: auto;
        }
        .toggle-checkbox:checked + .toggle-label {
            background-color: #607AFB; /* Using Primary Color */
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-gray-900 dark:text-gray-100">
<div class="flex flex-col min-h-screen">

    <header class="bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-sm sticky top-0 z-10 border-b border-gray-200 dark:border-gray-800">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <div class="flex items-center gap-4">
                    <svg class="h-6 w-6 text-primary" fill="none" viewbox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                        <path clip-rule="evenodd" d="M24 4H6V17.3333V30.6667H24V44H42V30.6667V17.3333H24V4Z" fill="currentColor" fill-rule="evenodd"></path>
                    </svg>
                    <h2 class="text-xl font-bold">Sahaayata</h2>
                </div>
                <nav class="hidden md:flex items-center gap-6">
                    <a class="text-sm font-medium hover:text-primary transition-colors" href="/dashboard">Dashboard</a>
                    <a class="text-sm font-medium hover:text-primary transition-colors" href="/my-recipes">My Recipes</a>
                    <a class="text-sm font-bold text-primary" href="#">Create</a>
                    <a class="text-sm font-medium hover:text-primary transition-colors" href="/community">Community</a>
                </nav>
                <div class="flex items-center gap-4">
                    <a href="/settings">
                        <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=607AFB&color=fff"
                             class="w-10 h-10 rounded-full border border-primary/30" alt="Profile"/>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="max-w-2xl mx-auto">
            <div class="mb-8">
                <h1 class="text-4xl font-bold">Create a New Recipe

                    [Image of Recipe Book]
                </h1>
                <p class="mt-2 opacity-70">Share your culinary creations with the Sahaayata community.</p>
            </div>

            <form action="/save-recipe" method="POST" class="space-y-6">

                <div class="grid grid-cols-1 gap-6">

                    <label class="block">
                        <span class="text-sm font-medium mb-2 block">Recipe Name</span>
                        <input name="title" required
                               class="block w-full rounded-lg border-transparent bg-gray-100 dark:bg-gray-800 focus:border-primary focus:ring-primary placeholder-gray-400 text-gray-900 dark:text-gray-100"
                               placeholder="e.g., Green Power Smoothie" type="text"/>
                    </label>

                    <label class="block">
                        <span class="text-sm font-medium mb-2 block">Description & Instructions</span>
                        <textarea name="description" required
                                  class="block w-full rounded-lg border-transparent bg-gray-100 dark:bg-gray-800 focus:border-primary focus:ring-primary h-32 resize-none placeholder-gray-400 text-gray-900 dark:text-gray-100"
                                  placeholder="Describe your recipe, steps, and ingredients here..."></textarea>
                    </label>

                    <label class="block">
                        <span class="text-sm font-medium mb-2 block">Image URL (Optional)</span>
                        <input name="imageUrl"
                               class="block w-full rounded-lg border-transparent bg-gray-100 dark:bg-gray-800 focus:border-primary focus:ring-primary placeholder-gray-400 text-gray-900 dark:text-gray-100"
                               placeholder="https://example.com/food-image.jpg" type="url"/>
                        <p class="text-xs mt-1 opacity-60">Paste a link to an image of your food.</p>
                    </label>
                </div>

                <div class="border-t border-gray-200 dark:border-gray-700 pt-6">
                    <h3 class="text-lg font-bold mb-2">Ingredients</h3>
                    <p class="text-sm opacity-70 mb-4">Please list your ingredients inside the description box above for now.</p>

                    <div class="flex items-center gap-4 p-3 rounded-lg bg-gray-100 dark:bg-gray-800 opacity-60">
                        <div class="w-12 h-12 rounded-lg bg-gray-300 flex items-center justify-center text-xl">🥗</div>
                        <div class="flex-1">
                            <p class="font-medium">Ingredients List</p>
                            <p class="text-sm">Will be auto-detected from description.</p>
                        </div>
                    </div>
                </div>

                <div class="border-t border-gray-200 dark:border-gray-700 pt-6">
                    <div class="flex justify-between items-center bg-gray-100 dark:bg-gray-800 p-4 rounded-lg">
                        <div>
                            <p class="font-bold">Make Public</p>
                            <p class="text-sm opacity-70">Share your recipe with the community.</p>
                        </div>
                        <div class="relative flex items-center">
                            <input class="absolute w-full h-full opacity-0 cursor-pointer toggle-checkbox peer" id="public-toggle" type="checkbox" checked/>
                            <label class="toggle-label relative block w-12 h-7 rounded-full bg-gray-300 dark:bg-gray-600 transition-colors cursor-pointer" for="public-toggle"></label>
                            <div class="absolute left-1 top-1 w-5 h-5 bg-white rounded-full shadow-md transition-transform peer-checked:translate-x-full pointer-events-none"></div>
                        </div>
                    </div>
                </div>

                <div class="pt-6">
                    <button type="submit"
                            class="w-full bg-primary text-white font-bold py-3 px-4 rounded-lg hover:bg-blue-600 transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary shadow-lg">
                        Create Recipe
                    </button>
                    <div class="text-center mt-4">
                        <a href="/my-recipes" class="text-sm hover:text-primary opacity-70">Cancel</a>
                    </div>
                </div>

            </form>
        </div>
    </main>
</div>
</body>
</html>