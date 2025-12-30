<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>

<%-- 1. SECURITY CHECK --%>
<%
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sahaayata - Settings</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;700;900&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
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
                        "foreground-dark": "#f0f4f2",
                        "subtle-light": "#dce5df",
                        "subtle-dark": "#2a3c32",
                        "muted-light": "#648772",
                        "muted-dark": "#a0c0b1"
                    },
                    fontFamily: { display: "Work Sans" },
                    borderRadius: { DEFAULT: "0.25rem", lg: "0.5rem", xl: "0.75rem", full: "9999px" }
                }
            }
        };
    </script>
    <style>
        @layer base {
            body {
                @apply font-display bg-background-light text-foreground-light dark:bg-background-dark dark:text-foreground-dark;
            }
        }
        /* Custom Toggle Switch */
        .toggle-checkbox:checked {
            right: 0;
            border-color: #607AFB;
        }
        .toggle-checkbox:checked + .toggle-label {
            background-color: #607AFB;
        }

        /* Readonly Input Styling (Looks like plain text) */
        input[readonly], select[disabled] {
            background-color: transparent;
            border-color: transparent;
            color: inherit;
            cursor: default;
            pointer-events: none; /* Prevents clicking */
        }

        /* Editable Input Styling */
        input:not([readonly]), select:not([disabled]) {
            background-color: white;
            border-color: #e5e7eb;
            cursor: text;
        }
        .dark input:not([readonly]), .dark select:not([disabled]) {
            background-color: #1f2937;
            border-color: #374151;
        }
    </style>
</head>
<body>
<div class="flex min-h-screen">

    <aside class="w-64 bg-background-light dark:bg-background-dark flex flex-col p-4 border-r border-subtle-light dark:border-subtle-dark hidden md:flex">
        <div class="flex items-center gap-2 mb-8">
            <h1 class="text-xl font-bold text-primary">Sahaayata</h1>
        </div>
        <nav class="flex flex-col gap-2 flex-grow">
            <a href="/dashboard" class="flex items-center gap-3 px-3 py-2 rounded-lg text-foreground-light dark:text-foreground-dark hover:bg-primary/20 transition-colors">
                <i class="fa-solid fa-chart-pie w-5"></i> Dashboard
            </a>
            <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-foreground-light dark:text-foreground-dark hover:bg-primary/20 transition-colors">
                <i class="fa-solid fa-carrot w-5"></i> Nutrition
            </a>
            <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-foreground-light dark:text-foreground-dark hover:bg-primary/20 transition-colors">
                <i class="fa-solid fa-dumbbell w-5"></i> Fitness
            </a>
            <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-foreground-light dark:text-foreground-dark hover:bg-primary/20 transition-colors">
                <i class="fa-solid fa-users w-5"></i> Community
            </a>
            <a href="/settings" class="flex items-center gap-3 px-3 py-2 rounded-lg bg-primary/20 text-primary font-bold">
                <i class="fa-solid fa-gear w-5"></i> Settings
            </a>
        </nav>
        <div class="flex flex-col gap-4">
            <a href="/logout" class="flex items-center gap-3 px-3 py-2 rounded-lg text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20">
                <i class="fa-solid fa-right-from-bracket w-5"></i> Logout
            </a>
        </div>
    </aside>

    <main class="flex-1 p-8 overflow-y-auto">
        <div class="max-w-4xl mx-auto">
            <h1 class="text-4xl font-bold mb-2 text-foreground-light dark:text-foreground-dark">Profile & Settings</h1>
            <p class="text-muted-light dark:text-muted-dark mb-8">Manage your account settings and preferences.</p>

            <div class="bg-white dark:bg-subtle-dark p-6 rounded-xl shadow-sm mb-8 flex flex-col md:flex-row items-center gap-6">
                <div class="relative">
                    <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=607AFB&color=fff&size=128"
                         alt="Profile" class="w-24 h-24 rounded-full border-4 border-background-light dark:border-background-dark shadow-md">
                </div>

                <div class="text-center md:text-left flex-1">
                    <h2 class="text-2xl font-bold text-foreground-light dark:text-foreground-dark"><%= user.getUsername() %></h2>
                    <p class="text-muted-light dark:text-muted-dark"><%= user.getEmail() %></p>
                </div>

                <button id="editProfileBtn" onclick="toggleEditMode()" class="border border-subtle-light dark:border-subtle-dark text-foreground-light dark:text-foreground-dark px-4 py-2 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-800 transition">
                    Edit Profile
                </button>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                <div class="lg:col-span-2 space-y-8">

                    <form action="/update-profile" method="POST" id="profileForm">

                        <div class="bg-white dark:bg-subtle-dark p-6 rounded-xl shadow-sm mb-8">
                            <h3 class="text-xl font-bold mb-6 flex items-center gap-2">
                                <i class="fa-regular fa-id-card text-primary"></i> Personal Information
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium mb-1 text-muted-light">Username</label>
                                    <input type="text" name="username" id="inputUsername" value="<%= user.getUsername() %>" readonly
                                           class="w-full rounded-lg px-4 py-2 focus:ring-primary focus:border-primary transition-colors">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium mb-1 text-muted-light">Email Address</label>
                                    <input type="email" name="email" value="<%= user.getEmail() %>" readonly
                                           class="w-full bg-gray-100 dark:bg-gray-800 rounded-lg px-4 py-2 text-gray-500 cursor-not-allowed">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium mb-1 text-muted-light">Phone</label>
                                    <input type="tel" name="phoneNumber" id="inputPhone" value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>" placeholder="+91..." readonly
                                           class="w-full rounded-lg px-4 py-2 focus:ring-primary focus:border-primary transition-colors">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium mb-1 text-muted-light">Gender</label>
                                    <select name="gender" id="inputGender" disabled
                                            class="w-full rounded-lg px-4 py-2 focus:ring-primary focus:border-primary transition-colors appearance-none">
                                        <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                                        <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white dark:bg-subtle-dark p-6 rounded-xl shadow-sm">
                            <h3 class="text-xl font-bold mb-6 flex items-center gap-2">
                                <i class="fa-solid fa-ruler-combined text-primary"></i> Body Stats
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                <div class="bg-background-light dark:bg-background-dark border border-subtle-light rounded-lg p-3 text-center">
                                    <label class="block text-xs text-muted-light mb-1">Weight (kg)</label>
                                    <input type="number" step="0.1" name="weight" id="inputWeight" value="<%= user.getWeight() %>" readonly
                                           class="w-full text-center text-xl font-bold bg-transparent border-none focus:ring-0 p-0 text-foreground-light dark:text-foreground-dark">
                                </div>

                                <div class="bg-background-light dark:bg-background-dark border border-subtle-light rounded-lg p-3 text-center">
                                    <label class="block text-xs text-muted-light mb-1">Height (cm)</label>
                                    <input type="number" step="0.1" name="height" id="inputHeight" value="<%= user.getHeight() %>" readonly
                                           class="w-full text-center text-xl font-bold bg-transparent border-none focus:ring-0 p-0 text-foreground-light dark:text-foreground-dark">
                                </div>

                                <div class="bg-background-light dark:bg-background-dark border border-subtle-light rounded-lg p-3 text-center">
                                    <label class="block text-xs text-muted-light mb-1">Age (yrs)</label>
                                    <input type="number" name="age" id="inputAge" value="<%= user.getAge() %>" readonly
                                           class="w-full text-center text-xl font-bold bg-transparent border-none focus:ring-0 p-0 text-foreground-light dark:text-foreground-dark">
                                </div>
                            </div>

                            <div id="saveBtnContainer" class="mt-6 flex justify-end hidden">
                                <button type="submit" class="bg-primary text-white font-bold py-3 px-6 rounded-lg hover:bg-blue-600 transition-colors shadow-lg shadow-primary/30 w-full md:w-auto">
                                    Save Changes
                                </button>
                            </div>
                        </div>

                    </form>
                </div>

                <div class="space-y-8">

                    <div class="bg-white dark:bg-subtle-dark p-6 rounded-xl shadow-sm">
                        <h3 class="text-xl font-bold mb-6 flex items-center gap-2">
                            <i class="fa-solid fa-sliders text-primary"></i> Preferences
                        </h3>

                        <div class="flex items-center justify-between mb-6">
                            <div>
                                <p class="font-medium">Dark Mode</p>
                                <p class="text-xs text-muted-light">Switch between light and dark themes</p>
                            </div>
                            <div class="relative inline-block w-10 mr-2 align-middle select-none transition duration-200 ease-in">
                                <input type="checkbox" name="toggle" id="darkModeToggle" class="toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4 appearance-none cursor-pointer"/>
                                <label for="darkModeToggle" class="toggle-label block overflow-hidden h-6 rounded-full bg-gray-300 cursor-pointer"></label>
                            </div>
                        </div>

                        <div class="flex items-center justify-between mb-6">
                            <div>
                                <p class="font-medium">Notifications</p>
                                <p class="text-xs text-muted-light">Get daily meal reminders</p>
                            </div>
                            <div class="relative inline-block w-10 mr-2 align-middle select-none transition duration-200 ease-in">
                                <input type="checkbox" name="notif" id="notifToggle" class="toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4 appearance-none cursor-pointer" checked/>
                                <label for="notifToggle" class="toggle-label block overflow-hidden h-6 rounded-full bg-green-400 cursor-pointer"></label>
                            </div>
                        </div>

                        <hr class="border-subtle-light dark:border-subtle-dark my-4">

                        <div class="space-y-2">
                            <a href="#" class="block w-full text-left py-2 px-3 rounded hover:bg-background-light dark:hover:bg-background-dark transition text-sm">
                                Change Password
                            </a>
                            <a href="#" class="block w-full text-left py-2 px-3 rounded hover:bg-background-light dark:hover:bg-background-dark transition text-sm">
                                Privacy Policy
                            </a>
                            <a href="#" class="block w-full text-left py-2 px-3 rounded hover:bg-red-50 text-red-500 transition text-sm font-medium">
                                Delete Account
                            </a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </main>
</div>

<script>
    // --- Dark Mode Logic ---
    const toggle = document.getElementById('darkModeToggle');
    const html = document.documentElement;

    if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        html.classList.add('dark');
        toggle.checked = true;
    } else {
        html.classList.remove('dark');
        toggle.checked = false;
    }

    toggle.addEventListener('change', function() {
        if (this.checked) {
            html.classList.add('dark');
            localStorage.theme = 'dark';
        } else {
            html.classList.remove('dark');
            localStorage.theme = 'light';
        }
    });

    // --- Edit Profile Logic (Toggle Readonly/Disabled) ---
    function toggleEditMode() {
        // IDs of all editable fields
        const fields = [
            'inputUsername', 'inputPhone', 'inputWeight', 'inputHeight', 'inputAge'
        ];
        const genderSelect = document.getElementById('inputGender');
        const saveBtnContainer = document.getElementById('saveBtnContainer');
        const editBtn = document.getElementById('editProfileBtn');

        // Check if currently editable (if username field has no readonly attribute)
        const isEditable = !document.getElementById('inputUsername').hasAttribute('readonly');

        if (!isEditable) {
            // -- SWITCH TO EDIT MODE --

            // 1. Unlock Inputs
            fields.forEach(id => {
                const el = document.getElementById(id);
                if(el) {
                    el.removeAttribute('readonly');
                    el.style.pointerEvents = "auto"; // Enable clicking
                }
            });

            // 2. Unlock Select
            genderSelect.removeAttribute('disabled');
            genderSelect.style.pointerEvents = "auto";

            // 3. UI Updates
            saveBtnContainer.classList.remove('hidden'); // Show Save
            editBtn.textContent = 'Cancel'; // Change Button text
            editBtn.classList.add('bg-red-50', 'text-red-600', 'border-red-200'); // Style for Cancel

            // Focus on first field
            document.getElementById('inputUsername').focus();

        } else {
            // -- SWITCH TO LOCKED MODE (CANCEL) --

            // 1. Lock Inputs
            fields.forEach(id => {
                const el = document.getElementById(id);
                if(el) {
                    el.setAttribute('readonly', 'true');
                    el.style.pointerEvents = "none";
                }
            });

            // 2. Lock Select
            genderSelect.setAttribute('disabled', 'true');
            genderSelect.style.pointerEvents = "none";

            // 3. UI Updates
            saveBtnContainer.classList.add('hidden'); // Hide Save
            editBtn.textContent = 'Edit Profile'; // Reset Text
            editBtn.classList.remove('bg-red-50', 'text-red-600', 'border-red-200'); // Reset Style

            // Optional: You could reload the page here to reset values to DB values
            window.location.reload();
        }
    }
</script>

</body>
</html>