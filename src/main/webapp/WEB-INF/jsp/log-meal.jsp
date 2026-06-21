<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

    String mealParam = request.getParameter("meal");
    String currentMeal = (mealParam != null && !mealParam.trim().isEmpty()) ? mealParam : "Custom Meal";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Add Today's Meal — Sahaayata</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=DM+Sans:wght@600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <style>
        .ai-gradient-text {
            background: linear-gradient(135deg, #0058be 0%, #006c49 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        :root {
            --primary: #0058be; --primary-light: #d8e2ff; --primary-dark: #004395;
            --sidebar-width: 240px; --sidebar-bg: #f8fafc; --sidebar-border: rgba(194, 198, 214, 0.3);
            --text-main: #131b2e; --text-muted: #424754; --text-light: #727785;
            --bg-page: #faf8ff; --bg-card: #ffffff;
            --nav-hover: #f2f3ff; --nav-active-bg: #d8e2ff; --nav-active-text: #0058be;
            --radius: 12px; --font: 'Inter', system-ui, sans-serif;
            --danger: #ef4444; --success: #10b981; --warning: #f59e0b;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: var(--font); background: var(--bg-page); color: var(--text-main); min-height: 100vh; overflow-x: hidden; }
        .app-layout { display: flex; min-height: 100vh; }
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
        .main-content { flex: 1; margin-left: var(--sidebar-width); display: flex; flex-direction: column; }
        .topbar { background: var(--bg-card); border-bottom: 1px solid var(--sidebar-border); padding: 0 24px; height: 56px; display: flex; align-items: center; gap: 12px; position: sticky; top: 0; z-index: 50; }
        .topbar-title { font-size: 16px; font-weight: 600; }
        .hamburger { display: none; background: none; border: none; cursor: pointer; color: var(--text-main); }
        .page-body { flex: 1; padding: 16px 24px; display: flex; flex-direction: column; gap: 16px; max-width: 1200px; margin: 0 auto; width: 100%; }
        .card { background: var(--bg-card); border: 1px solid var(--sidebar-border); border-radius: var(--radius); padding: 20px; box-shadow: 0px 4px 16px rgba(15, 23, 42, 0.03); }
        .section-title { font-size: 16px; font-weight: 700; margin-bottom: 12px; }
        .input-group { position: relative; width: 100%; }
        .form-input { width: 100%; padding: 9px 16px; border: 1px solid var(--sidebar-border); border-radius: 99px !important; font-size: 13.5px; font-family: var(--font); color: var(--text-main); background: #fff; outline: none; transition: border-color .15s, box-shadow .15s; }
        .form-input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px var(--primary-light); }
        .btn { border: none; padding: 9px 16px; border-radius: 99px !important; font-size: 13.5px; font-weight: 600; cursor: pointer; transition: background .15s, transform .1s; font-family: var(--font); display: inline-flex; align-items: center; justify-content: center; gap: 8px; }
        .btn:active { transform: scale(0.98); }
        .btn-primary { background: linear-gradient(135deg, #0058be 0%, #004395 100%); color: #fff; box-shadow: 0 4px 12px rgba(0, 88, 190, 0.2); }
        .btn-primary:hover { box-shadow: 0 6px 16px rgba(0, 88, 190, 0.3); transform: translateY(-1px); }
        .btn-success { background: var(--success); color: #fff; }
        .btn-danger { background: var(--danger); color: #fff; }
        .btn-secondary { background: var(--bg-page); color: var(--text-muted); border: 1px solid var(--sidebar-border); }
        .btn-secondary:hover { background: #E8EAED; color: var(--text-main); }
        .search-results { display: none; position: absolute; width: 100%; z-index: 10; margin-top: 4px; max-height: 300px; overflow-y: auto; border: 1px solid var(--sidebar-border); border-radius: 8px; background: #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .search-item { padding: 12px 16px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--sidebar-border); cursor: pointer; transition: background .15s; }
        .search-item:last-child { border-bottom: none; }
        .search-item:hover { background: var(--bg-page); }
        .food-name { font-weight: 600; font-size: 14px; }
        .food-meta { color: var(--text-light); font-size: 12px; margin-top: 2px; }
        #food-details { display: none; margin-top: 24px; }
        .details-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-top: 16px; }
        .stat-card { background: var(--bg-page); border: 1px solid var(--sidebar-border); border-radius: 8px; padding: 16px; text-align: center; }
        .stat-label { font-size: 12px; color: var(--text-muted); text-transform: uppercase; font-weight: 600; letter-spacing: 0.5px; }
        .stat-value { font-size: 24px; font-weight: 700; color: var(--primary); margin-top: 4px; }
        .serving-control { display: flex; align-items: center; flex-wrap: wrap; gap: 12px; margin-top: 20px; }
        #prediction-result { display: none; margin-top: 20px; text-align: center; border-top: 1px solid var(--sidebar-border); padding-top: 20px; }
        #prediction-text { font-size: 16px; font-weight: 600; color: var(--text-main); }
        .confirm-actions { display: flex; gap: 10px; justify-content: center; margin-top: 16px; }
        .modal-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.4); z-index: 1000; align-items: center; justify-content: center; opacity: 0; transition: opacity 0.2s ease; }
        .modal-overlay.show { display: flex; opacity: 1; }
        .modal-card { background: var(--bg-card); padding: 32px; border-radius: var(--radius); width: 90%; max-width: 400px; text-align: center; box-shadow: 0 10px 25px rgba(0,0,0,0.1); transform: translateY(20px); transition: transform 0.2s ease; }
        .modal-overlay.show .modal-card { transform: translateY(0); }
        .score-circle { width: 100px; height: 100px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 32px; font-weight: 800; margin: 0 auto 20px; color: #fff; }
        .score-high { background: var(--success); box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3); }
        .score-mid { background: var(--warning); box-shadow: 0 4px 15px rgba(245, 158, 11, 0.3); }
        .score-low { background: var(--danger); box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3); }
        .modal-title { font-size: 20px; font-weight: 700; margin-bottom: 8px; }
        .modal-desc { font-size: 14px; color: var(--text-muted); margin-bottom: 24px; line-height: 1.5; }
        @media(max-width:768px){ .sidebar{transform:translateX(-100%);} .sidebar.open{transform:translateX(0);} .sidebar-overlay.show{display:block;} .main-content{margin-left:0;} .hamburger{display:flex;} .page-body{padding:16px;} .serving-control{flex-direction:column;align-items:stretch;} }
        
        /* New Grid Layout CSS */
        .dashboard-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; }
        @media(max-width: 900px) { .dashboard-grid { grid-template-columns: 1fr; } }
        .scanner-area { border: 2px dashed var(--sidebar-border); border-radius: var(--radius); padding: 24px 20px; text-align: center; cursor: pointer; background: var(--bg-page); transition: all 0.2s; }
        .scanner-area:hover { border-color: var(--primary); background: var(--primary-light); }
        .scanner-icon { color: var(--primary); margin-bottom: 12px; }
        .scanner-title { font-size: 16px; font-weight: 700; margin-bottom: 4px; }
        .scanner-subtitle { font-size: 13px; color: var(--text-muted); }
        .visualizer-container { background: var(--bg-page); border-radius: var(--radius); min-height: 200px; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; }
        .visualizer-container img { max-width: 100%; max-height: 280px; object-fit: contain; border-radius: 8px; }
        .scan-badge { position: absolute; top: 10px; right: 10px; background: var(--primary); color: white; font-size: 11px; font-weight: 700; padding: 4px 8px; border-radius: 4px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .macro-bar-item { margin-bottom: 12px; }
        .macro-header { display: flex; justify-content: space-between; font-size: 13.5px; font-weight: 600; margin-bottom: 6px; }
        .macro-bar-track { height: 8px; background: var(--sidebar-border); border-radius: 4px; overflow: hidden; }
        .macro-bar-fill { height: 100%; border-radius: 4px; transition: width 0.3s; }
        .fill-protein { background: var(--primary); }
        .fill-carbs { background: var(--warning); }
        .fill-fat { background: var(--danger); }
        .calorie-circle { width: 120px; height: 120px; border-radius: 50%; border: 8px solid var(--primary-light); border-top-color: var(--primary); display: flex; flex-direction: column; align-items: center; justify-content: center; margin: 0 auto 16px; transition: all 0.3s; }
        .calorie-val { font-size: 28px; font-weight: 800; color: var(--text-main); line-height: 1; transition: color 0.3s; }
        .calorie-label { font-size: 11px; color: var(--text-muted); font-weight: 600; margin-top: 4px; }
        .plate-item { background: var(--bg-page); border: 1px solid var(--sidebar-border); border-radius: 8px; padding: 12px; margin-bottom: 8px; }
        .plate-item-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .plate-item-cal { font-size: 12px; color: var(--text-muted); font-weight: 600; }
        .plate-item-controls { display: flex; align-items: center; gap: 12px; }
        .range-slider { flex: 1; accent-color: var(--primary); }
        .btn-remove { background: none; border: none; color: var(--danger); cursor: pointer; font-size: 16px; opacity: 0.7; transition: opacity 0.2s; }
        .btn-remove:hover { opacity: 1; }
        #food-adjuster-items { max-height: 220px; overflow-y: auto; padding-right: 8px; margin-bottom: 8px; }
        #food-adjuster-items::-webkit-scrollbar { width: 6px; }
        #food-adjuster-items::-webkit-scrollbar-track { background: var(--bg-page); border-radius: 4px; }
        #food-adjuster-items::-webkit-scrollbar-thumb { background: var(--sidebar-border); border-radius: 4px; }
        #food-adjuster-items::-webkit-scrollbar-thumb:hover { background: #a0a0a0; }
        .manual-add-section { margin-top: 24px; border-top: 1px solid var(--sidebar-border); padding-top: 16px; }
        .manual-buttons-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(80px, 1fr)); gap: 10px; margin-top: 10px; }
        .btn-manual-add { display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 6px; padding: 12px 8px; background: var(--bg-page); border: 1px solid var(--sidebar-border); border-radius: 8px; cursor: pointer; transition: all 0.2s; color: var(--text-main); }
        .btn-manual-add:hover { border-color: var(--primary); color: var(--primary); background: #fff; }
        .btn-manual-add .icon { font-size: 20px; }
        .btn-manual-add .label { font-size: 12px; font-weight: 600; }
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
            <img class="user-avatar" src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=0058be&color=fff&size=80" alt="avatar"/>
            <div><p class="user-name"><%= user.getUsername() %></p><p class="user-role">Member</p></div>
        </div>
        <nav class="sidebar-nav">
            <p class="nav-section">Main</p>
            <a href="/dashboard" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/></svg>Dashboard
            </a>
            <a href="/log-meal" class="nav-link active">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v8M8 12h8"/></svg>Log Meal
            </a>
            <a href="/my-recipes" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/><rect x="9" y="3" width="6" height="4" rx="1"/><path d="M9 12h6M9 16h4"/></svg>My Recipes
            </a>
            <a href="/community" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>Community
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
            <button class="hamburger" onclick="toggleSidebar()">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>
            </button>
            <span class="topbar-title">Add Today's Meal (<%= currentMeal %>)</span>
        </header>

        <div class="page-body">
            <div class="card" style="margin-bottom: 24px;">
                <p class="section-title">Search & Log Food</p>

                <form action="/save-daily-log" method="POST" id="logFoodForm">
                    <input type="hidden" name="foodId" id="hidden-food-id">
                    <input type="hidden" name="mealType" value="<%= currentMeal %>" id="hidden-meal-type">

                    <div class="input-group">
                        <input type="text" id="food-search" class="form-input" placeholder="Search for food (e.g., Apple, Roti, Chicken)..." oninput="showSearchResults()" onkeydown="return event.key != 'Enter';" autocomplete="off"/>
                        <div id="search-results" class="search-results"></div>
                    </div>

                    <div id="food-details" style="display: none;">
                        <div class="details-grid">
                            <div class="stat-card"><p class="stat-label">Calories</p><p class="stat-value" id="val-cal">0 kcal</p></div>
                            <div class="stat-card"><p class="stat-label">Protein</p><p class="stat-value" id="val-prot">0 g</p></div>
                            <div class="stat-card"><p class="stat-label">Carbs</p><p class="stat-value" id="val-carbs">0 g</p></div>
                            <div class="stat-card"><p class="stat-label">Fats</p><p class="stat-value" id="val-fats">0 g</p></div>
                        </div>

                        <div class="serving-control">
                            <label for="serving-qty" class="form-label" style="font-size: 14px; font-weight: 600; color: var(--text-muted); margin-bottom: 0;">Number of Servings</label>

                            <input type="number" name="servingQty" id="serving-qty" class="form-input" value="1" step="0.5" style="width: 100px;" oninput="updateNutrition()" required>

                            <span id="serving-unit-display" style="font-size: 13.5px; font-weight: 500; color: var(--text-main); margin-left: 8px;"></span>

                            <div style="flex: 1;"></div>

                            <button type="button" class="btn btn-secondary" onclick="showQualityScore()">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14M22 4L12 14.01l-3-3"/></svg>
                                Check Quality
                            </button>
                            <button type="button" class="btn btn-secondary" style="border-color: var(--primary); color: var(--primary);" onclick="addCurrentFoodToPlate()">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 5v14M5 12h14"/></svg>
                                Add to Plate
                            </button>
                            <button type="submit" class="btn btn-primary" id="btn-add-log">Add to Log</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="dashboard-grid">
                
                <!-- Panel 1: Scanner -->
                <div class="card" id="scanner-section">
                    <p class="section-title">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" style="vertical-align:bottom; margin-right:6px;"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path><circle cx="12" cy="13" r="4"></circle></svg>
                        Food Scanner
                    </p>
                    <div class="scanner-area" onclick="document.getElementById('image-upload').click()">
                        <input type="file" id="image-upload" style="display: none;" accept="image/*" onchange="predictImage(event)">
                        <svg class="scanner-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" width="48" height="48"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
                        <h3 class="scanner-title">Drag & Drop your plate</h3>
                        <p class="scanner-subtitle">or click to browse from files</p>
                    </div>
                    
                    <div id="prediction-result" style="display:none; margin-top:20px; text-align:center;">
                        <p id="prediction-text" style="font-weight:600; color:var(--text-main);">Analyzing Image with FoodYOLO AI...</p>
                    </div>
                </div>

                <!-- Panel 2: Result Visualizer -->
                <div class="card" id="visualizer-section">
                    <p class="section-title">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" style="vertical-align:bottom; margin-right:6px;"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                        Scan Prediction
                    </p>
                    <div class="visualizer-container" id="visualizer-view">
                        <div id="visualizer-placeholder" style="text-align:center; color:var(--text-muted); font-size:13px; font-weight:500;">
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="margin-bottom:8px; opacity:0.5;"><path d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14v-4z"/><rect x="3" y="6" width="12" height="12" rx="2"/></svg><br/>
                            Scan a food item to view detections
                        </div>
                        <img id="uploaded-image-preview" src="" alt="Preview" style="display:none;"/>
                        <div class="scan-badge" id="scan-badge" style="display:none;">YOLOv8 Scan</div>
                    </div>
                </div>

                <!-- Panel 3: Nutrition Summary Card -->
                <div class="card" id="nutrition-section">
                    <p class="section-title">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" style="vertical-align:bottom; margin-right:6px;"><path d="M22 12h-4l-3 9L9 3l-3 9H2"></path></svg>
                        Nutritional Tracker
                    </p>
                    
                    <div class="calorie-circle">
                        <span class="calorie-val" id="total-calories">0</span>
                        <span class="calorie-label">KCAL</span>
                    </div>
                    
                    <h3 style="font-size:11px; text-transform:uppercase; letter-spacing:1px; color:var(--text-muted); margin-bottom:12px;">Macronutrients Split</h3>
                    
                    <div class="macro-bar-item">
                        <div class="macro-header">
                            <span><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" style="vertical-align:middle; margin-right:4px;"><path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg> Protein</span>
                            <span><strong id="total-protein">0</strong>g</span>
                        </div>
                        <div class="macro-bar-track"><div class="macro-bar-fill fill-protein" id="bar-protein" style="width: 0%;"></div></div>
                    </div>
                    
                    <div class="macro-bar-item">
                        <div class="macro-header">
                            <span><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--warning)" stroke-width="2" style="vertical-align:middle; margin-right:4px;"><circle cx="12" cy="12" r="10"></circle><path d="M8 14s1.5 2 4 2 4-2 4-2"></path><line x1="9" y1="9" x2="9.01" y2="9"></line><line x1="15" y1="9" x2="15.01" y2="9"></line></svg> Carbohydrates</span>
                            <span><strong id="total-carbs">0</strong>g</span>
                        </div>
                        <div class="macro-bar-track"><div class="macro-bar-fill fill-carbs" id="bar-carbs" style="width: 0%;"></div></div>
                    </div>
                    
                    <div class="macro-bar-item">
                        <div class="macro-header">
                            <span><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--danger)" stroke-width="2" style="vertical-align:middle; margin-right:4px;"><path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z"></path></svg> Fats</span>
                            <span><strong id="total-fats">0</strong>g</span>
                        </div>
                        <div class="macro-bar-track"><div class="macro-bar-fill fill-fat" id="bar-fat" style="width: 0%;"></div></div>
                    </div>
                </div>

                <!-- Panel 4: Interactive Quantities & Plate Logging -->
                <div class="card" id="logs-section">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                        <p class="section-title" style="margin-bottom:0;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" style="vertical-align:bottom; margin-right:6px;"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
                            Plate Log & Adjuster
                        </p>
                        <button type="button" class="btn btn-secondary" style="padding: 6px 12px; font-size:12px;" onclick="resetPlate()">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:4px;"><path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path><path d="M3 3v5h5"></path></svg> Reset
                        </button>
                    </div>
                    
                    <div id="food-adjuster-items">
                        <p style="color:var(--text-muted); font-size:13px; text-align:center; padding: 20px 0;">No items added yet. Scan a plate or search below.</p>
                    </div>

                    <div id="plate-saving-section" style="display: none; margin-top: 20px; border-top: 1px solid var(--sidebar-border); padding-top: 20px;">
                        <button type="button" class="btn btn-primary" style="width: 100%; justify-content: center; font-size:15px; padding:12px;" onclick="logMealToHistory()" id="btn-save-plate">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                            Log Meal to History
                        </button>
                    </div>

                    <div class="manual-add-section" style="margin-top: 20px; padding-top: 16px; border-top: 1px solid var(--sidebar-border);">
                        <h3 class="section-title" style="font-size:13px; margin-bottom:12px; color: var(--text-muted);">Quick Add to Plate</h3>
                        <div class="manual-buttons-grid">
                            <button type="button" class="btn-manual-add" onclick="addPlateItemFromPrediction('Dal')">
                                <span class="icon">🥣</span><span class="label">Dal</span>
                            </button>
                            <button type="button" class="btn-manual-add" onclick="addPlateItemFromPrediction('Rice')">
                                <span class="icon">🍚</span><span class="label">Rice</span>
                            </button>
                            <button type="button" class="btn-manual-add" onclick="addPlateItemFromPrediction('Roti')">
                                <span class="icon">🫓</span><span class="label">Roti</span>
                            </button>
                            <button type="button" class="btn-manual-add" onclick="addPlateItemFromPrediction('Bhindi')">
                                <span class="icon">🥬</span><span class="label">Bhindi</span>
                            </button>
                            <button type="button" class="btn-manual-add" onclick="addPlateItemFromPrediction('Paneer')">
                                <span class="icon">🧀</span><span class="label">Paneer</span>
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<div id="quality-modal" class="modal-overlay">
    <div class="modal-card">
        <p class="modal-title">Food Quality Score</p>
        <div id="score-circle" class="score-circle"><span id="score-value">0</span></div>
        <p id="score-feedback" class="modal-desc">Loading nutritional data...</p>
        <button class="btn btn-secondary" style="width: 100%;" onclick="closeQualityScore()">Got it</button>
    </div>
</div>

<script>
    function toggleSidebar(){
        document.getElementById('sidebar').classList.toggle('open');
        document.getElementById('overlay').classList.toggle('show');
    }

    const mealType = "<%= currentMeal %>";
    let plateItems = [];

    let currentFood = null;

    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const filterStr = urlParams.get('filter');
        const mealStr = urlParams.get('meal');

        if (filterStr && mealStr) {
            fetchFilteredSuggestions(mealStr, filterStr);
        } else if (filterStr) {
            addPlateItemFromPrediction(filterStr);
        }

        document.getElementById('logFoodForm').addEventListener('submit', function(e) {
            e.preventDefault(); 
            const btnSubmit = document.getElementById('btn-add-log');
            const originalText = btnSubmit.innerText;
            btnSubmit.innerText = "Adding...";
            btnSubmit.disabled = true;

            const formData = new FormData(this);
            const searchParams = new URLSearchParams();
            for (const pair of formData) {
                searchParams.append(pair[0], pair[1]);
            }

            fetch('/save-daily-log', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: searchParams.toString()
            }).then(res => {
                btnSubmit.innerText = originalText;
                btnSubmit.disabled = false;
                
                const detailsDiv = document.getElementById('food-details');
                const existingMsg = document.getElementById('ajax-success-msg');
                if (existingMsg) existingMsg.remove();

                const successMsg = document.createElement('div');
                successMsg.id = 'ajax-success-msg';
                successMsg.style = "margin-top: 16px; padding: 12px; background: var(--success); color: white; border-radius: 8px; text-align: center; font-weight: 500; font-size: 14px;";
                successMsg.innerHTML = "Added to your log! You can select another item below, or <a href='/dashboard' style='color:white; font-weight:700; text-decoration:underline;'>Go to Dashboard</a>.";
                
                detailsDiv.appendChild(successMsg);
                document.getElementById('serving-qty').value = 1;
                updateNutrition();
            }).catch(err => {
                btnSubmit.innerText = originalText;
                btnSubmit.disabled = false;
                console.error(err);
            });
        });
    };

    async function fetchFilteredSuggestions(meal, filter) {
        const resultsDropdown = document.getElementById('search-results');

        try {
            const response = await fetch('/getSuggestions?meal=' + encodeURIComponent(meal) + '&filter=' + encodeURIComponent(filter));

            if (response.ok) {
                const foods = await response.json();
                
                if (!Array.isArray(foods)) return;

                resultsDropdown.innerHTML = '<div style="padding: 10px 16px; background: var(--primary-light); color: var(--primary); font-size: 11.5px; font-weight: 700; letter-spacing: 0.5px; text-transform: uppercase;">SUGGESTIONS FOR ' + decodeURIComponent(filter) + ' (' + meal + ')</div>';

                if(foods.length === 0) {
                    resultsDropdown.innerHTML += '<div class="search-item"><p class="food-meta">No perfect matches found. Try normal search.</p></div>';
                } else {
                    foods.forEach(food => {
                        const itemDiv = document.createElement('div');
                        itemDiv.className = 'search-item';
                        itemDiv.onclick = () => selectFood(food);

                        const servingU = food.servingUnit || '100g';

                        itemDiv.innerHTML =
                            '<div>' +
                            '<p class="food-name">' + food.foodName + '</p>' +
                            '<p class="food-meta">' + food.calories + ' kcal per ' + servingU + '</p>' +
                            '</div>' +
                            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>';

                        resultsDropdown.appendChild(itemDiv);
                    });
                }
                resultsDropdown.style.display = 'block';
            }
        } catch (error) {
            console.error("Error fetching suggestions:", error);
        }
    }

    async function showSearchResults() {
        const query = document.getElementById('food-search').value.trim();
        const resultsDropdown = document.getElementById('search-results');

        if (query.length >= 1) {
            try {
                const response = await fetch('/searchFood?q=' + encodeURIComponent(query));
                if (response.ok) {
                    const foods = await response.json();
                    resultsDropdown.innerHTML = '';

                    if(foods.length === 0) {
                        resultsDropdown.innerHTML = '<div class="search-item"><p class="food-meta">No food found in database.</p></div>';
                    } else {
                        foods.forEach(food => {
                            const itemDiv = document.createElement('div');
                            itemDiv.className = 'search-item';
                            itemDiv.onclick = () => selectFood(food); 

                            const servingU = food.servingUnit || '100g';

                            itemDiv.innerHTML =
                                '<div>' +
                                '<p class="food-name">' + food.foodName + '</p>' +
                                '<p class="food-meta">' + food.calories + ' kcal per ' + servingU + '</p>' +
                                '</div>' +
                                '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>';

                            resultsDropdown.appendChild(itemDiv);
                        });
                    }
                    resultsDropdown.style.display = 'block';
                }
            } catch (error) {
                console.error("Network Fetch Error:", error);
            }
        } else {
            resultsDropdown.style.display = 'none';
        }
    }

    function selectFood(foodObj) {
        currentFood = foodObj;
        document.getElementById('food-search').value = foodObj.foodName;
        document.getElementById('search-results').style.display = 'none';
        document.getElementById('food-details').style.display = 'block';
        document.getElementById('hidden-food-id').value = foodObj.id;

        document.getElementById('serving-qty').value = 1;

        const sUnit = foodObj.servingUnit || '100g';
        const sWeight = foodObj.defaultServingWeight ? ' (' + foodObj.defaultServingWeight + 'g)' : '';
        document.getElementById('serving-unit-display').innerText = 'x ' + sUnit + sWeight;

        updateNutrition();
    }

    function addCurrentFoodToPlate() {
        if (!currentFood) return;
        const qty = parseFloat(document.getElementById('serving-qty').value) || 1;
        
        const pItem = {
            id: Date.now() + Math.random(),
            query: currentFood.foodName,
            matches: [currentFood],
            selectedMatchIdx: 0,
            quantity: qty
        };
        plateItems.push(pItem);
        renderPlate();
        
        document.getElementById('food-search').value = '';
        document.getElementById('food-details').style.display = 'none';
        currentFood = null;
    }

    function updateNutrition() {
        if (!currentFood) return;

        const qty = parseFloat(document.getElementById('serving-qty').value) || 1;

        document.getElementById('val-cal').innerText = Math.round(currentFood.calories * qty) + " kcal";
        document.getElementById('val-prot').innerText = (currentFood.protein * qty).toFixed(1) + " g";
        document.getElementById('val-carbs').innerText = (currentFood.carbs * qty).toFixed(1) + " g";
        document.getElementById('val-fats').innerText = (currentFood.fats * qty).toFixed(1) + " g";
    }

    function showQualityScore() {
        if (!currentFood) return;
        let score = (currentFood.healthRating || 5) * 10;
        const circle = document.getElementById('score-circle');
        const feedback = document.getElementById('score-feedback');

        circle.className = 'score-circle';
        const recFor = currentFood.recommendedFor || 'General Health';
        const glyInd = currentFood.glycemicIndex || 'Medium';

        if (score >= 80) {
            circle.classList.add('score-high');
            feedback.innerHTML = '<strong>Excellent choice!</strong><br/> Ideal for ' + recFor + '. It has a ' + glyInd + ' Glycemic Index.';
        } else if (score >= 50) {
            circle.classList.add('score-mid');
            feedback.innerHTML = '<strong>Decent option.</strong><br/> Good in moderation. It has a ' + glyInd + ' Glycemic Index.';
        } else {
            circle.classList.add('score-low');
            feedback.innerHTML = '<strong>Low Quality.</strong><br/> Consider healthier alternatives. This is high in empty calories or fats.';
        }

        document.getElementById('score-value').innerText = score;
        document.getElementById('quality-modal').classList.add('show');
    }

    function closeQualityScore() { document.getElementById('quality-modal').classList.remove('show'); }

    document.addEventListener('click', function(event) {
        const searchBox = document.querySelector('.input-group');
        if (searchBox && !searchBox.contains(event.target)) {
            const dropdown = document.getElementById('search-results');
            if(dropdown) dropdown.style.display = 'none';
        }
    });

    // --- Scanner Logic ---
    function predictImage(event) {
        const input = event.target;
        if (input.files && input.files[0]) {
            const file = input.files[0];
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('visualizer-placeholder').style.display = 'none';
                const previewElement = document.getElementById('uploaded-image-preview');
                previewElement.src = e.target.result;
                previewElement.style.display = 'block';
            }
            reader.readAsDataURL(file);

            document.getElementById('prediction-result').style.display = 'block';
            document.getElementById('prediction-text').innerText = 'Analyzing Image with FoodYOLO...';
            document.getElementById('scan-badge').style.display = 'none';

            const formData = new FormData();
            formData.append('file', file);

            fetch('http://localhost:8000/predict', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                document.getElementById('prediction-result').style.display = 'none';
                if(data.success && data.predictions && data.predictions.length > 0) {
                    if (data.image) {
                        document.getElementById('uploaded-image-preview').src = data.image;
                    }
                    document.getElementById('scan-badge').style.display = 'block';
                    
                    const uniqueFoods = [...new Set(data.predictions.map(p => {
                        let cls = p.class;
                        return cls.charAt(0).toUpperCase() + cls.slice(1);
                    }))];
                    
                    uniqueFoods.forEach(f => {
                        addPlateItemFromPrediction(f);
                    });
                } else {
                    alert("No food detected. Try another image or add manually.");
                }
            })
            .catch(error => {
                console.error("FoodYOLO Error:", error);
                document.getElementById('prediction-result').style.display = 'block';
                document.getElementById('prediction-text').innerHTML = '<span style="color: var(--danger);">Failed to connect to FoodYOLO.</span>';
            });
        }
    }

    function addPlateItemFromPrediction(foodQuery) {
        fetch('/searchFood?q=' + encodeURIComponent(foodQuery))
            .then(res => res.json())
            .then(matches => {
                if (matches && matches.length > 0) {
                    const pItem = {
                        id: Date.now() + Math.random(),
                        query: foodQuery,
                        matches: matches,
                        selectedMatchIdx: 0,
                        quantity: 1
                    };
                    plateItems.push(pItem);
                    renderPlate();
                }
            });
    }

    // --- State & Rendering ---
    function renderPlate() {
        const list = document.getElementById('food-adjuster-items');
        list.innerHTML = '';
        
        let totalCal = 0, totalProt = 0, totalCarbs = 0, totalFats = 0;

        if (plateItems.length === 0) {
            list.innerHTML = '<p style="color:var(--text-muted); font-size:13px; text-align:center; padding: 20px 0;">No items added yet. Scan a plate or search below.</p>';
        }

        plateItems.forEach((item) => {
            const match = item.matches[item.selectedMatchIdx];
            const cal = match.calories * item.quantity;
            const prot = match.protein * item.quantity;
            const carbs = match.carbs * item.quantity;
            const fats = match.fats * item.quantity;
            
            totalCal += cal; totalProt += prot; totalCarbs += carbs; totalFats += fats;

            let optionsHtml = '';
            item.matches.forEach((m, i) => {
                optionsHtml += `<option value="\${i}" \${i === item.selectedMatchIdx ? 'selected' : ''}>\${m.foodName} (\${m.calories} kcal / \${m.servingUnit || 'unit'})</option>`;
            });

            const li = document.createElement('div');
            li.className = 'plate-item';
            li.innerHTML = `
                <div class="plate-item-header">
                    <select class="form-input" style="font-weight:600; padding:6px 10px; font-size:14px; width: 70%; text-overflow: ellipsis;" onchange="updatePlateItemMatch(\${item.id}, this.value)">
                        \${optionsHtml}
                    </select>
                    <span class="plate-item-cal">\${Math.round(cal)} kcal</span>
                </div>
                <div class="plate-item-controls">
                    <input type="range" class="range-slider" min="0.5" max="5" step="0.5" value="\${item.quantity}" oninput="updatePlateItemQty(\${item.id}, this.value)">
                    <span style="font-weight:700; font-size:13px; width: 40px; text-align:center;">\${item.quantity}x</span>
                    <button type="button" class="btn-remove" onclick="removePlateItem(\${item.id})">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h18M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2"/></svg>
                    </button>
                </div>
            `;
            list.appendChild(li);
        });

        document.getElementById('total-calories').innerText = Math.round(totalCal);
        document.getElementById('total-protein').innerText = totalProt.toFixed(1);
        document.getElementById('total-carbs').innerText = totalCarbs.toFixed(1);
        document.getElementById('total-fats').innerText = totalFats.toFixed(1);
        
        document.getElementById('bar-protein').style.width = Math.min((totalProt / 150) * 100, 100) + '%';
        document.getElementById('bar-carbs').style.width = Math.min((totalCarbs / 300) * 100, 100) + '%';
        document.getElementById('bar-fat').style.width = Math.min((totalFats / 70) * 100, 100) + '%';
        
        document.getElementById('plate-saving-section').style.display = plateItems.length > 0 ? 'block' : 'none';
    }

    function updatePlateItemMatch(id, newIdx) {
        const item = plateItems.find(p => p.id === id);
        if(item) { item.selectedMatchIdx = parseInt(newIdx); renderPlate(); }
    }
    function updatePlateItemQty(id, newQty) {
        const item = plateItems.find(p => p.id === id);
        if(item) { item.quantity = parseFloat(newQty); renderPlate(); }
    }
    function removePlateItem(id) {
        plateItems = plateItems.filter(p => p.id !== id);
        renderPlate();
    }
    function resetPlate() {
        plateItems = [];
        document.getElementById('uploaded-image-preview').style.display = 'none';
        document.getElementById('scan-badge').style.display = 'none';
        document.getElementById('visualizer-placeholder').style.display = 'block';
        document.getElementById('prediction-result').style.display = 'none';
        renderPlate();
    }

    // --- Save to Backend ---
    function logMealToHistory() {
        if(plateItems.length === 0) return;
        
        const btnSave = document.getElementById('btn-save-plate');
        btnSave.innerText = "Saving to History...";
        btnSave.disabled = true;

        const fetchPromises = plateItems.map(item => {
            const match = item.matches[item.selectedMatchIdx];
            const searchParams = new URLSearchParams();
            searchParams.append('foodId', match.id);
            searchParams.append('servingQty', item.quantity);
            searchParams.append('mealType', mealType);

            return fetch('/save-daily-log', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: searchParams.toString()
            });
        });

        Promise.all(fetchPromises)
            .then(() => {
                window.location.href = '/dashboard';
            })
            .catch(err => {
                console.error(err);
                alert("An error occurred while saving the meal.");
                btnSave.innerText = "Log Meal to History";
                btnSave.disabled = false;
            });
    }

</script>
</body>
</html>