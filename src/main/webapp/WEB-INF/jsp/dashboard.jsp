<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    userCredential user = (userCredential) session.getAttribute("loggedInUser");
    if (user == null) { response.sendRedirect("/login"); return; }

    double bmr = "Male".equalsIgnoreCase(user.getGender())
            ? (10 * user.getWeight()) + (6.25 * user.getHeight()) - (5 * user.getAge()) + 5
            : (10 * user.getWeight()) + (6.25 * user.getHeight()) - (5 * user.getAge()) - 161;

    double activityMultiplier = 1.2;
    try { activityMultiplier = Double.parseDouble(user.getActivityLevel()); } catch (Exception e) {}
    int tdee = (int)(bmr * activityMultiplier);
    int consumed = 0;
    int remaining = tdee - consumed;
    int proteinGoal = (int)(tdee * 0.3 / 4);
    int carbGoal    = (int)(tdee * 0.4 / 4);
    int fatGoal     = (int)(tdee * 0.3 / 9);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dashboard — Sahaayata</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        /* ---- base reset & variables ---- */
        :root {
            --primary: #4F6FEB; --primary-light: #EEF1FD; --primary-dark: #3451C7;
            --sidebar-width: 240px; --sidebar-bg: #fff; --sidebar-border: #E8EAED;
            --text-main: #1a1d23; --text-muted: #6b7280; --text-light: #9ca3af;
            --bg-page: #F4F6FB; --bg-card: #fff;
            --nav-hover: #F4F6FB; --nav-active-bg: #EEF1FD; --nav-active-text: #4F6FEB;
            --radius: 10px; --font: 'DM Sans', system-ui, sans-serif;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: var(--font); background: var(--bg-page); color: var(--text-main); min-height: 100vh; }

        /* ---- layout ---- */
        .app-layout { display: flex; min-height: 100vh; }

        /* ---- sidebar ---- */
        .sidebar {
            width: var(--sidebar-width); background: var(--sidebar-bg);
            border-right: 1px solid var(--sidebar-border);
            display: flex; flex-direction: column;
            position: fixed; top: 0; left: 0; bottom: 0; z-index: 100;
            transition: transform .25s ease; overflow-y: auto;
        }
        .sidebar-brand {
            display: flex; align-items: center; gap: 10px;
            padding: 20px 20px 16px; border-bottom: 1px solid var(--sidebar-border); color: var(--primary);
        }
        .brand-icon { width: 26px; height: 26px; }
        .brand-name { font-size: 17px; font-weight: 700; color: var(--text-main); letter-spacing: -.3px; }
        .sidebar-user {
            display: flex; align-items: center; gap: 10px;
            padding: 14px 20px; border-bottom: 1px solid var(--sidebar-border);
        }
        .user-avatar { width: 36px; height: 36px; border-radius: 50%; }
        .user-name { font-size: 13px; font-weight: 600; }
        .user-role { font-size: 11px; color: var(--text-light); }
        .sidebar-nav { flex: 1; padding: 14px 12px; display: flex; flex-direction: column; gap: 2px; }
        .nav-section { font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: .08em; color: var(--text-light); padding: 8px 8px 6px; }
        .nav-link {
            display: flex; align-items: center; gap: 10px; padding: 9px 10px;
            border-radius: 8px; text-decoration: none; color: var(--text-muted);
            font-size: 13.5px; font-weight: 500; transition: background .15s, color .15s;
        }
        .nav-link:hover { background: var(--nav-hover); color: var(--text-main); }
        .nav-link.active { background: var(--nav-active-bg); color: var(--nav-active-text); font-weight: 600; }
        .nav-icon { width: 16px; height: 16px; flex-shrink: 0; }
        .sidebar-footer { padding: 12px; border-top: 1px solid var(--sidebar-border); }
        .logout-btn {
            display: flex; align-items: center; gap: 8px; padding: 9px 10px;
            border-radius: 8px; border: none; background: none; color: #ef4444;
            font-size: 13.5px; font-weight: 500; cursor: pointer; text-decoration: none;
            transition: background .15s; width: 100%;
        }
        .logout-btn:hover { background: #FEF2F2; }

        /* ---- main ---- */
        .main-content { flex: 1; margin-left: var(--sidebar-width); display: flex; flex-direction: column; min-height: 100vh; }
        .topbar {
            background: var(--bg-card); border-bottom: 1px solid var(--sidebar-border);
            padding: 0 24px; height: 56px; display: flex; align-items: center;
            justify-content: space-between; position: sticky; top: 0; z-index: 50;
        }
        .topbar-title { font-size: 16px; font-weight: 600; }
        .hamburger { display: none; background: none; border: none; cursor: pointer; color: var(--text-main); }
        .page-body { flex: 1; padding: 24px; }

        /* ---- cards ---- */
        .card { background: var(--bg-card); border: 1px solid var(--sidebar-border); border-radius: var(--radius); padding: 20px; }
        .card-title { font-size: 13.5px; font-weight: 600; margin-bottom: 16px; color: var(--text-muted); text-transform: uppercase; letter-spacing: .04em; }

        /* ---- dashboard grid ---- */
        .stats-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 14px; margin-bottom: 20px; }
        .stat-card { background: var(--bg-card); border: 1px solid var(--sidebar-border); border-radius: var(--radius); padding: 16px 20px; }
        .stat-label { font-size: 11.5px; font-weight: 600; text-transform: uppercase; letter-spacing: .05em; color: var(--text-light); margin-bottom: 6px; }
        .stat-value { font-size: 26px; font-weight: 700; color: var(--text-main); line-height: 1; }
        .stat-sub { font-size: 12px; color: var(--text-light); margin-top: 4px; }
        .stat-accent { color: var(--primary); }

        .main-grid { display: grid; grid-template-columns: 1fr 320px; gap: 16px; }

        /* calorie ring */
        .ring-wrap { display: flex; flex-direction: column; align-items: center; gap: 12px; padding: 8px 0; }
        .ring-container { position: relative; width: 160px; height: 160px; }
        .ring-label { position: absolute; inset: 0; display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .ring-num { font-size: 28px; font-weight: 700; color: var(--primary); }
        .ring-sub { font-size: 11.5px; color: var(--text-light); }
        .progress-ring__circle { transition: stroke-dashoffset .4s; transform: rotate(-90deg); transform-origin: 50% 50%; }

        /* macros */
        .macro-item { margin-bottom: 14px; }
        .macro-header { display: flex; justify-content: space-between; margin-bottom: 5px; }
        .macro-name { font-size: 13px; font-weight: 500; }
        .macro-val { font-size: 12px; color: var(--text-light); }
        .progress-bar-bg { height: 6px; background: #E8EAED; border-radius: 99px; }
        .progress-bar { height: 6px; background: var(--primary); border-radius: 99px; }

        /* meal log */
        .meal-item {
            display: flex; align-items: center; justify-content: space-between;
            padding: 12px; border-radius: 8px; background: var(--bg-page); margin-bottom: 8px;
        }
        .meal-name { font-size: 13.5px; font-weight: 500; }
        .meal-cal { font-size: 12px; color: var(--text-light); margin-top: 2px; }
        .btn-add {
            font-size: 12.5px; font-weight: 600; color: var(--primary); background: none;
            border: none; cursor: pointer; padding: 4px 8px; border-radius: 6px;
            transition: background .15s;
        }
        .btn-add:hover { background: var(--primary-light); }

        /* sidebar overlay for mobile */
        .sidebar-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,.35); z-index: 99; }

        @media (max-width: 900px) {
            .stats-row { grid-template-columns: 1fr 1fr; }
            .main-grid { grid-template-columns: 1fr; }
        }
        @media (max-width: 768px) {
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .sidebar-overlay.show { display: block; }
            .main-content { margin-left: 0; }
            .hamburger { display: flex; }
            .page-body { padding: 14px; }
            .stats-row { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 480px) {
            .stats-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<div class="app-layout">

    <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <svg class="brand-icon" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path clip-rule="evenodd" d="M24 4H6V17.3333V30.6667H24V44H42V30.6667V17.3333H24V4Z" fill="currentColor" fill-rule="evenodd"/>
            </svg>
            <span class="brand-name">Sahaayata</span>
        </div>

        <div class="sidebar-user">
            <img class="user-avatar" src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=4F6FEB&color=fff&size=80" alt="avatar"/>
            <div>
                <p class="user-name"><%= user.getUsername() %></p>
                <p class="user-role">Member</p>
            </div>
        </div>

        <nav class="sidebar-nav">
            <p class="nav-section">Main</p>

            <a href="/dashboard" class="nav-link active">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/></svg>
                Dashboard
            </a>
            <a href="/my-recipes" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/><rect x="9" y="3" width="6" height="4" rx="1"/><path d="M9 12h6M9 16h4"/></svg>
                My Recipes
            </a>
            <a href="/create-recipe" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v8M8 12h8"/></svg>
                Create Recipe
            </a>
            <a href="/community" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>
                Community
            </a>

            <p class="nav-section" style="margin-top:1.25rem;">Account</p>

            <a href="/settings" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/></svg>
                Settings
            </a>
            <a href="/change-password" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>
                Change Password
            </a>
        </nav>

        <div class="sidebar-footer">
            <a href="/logout" class="logout-btn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="15" height="15"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>
                Logout
            </a>
        </div>
    </aside>
    <div class="sidebar-overlay" id="overlay" onclick="toggleSidebar()"></div>

    <div class="main-content">
        <header class="topbar">
            <div style="display:flex;align-items:center;gap:12px;">
                <button class="hamburger" onclick="toggleSidebar()" aria-label="Menu">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>
                </button>
                <span class="topbar-title">Dashboard</span>
            </div>
            <div style="display:flex;align-items:center;gap:10px;">
                <span style="font-size:13px;color:var(--text-light);">Today, <%= new java.text.SimpleDateFormat("MMM d").format(new java.util.Date()) %></span>
                <a href="/settings">
                    <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=4F6FEB&color=fff&size=80" width="32" height="32" style="border-radius:50%;" alt="avatar"/>
                </a>
            </div>
        </header>

        <div class="page-body">

            <div class="stats-row">
                <div class="stat-card">
                    <p class="stat-label">Daily Target</p>
                    <p class="stat-value stat-accent"><%= tdee %></p>
                    <p class="stat-sub">kcal / day</p>
                </div>
                <div class="stat-card">
                    <p class="stat-label">Consumed</p>
                    <p class="stat-value"><%= consumed %></p>
                    <p class="stat-sub">kcal today</p>
                </div>
                <div class="stat-card">
                    <p class="stat-label">Remaining</p>
                    <p class="stat-value" style="color:#10b981;"><%= remaining %></p>
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
                                    <circle id="calorie-ring" cx="80" cy="80" r="68" fill="none" stroke="#4F6FEB"
                                            stroke-width="12" stroke-linecap="round"
                                            stroke-dasharray="427.26" stroke-dashoffset="427.26"
                                            class="progress-ring__circle"/>
                                </svg>
                                <div class="ring-label">
                                    <span class="ring-num"><%= consumed %></span>
                                    <span class="ring-sub">/ <%= tdee %> kcal</span>
                                </div>
                            </div>
                            <p style="font-size:13px;color:var(--text-light);text-align:center;">Log meals to see your progress!</p>
                        </div>
                    </div>

                    <div class="card">
                        <p class="card-title">Macronutrient Goals</p>
                        <div class="macro-item">
                            <div class="macro-header">
                                <span class="macro-name">Protein</span>
                                <span class="macro-val">0g / <%= proteinGoal %>g</span>
                            </div>
                            <div class="progress-bar-bg"><div class="progress-bar" style="width:0%;"></div></div>
                        </div>
                        <div class="macro-item">
                            <div class="macro-header">
                                <span class="macro-name">Carbohydrates</span>
                                <span class="macro-val">0g / <%= carbGoal %>g</span>
                            </div>
                            <div class="progress-bar-bg"><div class="progress-bar" style="width:0%;background:#f59e0b;"></div></div>
                        </div>
                        <div class="macro-item" style="margin-bottom:0;">
                            <div class="macro-header">
                                <span class="macro-name">Fats</span>
                                <span class="macro-val">0g / <%= fatGoal %>g</span>
                            </div>
                            <div class="progress-bar-bg"><div class="progress-bar" style="width:0%;background:#10b981;"></div></div>
                        </div>
                    </div>
                </div>

                <div class="card" style="align-self:start;">
                    <p class="card-title">Today's Meals</p>
                    <div>
                        <div class="meal-item">
                            <div>
                                <p class="meal-name">Breakfast</p>
                                <p class="meal-cal">0 kcal logged</p>
                            </div>
                            <button class="btn-add" onclick="window.location.href='/log-meal'">+ Add</button>
                        </div>
                        <div class="meal-item">
                            <div>
                                <p class="meal-name">Lunch</p>
                                <p class="meal-cal">0 kcal logged</p>
                            </div>
                            <button class="btn-add" onclick="window.location.href='/log-meal'">+ Add</button>
                        </div>
                        <div class="meal-item">
                            <div>
                                <p class="meal-name">Dinner</p>
                                <p class="meal-cal">0 kcal logged</p>
                            </div>
                            <button class="btn-add" onclick="window.location.href='/log-meal'">+ Add</button>
                        </div>
                        <div class="meal-item">
                            <div>
                                <p class="meal-name">Snacks</p>
                                <p class="meal-cal">0 kcal logged</p>
                            </div>
                            <button class="btn-add" onclick="window.location.href='/log-meal'">+ Add</button>
                        </div>
                    </div>
                    <div style="margin-top:14px;padding-top:14px;border-top:1px solid var(--sidebar-border);">
                        <a href="/my-recipes" style="display:flex;align-items:center;gap:6px;font-size:13.5px;font-weight:600;color:var(--primary);text-decoration:none;">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/><rect x="9" y="3" width="6" height="4" rx="1"/></svg>
                            Browse Recipes
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('open');
        document.getElementById('overlay').classList.toggle('show');
    }
    // Calorie ring
    const ring = document.getElementById('calorie-ring');
    const circumference = 2 * Math.PI * 68;
    const consumed = <%= consumed %>, target = <%= tdee %>;
    const percent = Math.min(consumed / target, 1);
    ring.style.strokeDasharray = circumference;
    ring.style.strokeDashoffset = circumference - percent * circumference;
</script>
</body>
</html>