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

    // Error message fetch karna (agar controller se aaya ho)
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Sahaayata - Set New Password</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;700&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#607AFB",
                        "background-light": "#f5f6f8",
                        "background-dark": "#0f1323",
                        "foreground-light": "#111714",
                        "foreground-dark": "#f6f8f7",
                        "card-light": "#ffffff",
                        "card-dark": "#1a2e22",
                        "input-light": "#f0f4f2",
                        "input-dark": "#1f3a2c",
                        "subtle-light": "#648772",
                        "subtle-dark": "#a0c0b0"
                    },
                    fontFamily: {display: "Work Sans"},
                    borderRadius: {DEFAULT: "0.25rem", lg: "0.5rem", xl: "0.75rem", full: "9999px"}
                }
            }
        };
    </script>
    <style>
        .font-display { font-family: 'Work Sans', sans-serif; }
    </style>
</head>
<body class="font-display bg-background-light dark:bg-background-dark text-foreground-light dark:text-foreground-dark">
<div class="flex flex-col min-h-screen">

    <header class="border-b border-primary/20 dark:border-primary/30 bg-card-light/80 dark:bg-card-dark/80 backdrop-blur-sm">
        <nav class="container mx-auto px-6 py-4 flex justify-between items-center">
            <div class="flex items-center gap-3">
                <svg class="h-8 w-8 text-primary" fill="none" viewbox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                    <path clip-rule="evenodd" d="M24 4H6V17.3333V30.6667H24V44H42V30.6667V17.3333H24V4Z" fill="currentColor" fill-rule="evenodd"></path>
                </svg>
                <h1 class="text-xl font-bold text-foreground-light dark:text-foreground-dark">Sahaayata</h1>
            </div>

            <div class="hidden md:flex items-center space-x-8">
                <a class="text-sm font-medium hover:text-primary transition-colors" href="/dashboard">Dashboard</a>
                <a class="text-sm font-medium hover:text-primary transition-colors" href="/settings">Settings</a>
            </div>

            <div class="flex items-center space-x-4">
                <a href="/settings">
                    <div class="w-10 h-10 rounded-full bg-cover bg-center border border-primary/30"
                         style='background-image: url("https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=607AFB&color=fff");'>
                    </div>
                </a>
            </div>
        </nav>
    </header>

    <main class="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="w-full max-w-md space-y-8">
            <div class="bg-card-light dark:bg-card-dark p-8 shadow-xl rounded-xl border border-gray-100 dark:border-gray-800">
                <div class="text-center">
                    <h2 class="text-3xl font-bold text-foreground-light dark:text-foreground-dark">Set a New Password</h2>
                    <p class="mt-2 text-sm text-subtle-light dark:text-subtle-dark">
                        Your new password must be strong and different from previous ones.
                    </p>
                </div>

                <% if (error != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mt-4" role="alert">
                    <span class="block sm:inline"><%= error %></span>
                </div>
                <% } %>

                <form action="/change-password" class="mt-8 space-y-6" method="POST">
                    <div class="space-y-4">
                        <div>
                            <label class="sr-only" for="new-password">New Password</label>
                            <input class="w-full px-4 py-3 bg-input-light dark:bg-input-dark border-2 border-transparent focus:ring-2 focus:ring-primary focus:border-primary rounded-lg placeholder-subtle-light dark:placeholder-subtle-dark transition outline-none"
                                   id="new-password" name="new-password" placeholder="New Password" required type="password"/>
                        </div>
                        <div>
                            <label class="sr-only" for="confirm-password">Confirm New Password</label>
                            <input class="w-full px-4 py-3 bg-input-light dark:bg-input-dark border-2 border-transparent focus:ring-2 focus:ring-primary focus:border-primary rounded-lg placeholder-subtle-light dark:placeholder-subtle-dark transition outline-none"
                                   id="confirm-password" name="confirm-password" placeholder="Confirm New Password" required type="password"/>
                        </div>
                    </div>
                    <div>
                        <button class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-bold rounded-lg text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-all duration-300 ease-in-out shadow-lg shadow-primary/30" type="submit">
                            Set New Password
                        </button>
                    </div>

                    <div class="text-center mt-4">
                        <a href="/settings" class="text-sm text-subtle-light hover:text-primary transition-colors">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>
</body>
</html>