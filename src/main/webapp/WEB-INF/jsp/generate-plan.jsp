<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>

<%
    // Session validation taaki bina login ke koi page na khol sake
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    userCredential user = (userCredential) session.getAttribute("loggedInUser");
    if (user == null) { response.sendRedirect("/login"); return; }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Meal Combinations - Sahaayata</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        /* === STANDARD APP LAYOUT CSS (Sidebar, Topbar) === */
        :root {
            --primary: #4F6FEB; --primary-light: #EEF1FD; --primary-dark: #3451C7;
            --sidebar-width: 240px; --sidebar-bg: #fff; --sidebar-border: #E8EAED;
            --text-main: #1a1d23; --text-muted: #6b7280; --text-light: #9ca3af;
            --bg-page: #F4F6FB; --bg-card: #fff;
            --nav-hover: #F4F6FB; --nav-active-bg: #EEF1FD; --nav-active-text: #4F6FEB;
            --radius: 10px; --font: 'DM Sans', system-ui, sans-serif;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: var(--font); background: var(--bg-page); color: var(--text-main); min-height: 100vh; overflow-x: hidden; }
        .app-layout { display: flex; min-height: 100vh; }

        /* Sidebar Styles */
        .sidebar { width: var(--sidebar-width); background: var(--sidebar-bg); border-right: 1px solid var(--sidebar-border); display: flex; flex-direction: column; position: fixed; top: 0; left: 0; bottom: 0; z-index: 100; transition: transform .25s ease; overflow-y: auto; }
        .sidebar-brand { display: flex; align-items: center; gap: 10px; padding: 20px 20px 16px; border-bottom: 1px solid var(--sidebar-border); color: var(--primary); }
        .brand-icon { width: 26px; height: 26px; }
        .brand-name { font-size: 17px; font-weight: 700; color: var(--text-main); letter-spacing: -.3px; }
        .sidebar-user { display: flex; align-items: center; gap: 10px; padding: 14px 20px; border-bottom: 1px solid var(--sidebar-border); }
        .user-avatar { width: 36px; height: 36px; border-radius: 50%; }
        .user-name { font-size: 13px; font-weight: 600; }
        .user-role { font-size: 11px; color: var(--text-light); }
        .sidebar-nav { flex: 1; padding: 14px 12px; display: flex; flex-direction: column; gap: 2px; }
        .nav-section { font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: .08em; color: var(--text-light); padding: 8px 8px 6px; }
        .nav-link { display: flex; align-items: center; gap: 10px; padding: 9px 10px; border-radius: 8px; text-decoration: none; color: var(--text-muted); font-size: 13.5px; font-weight: 500; transition: background .15s, color .15s; }
        .nav-link:hover { background: var(--nav-hover); color: var(--text-main); }
        .nav-link.active { background: var(--nav-active-bg); color: var(--nav-active-text); font-weight: 600; }
        .nav-icon { width: 16px; height: 16px; flex-shrink: 0; }
        .sidebar-footer { padding: 12px; border-top: 1px solid var(--sidebar-border); }
        .logout-btn { display: flex; align-items: center; gap: 8px; padding: 9px 10px; border-radius: 8px; border: none; background: none; color: #ef4444; font-size: 13.5px; font-weight: 500; cursor: pointer; text-decoration: none; transition: background .15s; width: 100%; }
        .logout-btn:hover { background: #FEF2F2; }

        /* Main Content & Topbar Styles */
        .main-content { flex: 1; margin-left: var(--sidebar-width); display: flex; flex-direction: column; min-height: 100vh;}
        .topbar { background: var(--bg-card); border-bottom: 1px solid var(--sidebar-border); padding: 0 24px; height: 56px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 50; }
        .topbar-title { font-size: 16px; font-weight: 600; }
        .hamburger { display: none; background: none; border: none; cursor: pointer; color: var(--text-main); }
        .page-body { flex: 1; padding: 24px; display: flex; flex-direction: column; max-width: 1200px; margin: 0 auto; width: 100%; }

        /* === GENERATE PLAN SPECIFIC CSS === */
        .page-header-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; flex-wrap: wrap; gap: 16px; }

        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }

        .plan-card { background: var(--bg-card); border-radius: 12px; padding: 24px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); border: 1px solid var(--sidebar-border); position: relative; transition: transform 0.2s; }
        .plan-card:hover { transform: translateY(-4px); box-shadow: 0 8px 25px rgba(0,0,0,0.06); border-color: var(--primary); }

        .plan-title { font-size: 18px; font-weight: 700; color: var(--text-main); margin-bottom: 20px; padding-bottom: 12px; border-bottom: 2px dashed var(--sidebar-border); display: flex; justify-content: space-between; align-items: center; }
        .total-cal-badge { font-size: 12px; background: var(--primary-light); color: var(--primary); padding: 4px 10px; border-radius: 12px; }

        .meal-slot { margin-bottom: 18px; padding-left: 12px; border-left: 3px solid var(--sidebar-border); }
        .meal-slot:hover { border-color: var(--primary); }
        .meal-type { font-size: 11.5px; font-weight: 700; color: var(--primary); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px; display: flex; align-items: center; gap: 8px; }
        .combo-badge { background: #fef3c7; padding: 2px 6px; border-radius: 4px; font-size: 10px; color: #b45309; }

        .food-item { font-size: 14px; font-weight: 600; color: var(--text-main); line-height: 1.5; }
        .food-cal { font-size: 12px; color: var(--text-light); margin-top: 2px; }

        .btn-use { width: 100%; padding: 12px; background: #10b981; color: white; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; margin-top: 10px; transition: 0.2s; }
        .btn-use:hover { background: #059669; }

        .loading-text { text-align: center; font-size: 15px; color: var(--text-muted); font-weight: 500; margin-top: 40px; width: 100%; grid-column: 1 / -1;}

        .sidebar-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,.35); z-index: 99; }

        /* Mobile Responsiveness */
        @media(max-width:768px) {
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .sidebar-overlay.show { display: block; }
            .main-content { margin-left: 0; }
            .hamburger { display: flex; }
            .page-body { padding: 16px; }
            .page-header-row { flex-direction: column; align-items: flex-start; }
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
            <a href="/dashboard" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/></svg>Dashboard
            </a>
            <a href="/log-meal" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v8M8 12h8"/></svg>Log Meal
            </a>
            <a href="/my-recipes" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/><rect x="9" y="3" width="6" height="4" rx="1"/><path d="M9 12h6M9 16h4"/></svg>My Recipes
            </a>
            <a href="/community" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>Community
            </a>
            <p class="nav-section" style="margin-top:1.25rem;">Account</p>
            <a href="/settings" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/></svg>Settings
            </a>
            <a href="/change-password" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>Change Password
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="/logout" class="logout-btn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="15" height="15"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>Logout
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
                <span class="topbar-title">Smart Recommendations</span>
            </div>
            <div style="display:flex;align-items:center;gap:10px;">
                <span style="font-size:13px;color:var(--text-light);">Today, <%= new java.text.SimpleDateFormat("MMM d").format(new java.util.Date()) %></span>
                <a href="/settings">
                    <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=4F6FEB&color=fff&size=80" width="32" height="32" style="border-radius:50%;" alt="avatar"/>
                </a>
            </div>
        </header>

        <div class="page-body">

            <div class="page-header-row">
                <div>
                    <h1 id="page-title" style="font-size: 22px; font-weight: 700; color: var(--text-main); margin-bottom: 6px;">Generating Plans...</h1>
                    <p id="page-subtitle" style="font-size: 13.5px; color: var(--text-muted);">Finding the best combinations based on your target.</p>
                </div>
            </div>

            <div class="grid" id="plans-container">
                <div class="loading-text">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" style="animation: spin 1s linear infinite; margin-bottom: 10px;"><path d="M21 12a9 9 0 11-6.219-8.56"/></svg>
                    <br/>Fetching combinations from database...
                </div>
            </div>

        </div>
    </div>
</div>

<style>
    @keyframes spin { 100% { transform: rotate(360deg); } }
</style>

<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('open');
        document.getElementById('overlay').classList.toggle('show');
    }

    // Backend se data mangwane ka logic
    window.onload = async function() {
        const urlParams = new URLSearchParams(window.location.search);
        const filter = urlParams.get('filter') || 'High Protein';
        const target = urlParams.get('target') || 2000;

        document.getElementById('page-title').innerText = filter + " Combinations";
        document.getElementById('page-subtitle').innerText = "Accurately calculated for " + target + " kcal target.";

        const container = document.getElementById('plans-container');

        try {
            const response = await fetch('/getMultiplePlans?filter=' + encodeURIComponent(filter) + '&target=' + target);
            const plans = await response.json();

            if (!Array.isArray(plans)) {
                container.innerHTML = '<div class="loading-text" style="color:red;">Error rendering list. Check backend.</div>';
                return;
            }

            container.innerHTML = '';
            plans.forEach(plan => {
                const totalCal = plan.breakfast.cal + plan.lunch.totalCal + plan.dinner.totalCal + plan.snacks.cal;

                // YAHAN MAINE STRING CONCATENATION USE KIYA HAI, BACKTICKS HATA DIYE HAIN.
                let html = '<div class="plan-card">' +
                    '<div class="plan-title">' +
                    plan.optionName +
                    ' <span class="total-cal-badge">' + totalCal + ' kcal</span>' +
                    '</div>' +
                    '<div class="meal-slot">' +
                    '<div class="meal-type">Breakfast</div>' +
                    '<div class="food-item">' + plan.breakfast.qty + ' x ' + plan.breakfast.name + ' (' + plan.breakfast.unit + ')</div>' +
                    '<div class="food-cal">' + plan.breakfast.cal + ' kcal</div>' +
                    '</div>' +
                    '<div class="meal-slot">' +
                    '<div class="meal-type">Lunch <span class="combo-badge">Combo</span></div>' +
                    '<div class="food-item">' + plan.lunch.grainQty + ' x ' + plan.lunch.grainName + ' (' + plan.lunch.grainUnit + ') <br/> + ' + plan.lunch.dishQty + ' x ' + plan.lunch.dishName + ' (' + plan.lunch.dishUnit + ')</div>' +
                    '<div class="food-cal">' + plan.lunch.totalCal + ' kcal</div>' +
                    '</div>' +
                    '<div class="meal-slot">' +
                    '<div class="meal-type">Dinner <span class="combo-badge">Combo</span></div>' +
                    '<div class="food-item">' + plan.dinner.grainQty + ' x ' + plan.dinner.grainName + ' (' + plan.dinner.grainUnit + ') <br/> + ' + plan.dinner.dishQty + ' x ' + plan.dinner.dishName + ' (' + plan.dinner.dishUnit + ')</div>' +
                    '<div class="food-cal">' + plan.dinner.totalCal + ' kcal</div>' +
                    '</div>' +
                    '<div class="meal-slot">' +
                    '<div class="meal-type">Snacks</div>' +
                    '<div class="food-item">' + plan.snacks.qty + ' x ' + plan.snacks.name + ' (' + plan.snacks.unit + ')</div>' +
                    '<div class="food-cal">' + plan.snacks.cal + ' kcal</div>' +
                    '</div>' +
                    '<button class="btn-use" onclick="alert(\'' + plan.optionName + ' selected! Implement DB saving logic here.\')">Log This Plan</button>' +
                    '</div>';

                container.innerHTML += html;
            });
        } catch (error) {
            console.error(error);
            container.innerHTML = '<div class="loading-text" style="color:#ef4444;">Failed to fetch data. Database connection error.</div>';
        }
    };
</script>
</body>
</html>