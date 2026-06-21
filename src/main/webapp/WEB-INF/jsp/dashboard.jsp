<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sahaayata.minorproject.model.UserCredential" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("/login");
        return;
    }

    double bmr = "Male".equalsIgnoreCase(user.getGender())
            ? (10 * user.getWeight()) + (6.25 * user.getHeight()) - (5 * user.getAge()) + 5
            : (10 * user.getWeight()) + (6.25 * user.getHeight()) - (5 * user.getAge()) - 161;

    double activityMultiplier = 1.2;
    try {
        activityMultiplier = Double.parseDouble(user.getActivityLevel());
    } catch (Exception e) {
    }

    int tdee = (int) (bmr * activityMultiplier);

    // YAHAN HUMNE DYNAMIC DATA FETCH KIYA HAI
    Integer consumedAttr = (Integer) request.getAttribute("consumedCalories");
    int consumed = (consumedAttr != null) ? consumedAttr : 0;

    // --- NAYE MACRO VARIABLES YAHAN ADD KIYE HAIN ---
    Integer protAttr = (Integer) request.getAttribute("consumedProtein");
    int consumedProtein = (protAttr != null) ? protAttr : 0;

    Integer carbAttr = (Integer) request.getAttribute("consumedCarbs");
    int consumedCarbs = (carbAttr != null) ? carbAttr : 0;

    Integer fatAttr = (Integer) request.getAttribute("consumedFats");
    int consumedFats = (fatAttr != null) ? fatAttr : 0;

    Integer bCalsAttr = (Integer) request.getAttribute("breakfastCals");
    int breakfastCals = (bCalsAttr != null) ? bCalsAttr : 0;

    Integer lCalsAttr = (Integer) request.getAttribute("lunchCals");
    int lunchCals = (lCalsAttr != null) ? lCalsAttr : 0;

    Integer dCalsAttr = (Integer) request.getAttribute("dinnerCals");
    int dinnerCals = (dCalsAttr != null) ? dCalsAttr : 0;

    Integer sCalsAttr = (Integer) request.getAttribute("snacksCals");
    int snacksCals = (sCalsAttr != null) ? sCalsAttr : 0;
    // ------------------------------------------------

    int remaining = tdee - consumed; // Ab ye dynamic h

    // TARGET GOALS
    int proteinGoal = (int) (tdee * 0.3 / 4);
    int carbGoal = (int) (tdee * 0.4 / 4);
    int fatGoal = (int) (tdee * 0.3 / 9);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Dashboard | Sahaayata</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=DM+Sans:wght@600;700&display=swap" rel="stylesheet"/>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <!-- Tailwind CSS (for partial usage and consistency) -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <style>
        .ai-gradient-text {
            background: linear-gradient(135deg, #0058be 0%, #006c49 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        :root {
            --primary: #0058be;
            --primary-light: #d8e2ff;
            --primary-dark: #004395;
            --sidebar-width: 240px;
            --sidebar-bg: #f8fafc;
            --sidebar-border: rgba(194, 198, 214, 0.3);
            --text-main: #131b2e;
            --text-muted: #424754;
            --text-light: #727785;
            --bg-page: #faf8ff;
            --bg-card: #ffffff;
            --nav-hover: #f2f3ff;
            --nav-active-bg: #d8e2ff;
            --nav-active-text: #0058be;
            --radius: 12px;
            --font: 'Inter', system-ui, sans-serif;
        }

        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: var(--font);
            background: var(--bg-page);
            color: var(--text-main);
            min-height: 100vh;
        }

        .app-layout {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: var(--sidebar-width);
            background: var(--sidebar-bg);
            border-right: 1px solid var(--sidebar-border);
            display: flex;
            flex-direction: column;
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            z-index: 100;
            transition: transform .25s ease;
            overflow-y: auto;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 20px 20px 16px;
            border-bottom: 1px solid var(--sidebar-border);
            color: var(--primary);
        }

        .brand-icon {
            width: 26px;
            height: 26px;
        }

        .brand-name {
            font-size: 17px;
            font-weight: 700;
            color: var(--text-main);
            letter-spacing: -.3px;
        }

        .sidebar-user {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 14px 20px;
            border-bottom: 1px solid var(--sidebar-border);
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
        }

        .user-name {
            font-size: 13px;
            font-weight: 600;
        }

        .user-role {
            font-size: 11px;
            color: var(--text-light);
        }

        .sidebar-nav {
            flex: 1;
            padding: 14px 12px;
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .nav-section {
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .08em;
            color: var(--text-light);
            padding: 8px 8px 6px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 9px 10px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--text-muted);
            font-size: 13.5px;
            font-weight: 500;
            transition: background .15s, color .15s;
        }

        .nav-link:hover {
            background: var(--nav-hover);
            color: var(--text-main);
        }

        .nav-link.active {
            background: var(--nav-active-bg);
            color: var(--nav-active-text);
            font-weight: 600;
        }

        .nav-icon {
            width: 16px;
            height: 16px;
            flex-shrink: 0;
        }

        .sidebar-footer {
            padding: 12px;
            border-top: 1px solid var(--sidebar-border);
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 9px 10px;
            border-radius: 8px;
            border: none;
            background: none;
            color: #ef4444;
            font-size: 13.5px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: background .15s;
            width: 100%;
        }

        .logout-btn:hover {
            background: #FEF2F2;
        }

        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .topbar {
            background: var(--bg-card);
            border-bottom: 1px solid var(--sidebar-border);
            padding: 0 24px;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .topbar-title {
            font-size: 16px;
            font-weight: 600;
        }

        .hamburger {
            display: none;
            background: none;
            border: none;
            cursor: pointer;
            color: var(--text-main);
        }

        .page-body {
            flex: 1;
            padding: 16px 24px;
        }

        .card {
            background: var(--bg-card);
            border: 1px solid var(--sidebar-border);
            border-radius: var(--radius);
            padding: 14px;
            box-shadow: 0px 4px 16px rgba(15, 23, 42, 0.03);
        }

        .card-title {
            font-size: 13.5px;
            font-weight: 600;
            margin-bottom: 16px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: .04em;
        }

        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
            margin-bottom: 16px;
        }

        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--sidebar-border);
            border-radius: var(--radius);
            padding: 14px 18px;
            box-shadow: 0px 4px 16px rgba(15, 23, 42, 0.03);
        }

        .stat-label {
            font-size: 11.5px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .05em;
            color: var(--text-light);
            margin-bottom: 6px;
        }

        .stat-value {
            font-size: 26px;
            font-weight: 700;
            color: var(--text-main);
            line-height: 1;
        }

        .stat-sub {
            font-size: 12px;
            color: var(--text-light);
            margin-top: 4px;
        }

        .stat-accent {
            color: var(--primary);
        }

        .main-grid {
            display: grid;
            grid-template-columns: 1fr 310px;
            gap: 16px;
        }

        .ring-wrap {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
            padding: 4px 0;
        }

        .ring-container {
            position: relative;
            width: 160px;
            height: 160px;
        }

        .ring-label {
            position: absolute;
            inset: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .ring-num {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary);
        }

        .ring-sub {
            font-size: 11.5px;
            color: var(--text-light);
        }

        .progress-ring__circle {
            transition: stroke-dashoffset .4s;
            transform: rotate(-90deg);
            transform-origin: 50% 50%;
        }

        .macro-item {
            margin-bottom: 12px;
        }

        .macro-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        .macro-name {
            font-size: 13px;
            font-weight: 500;
        }

        .macro-val {
            font-size: 12px;
            color: var(--text-light);
        }

        .progress-bar-bg {
            height: 6px;
            background: #E8EAED;
            border-radius: 99px;
        }

        .progress-bar {
            height: 6px;
            background: var(--primary);
            border-radius: 99px;
            transition: width 0.4s ease;
        }

        .filter-container {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }

        .filter-btn {
            padding: 6px 12px;
            border-radius: 20px;
            border: 1px solid var(--sidebar-border);
            background: var(--bg-page);
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-btn:hover {
            background: #E8EAED;
        }

        .filter-btn.active {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: #fff;
            border-color: transparent;
            box-shadow: 0 4px 10px rgba(5, 150, 105, 0.25);
        }

        .meal-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 12px;
            border-radius: 8px;
            background: var(--bg-page);
            margin-bottom: 6px;
            transition: transform 0.2s;
            border: 1px solid transparent;
        }

        .meal-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
        }

        .meal-name {
            font-size: 13.5px;
            font-weight: 600;
            color: var(--text-main);
        }

        .meal-cal {
            font-size: 12px;
            color: var(--text-light);
            margin-top: 4px;
            line-height: 1.4;
        }

        .btn-add {
            font-size: 12.5px;
            font-weight: 600;
            color: #fff;
            background: linear-gradient(135deg, #0058be 0%, #004395 100%);
            border: none;
            cursor: pointer;
            padding: 6px 14px;
            border-radius: 6px;
            box-shadow: 0 4px 12px rgba(0, 88, 190, 0.2);
            transition: all 0.2s ease;
        }

        .btn-add:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(0, 88, 190, 0.3);
        }

        .btn-generate-full {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 13.5px;
            font-weight: 600;
            color: #fff;
            background: linear-gradient(135deg, #0058be 0%, #006c49 100%);
            border: none;
            cursor: pointer;
            padding: 12px;
            border-radius: 8px;
            box-shadow: 0 6px 16px rgba(0, 88, 190, 0.25);
            transition: all 0.2s ease;
            margin-top: 8px;
        }

        .btn-generate-full:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 88, 190, 0.35);
        }

        .sidebar-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, .35);
            z-index: 99;
        }

        @media (max-width: 900px) {
            .stats-row {
                grid-template-columns: 1fr 1fr;
            }

            .main-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.open {
                transform: translateX(0);
            }

            .sidebar-overlay.show {
                display: block;
            }

            .main-content {
                margin-left: 0;
            }

            .hamburger {
                display: flex;
            }

            .page-body {
                padding: 14px;
            }

            .stats-row {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 480px) {
            .stats-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="app-layout">

    <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand" style="gap: 0px;">
            <img src="/images/logo.svg" alt="Sahaayata Logo" style="height: 48px; width: auto; object-fit: contain; margin-left: -8px;">
            <span class="brand-name ai-gradient-text" style="font-family: 'DM Sans', sans-serif; font-size: 24px; margin-left: -4px;">Sahaayata</span>
        </div>

        <div class="sidebar-user">
            <img class="user-avatar"
                 src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=0058be&color=fff&size=80"
                 alt="avatar"/>
            <div>
                <p class="user-name"><%= user.getUsername() %>
                </p>
                <p class="user-role">Member</p>
            </div>
        </div>

        <nav class="sidebar-nav">
            <p class="nav-section">Main</p>
            <a href="/dashboard" class="nav-link active">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="3" y="3" width="7" height="7" rx="1"/>
                    <rect x="14" y="3" width="7" height="7" rx="1"/>
                    <rect x="14" y="14" width="7" height="7" rx="1"/>
                    <rect x="3" y="14" width="7" height="7" rx="1"/>
                </svg>
                Dashboard
            </a>
            <a href="/log-meal" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="12" cy="12" r="9"/>
                    <path d="M12 8v8M8 12h8"/>
                </svg>
                Log Meal
            </a>
            <a href="/my-recipes" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/>
                    <rect x="9" y="3" width="6" height="4" rx="1"/>
                    <path d="M9 12h6M9 16h4"/>
                </svg>
                My Recipes
            </a>
            <a href="/community" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/>
                </svg>
                Community
            </a>
            <p class="nav-section" style="margin-top:1.25rem;">Account</p>
            <a href="/settings" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="12" cy="12" r="3"/>
                    <path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/>
                </svg>
                Settings
            </a>
            <a href="/change-password" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="3" y="11" width="18" height="11" rx="2"/>
                    <path d="M7 11V7a5 5 0 0110 0v4"/>
                </svg>
                Change Password
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="/logout" class="logout-btn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="15" height="15">
                    <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/>
                </svg>
                Logout
            </a>
        </div>
    </aside>
    <div class="sidebar-overlay" id="overlay" onclick="toggleSidebar()"></div>

    <div class="main-content">
        <header class="topbar">
            <div style="display:flex;align-items:center;gap:12px;">
                <button class="hamburger" onclick="toggleSidebar()" aria-label="Menu">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 12h18M3 6h18M3 18h18"/>
                    </svg>
                </button>
                <span class="topbar-title">Dashboard</span>
            </div>
            <div style="display:flex;align-items:center;gap:10px;">
                <span style="font-size:13px;color:var(--text-light);">Today, <%= new java.text.SimpleDateFormat("MMM d").format(new java.util.Date()) %></span>
                <a href="/settings">
                    <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=0058be&color=fff&size=80"
                         width="32" height="32" style="border-radius:50%;" alt="avatar"/>
                </a>
            </div>
        </header>

        <div class="page-body">

            <div class="stats-row">
                <div class="stat-card">
                    <p class="stat-label">Daily Target</p>
                    <p class="stat-value stat-accent"><%= tdee %>
                    </p>
                    <p class="stat-sub">kcal / day</p>
                </div>
                <div class="stat-card">
                    <p class="stat-label">Consumed</p>
                    <p class="stat-value"><%= consumed %>
                    </p>
                    <p class="stat-sub">kcal today</p>
                </div>
                <div class="stat-card">
                    <p class="stat-label">Remaining</p>
                    <p class="stat-value" style="color:#10b981;"><%= remaining %>
                    </p>
                    <p class="stat-sub">kcal left</p>
                </div>
            </div>

            <div class="main-grid">

                <div style="display:flex;flex-direction:column;gap:14px;">
                    <div class="card">
                        <p class="card-title">Calorie Progress</p>
                        <div class="ring-wrap">
                            <div class="ring-container">
                                <svg width="160" height="160" viewBox="0 0 160 160">
                                    <circle cx="80" cy="80" r="68" fill="none" stroke="#E8EAED" stroke-width="12"/>
                                    <circle id="calorie-ring" cx="80" cy="80" r="68" fill="none" stroke="#0058be"
                                            stroke-width="12" stroke-linecap="round" stroke-dasharray="427.26"
                                            stroke-dashoffset="427.26" class="progress-ring__circle"/>
                                </svg>
                                <div class="ring-label">
                                    <span class="ring-num"><%= consumed %></span>
                                    <span class="ring-sub">/ <%= tdee %> kcal</span>
                                </div>
                            </div>
                            <p style="font-size:13px;color:var(--text-light);text-align:center;">Log meals to see your
                                progress!</p>
                        </div>
                    </div>

                    <div class="card">
                        <p class="card-title">Macronutrient Goals</p>
                        <div class="macro-item">
                            <div class="macro-header">
                                <span class="macro-name">Protein</span>
                                <span class="macro-val"><%= consumedProtein %>g / <%= proteinGoal %>g</span>
                            </div>
                            <div class="progress-bar-bg">
                                <div class="progress-bar" style="width:<%= Math.min((consumedProtein * 100.0) / (proteinGoal == 0 ? 1 : proteinGoal), 100) %>%;"></div>
                            </div>
                        </div>
                        <div class="macro-item">
                            <div class="macro-header">
                                <span class="macro-name">Carbohydrates</span>
                                <span class="macro-val"><%= consumedCarbs %>g / <%= carbGoal %>g</span>
                            </div>
                            <div class="progress-bar-bg">
                                <div class="progress-bar" style="width:<%= Math.min((consumedCarbs * 100.0) / (carbGoal == 0 ? 1 : carbGoal), 100) %>%;background:#f59e0b;"></div>
                            </div>
                        </div>
                        <div class="macro-item" style="margin-bottom:0;">
                            <div class="macro-header">
                                <span class="macro-name">Fats</span>
                                <span class="macro-val"><%= consumedFats %>g / <%= fatGoal %>g</span>
                            </div>
                            <div class="progress-bar-bg">
                                <div class="progress-bar" style="width:<%= Math.min((consumedFats * 100.0) / (fatGoal == 0 ? 1 : fatGoal), 100) %>%;background:#10b981;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card" style="align-self:start;">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 8px;">
                        <p class="card-title" style="margin:0;">TODAY'S MEALS</p>
                        <span style="font-size: 11px; background: var(--primary-light); color: var(--primary); padding: 4px 10px; border-radius: 12px; font-weight: 600;">For <%= remaining %> kcal</span>
                    </div>

                    <p style="font-size: 13px; color: var(--text-muted); margin-bottom: 8px;">Select a goal to get
                        filtered suggestions:</p>

                    <div class="filter-container">
                        <button class="filter-btn active" onclick="setFilter('High Protein', event)">High Protein
                        </button>
                        <button class="filter-btn" onclick="setFilter('Low Carb', event)">Low Carb</button>
                        <button class="filter-btn" onclick="setFilter('Low Fat', event)">Low Fat</button>
                        <button class="filter-btn" onclick="setFilter('Weight Loss', event)">Weight Loss</button>
                        <button class="filter-btn" onclick="setFilter('Muscle Gain', event)">Muscle Gain</button>
                    </div>

                    <div style="margin-top: 16px;">
                        <div class="meal-item">
                            <div><p class="meal-name">Breakfast</p>
                                <p class="meal-cal"><%= breakfastCals %> kcal logged</p></div>
                            <button class="btn-add" id="btn-add-breakfast"
                                    onclick="window.location.href='/log-meal?meal=Breakfast&amp;filter=High%20Protein'">+
                                Add
                            </button>
                        </div>
                        <div class="meal-item">
                            <div><p class="meal-name">Lunch</p>
                                <p class="meal-cal"><%= lunchCals %> kcal logged</p></div>
                            <button class="btn-add" id="btn-add-lunch"
                                    onclick="window.location.href='/log-meal?meal=Lunch&amp;filter=High%20Protein'">+ Add
                            </button>
                        </div>
                        <div class="meal-item">
                            <div><p class="meal-name">Dinner</p>
                                <p class="meal-cal"><%= dinnerCals %> kcal logged</p></div>
                            <button class="btn-add" id="btn-add-dinner"
                                    onclick="window.location.href='/log-meal?meal=Dinner&amp;filter=High%20Protein'">+ Add
                            </button>
                        </div>
                        <div class="meal-item">
                            <div><p class="meal-name">Snacks</p>
                                <p class="meal-cal"><%= snacksCals %> kcal logged</p></div>
                            <button class="btn-add" id="btn-add-snacks"
                                    onclick="window.location.href='/log-meal?meal=Snacks&amp;filter=High%20Protein'">+ Add
                            </button>
                        </div>
                    </div>

                    <button class="btn-generate-full" onclick="goToGeneratePage()">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="2">
                            <path d="M12 2v4M12 18v4M4.93 4.93l2.83 2.83M16.24 16.24l2.83 2.83M2 12h4M18 12h4M4.93 19.07l2.83-2.83M16.24 7.76l2.83-2.83"/>
                        </svg>
                        Suggest Full Meal Plan
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    /* Sahaayata Custom UI Variables for n8n Chat */
    :root {
        /* 1. Main Colors (Blue instead of Pink/Navy) */
        --chat--color-primary: #0058be !important;
        --chat--color-secondary: #004395 !important;

        /* 2. Chat Window Shape & Shadow (Modern UI) */

        .chat-window {
            border-radius: 16px !important;
            border: 1.5px solid #94a3b8 !important;
            box-shadow: 0px 15px 40px rgba(0, 0, 0, 0.22) !important;
        }

        /* 3. Header Styling (Blue Gradient instead of Black) */
        --chat--header--background: linear-gradient(135deg, #0058be, #006c49) !important;
        --chat--header--color: #ffffff !important;

        /* 4. Message Bubbles (Rounded & Soft) */
        --chat--message--border-radius: 12px !important;
        --chat--message--background--user: #0058be !important;
        --chat--message--color--user: #ffffff !important;
        --chat--message--background--bot: #f2f3ff !important;
        --chat--message--color--bot: #131b2e !important;

        /* 5. The Floating Toggle Button */
        --chat--toggle--background: #0058be !important;
        --chat--toggle--hover--background: #004395 !important;
    }

    .chat-window {
        border: 1px solid #e2e8f0 !important;
    }

    .chat-toggle {
        box-shadow: 0 4px 15px rgba(88, 118, 237, 0.4) !important;
    }
</style>

<link href="https://cdn.jsdelivr.net/npm/@n8n/chat/dist/style.css" rel="stylesheet"/>
<script type="module">
    import {createChat} from 'https://cdn.jsdelivr.net/npm/@n8n/chat/dist/chat.bundle.es.js';

    createChat({
        // YAHAN PAR BHI SAME GLOBAL VARIABLE USE KIYA HAI
        webhookUrl: '${n8nWebhookUrl}/webhook/60bfc1fe-7834-4dc2-a299-5145e4920cbd/chat',

        initialMessages: [
            'Welcome to Sahaayata! 🥗',
            'I am your AI Dietician. Tell me your dietary goals (like Weight Loss or Muscle Gain)!'
        ],

        i18n: {
            en: {
                title: 'Sahaayata AI',
                subtitle: 'Your Personal Dietician',
                getStarted: 'Start Chat',
                inputPlaceholder: 'Type your goal here...',
            },
        },

        showWelcomeScreen: true,

        theme: {
            color: {
                primary: '#0058be'
            }
        }
    });
</script>

<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('open');
        document.getElementById('overlay').classList.toggle('show');
    }

    const ring = document.getElementById('calorie-ring');
    const consumed = Number("<%= consumed %>");
    const target = Number("<%= tdee %>");
    const percent = Math.min(consumed / target, 1);
    ring.style.strokeDashoffset = 427.26 - percent * 427.26;

    let currentFilter = 'High Protein';

    function setFilter(filterType, event) {
        document.querySelectorAll('.filter-btn').forEach(function (btn) {
            btn.classList.remove('active');
        });
        event.target.classList.add('active');
        currentFilter = filterType;

        const encodedFilter = encodeURIComponent(currentFilter);
        document.getElementById('btn-add-breakfast').onclick = function () {
            window.location.href = '/log-meal?meal=Breakfast&filter=' + encodedFilter;
        };
        document.getElementById('btn-add-lunch').onclick = function () {
            window.location.href = '/log-meal?meal=Lunch&filter=' + encodedFilter;
        };
        document.getElementById('btn-add-dinner').onclick = function () {
            window.location.href = '/log-meal?meal=Dinner&filter=' + encodedFilter;
        };
        document.getElementById('btn-add-snacks').onclick = function () {
            window.location.href = '/log-meal?meal=Snacks&filter=' + encodedFilter;
        };
    }

    function goToGeneratePage() {
        const remainingCals = Number("<%= remaining %>");
        window.location.href = '/generate-plan?filter=' + encodeURIComponent(currentFilter) + '&target=' + remainingCals;
    }
</script>
</body>
</html>