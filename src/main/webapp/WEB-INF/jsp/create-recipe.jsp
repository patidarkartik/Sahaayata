<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sahaayata.minorproject.model.UserCredential" %>

<%-- SECURITY CHECK --%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Create Recipe — Sahaayata</title>
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
            --success: #10b981; --danger: #ef4444;
            --radius: 12px; --font: 'Inter', system-ui, sans-serif;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: var(--font); background: var(--bg-page); color: var(--text-main); min-height: 100vh; }

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
        .page-body { flex: 1; padding: 24px; display: flex; justify-content: center; align-items: flex-start; }

        .form-card { background: var(--bg-card); border: 1px solid var(--sidebar-border); border-radius: var(--radius); padding: 32px; width: 100%; max-width: 600px; box-shadow: 0px 4px 16px rgba(15, 23, 42, 0.03); }
        .form-card-title { font-size: 20px; font-weight: 700; margin-bottom: 6px; }
        .form-card-sub { font-size: 13.5px; color: var(--text-light); margin-bottom: 28px; }

        .form-group { margin-bottom: 20px; }
        .form-label { display: block; font-size: 12.5px; font-weight: 600; color: var(--text-muted); margin-bottom: 8px; text-transform: uppercase; letter-spacing: .04em; }
        .form-input { width: 100%; padding: 10px 16px; border: 1px solid var(--sidebar-border); border-radius: 99px !important; font-size: 14.5px; font-family: var(--font); color: var(--text-main); background: #fff; outline: none; transition: border-color .15s; }
        .form-input:focus { border-color: var(--primary); }
        textarea.form-input { resize: vertical; min-height: 120px; border-radius: 16px !important; }

        .form-actions { display: flex; gap: 12px; margin-top: 32px; }
        .btn-primary { background: linear-gradient(135deg, #0058be 0%, #004395 100%); color: #fff; border: none; padding: 10px 20px; border-radius: 99px !important; font-size: 14px; font-weight: 600; cursor: pointer; transition: all .15s; text-align: center; flex: 1; box-shadow: 0 4px 12px rgba(0, 88, 190, 0.2); }
        .btn-primary:hover { box-shadow: 0 6px 16px rgba(0, 88, 190, 0.3); transform: translateY(-1px); }
        .btn-primary:disabled { background: var(--text-light); cursor: not-allowed; }
        .btn-secondary { background: var(--bg-page); color: var(--text-muted); border: 1px solid var(--sidebar-border); padding: 10px 20px; border-radius: 99px !important; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: all .15s; text-align: center; }
        .btn-secondary:hover { background: #E8EAED; color: var(--text-main); }

        .ai-box { background: var(--primary-light); padding: 16px; border-radius: 8px; margin-bottom: 20px; border: 1px dashed var(--primary); }
        .ai-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .macro-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-top: 12px; }
        .macro-card { display: flex; flex-direction: column; gap: 4px; }

        /* Uneditable styling specifically for macros */
        .macro-input-readonly { background: #e5e7eb; cursor: not-allowed; text-align: center; font-weight: 700; color: var(--primary-dark); border: 1px solid #d1d5db; }

        .toggle-box { display: flex; justify-content: space-between; align-items: center; background: var(--bg-page); padding: 16px; border-radius: 8px; border: 1px solid var(--sidebar-border); margin-top: 24px; }
        .toggle-text-main { font-size: 14px; font-weight: 600; margin-bottom: 2px; }
        .toggle-text-sub { font-size: 12px; color: var(--text-light); }
        .switch { position: relative; display: inline-block; width: 44px; height: 24px; }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #cbd5e1; transition: .3s; border-radius: 24px; }
        .slider:before { position: absolute; content: ""; height: 18px; width: 18px; left: 3px; bottom: 3px; background-color: white; transition: .3s; border-radius: 50%; }
        input:checked + .slider { background-color: var(--primary); }
        input:checked + .slider:before { transform: translateX(20px); }

        .sidebar-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,.35); z-index: 99; }
        @media(max-width:768px){
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .sidebar-overlay.show { display: block; }
            .main-content { margin-left: 0; }
            .hamburger { display: flex; }
            .page-body { padding: 14px; }
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
            <img class="user-avatar" src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=0058be&color=fff&size=80" alt="avatar"/>
            <div><p class="user-name"><%= user.getUsername() %></p><p class="user-role">Member</p></div>
        </div>
        <nav class="sidebar-nav">
            <p class="nav-section">Main</p>
            <a href="/dashboard" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/></svg>
                Dashboard
            </a>
            <a href="/my-recipes" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/><rect x="9" y="3" width="6" height="4" rx="1"/><path d="M9 12h6M9 16h4"/></svg>
                My Recipes
            </a>
            <a href="/create-recipe" class="nav-link active">
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
            <button class="hamburger" onclick="toggleSidebar()">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>
            </button>
            <span class="topbar-title">Create Recipe</span>
        </header>

        <div class="page-body">
            <div class="form-card">
                <p class="form-card-title">Create a New Recipe</p>
                <p class="form-card-sub">Share your culinary creations with the Sahaayata community.</p>

                <form action="/save-recipe" method="POST">

                    <div class="form-group">
                        <label class="form-label">Recipe Name</label>
                        <input name="title" id="recipe-title" required class="form-input" placeholder="e.g., Green Power Smoothie" type="text"/>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Description & Instructions</label>
                        <textarea name="description" id="recipe-desc" required class="form-input" placeholder="Describe your recipe, steps, and ingredients here... (e.g., 50g oats, 1 banana, 200ml milk)"></textarea>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Number of Servings</label>
                        <input type="number" name="servings" id="input-servings" class="form-input" value="1" min="0" step="0.5" placeholder="e.g., 2" readonly required />
                    </div>

                    <div class="ai-box">
                        <div class="ai-header">
                            <span style="font-weight: 700; color: var(--primary-dark); font-size: 13.5px;">✨ Sahaayata AI Analyzer</span>
                            <button type="button" id="btn-ai-calc" onclick="calculateMacrosWithAI()" style="background: var(--primary); color: #fff; border: none; padding: 6px 12px; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 12px; transition: 0.2s;">
                                Analyze Macros
                            </button>
                        </div>

                        <p id="ai-status" style="font-size: 12.5px; color: var(--text-muted); display: none; margin-bottom: 8px;"></p>

                        <div class="macro-grid" id="macro-results">
                            <div class="macro-card">
                                <span style="font-size: 11px; color: var(--text-muted); font-weight: 600; text-align: center;">CALORIES</span>
                                <input type="number" step="0.1" name="calories" id="input-cal" value="0" class="form-input macro-input-readonly" readonly>
                            </div>
                            <div class="macro-card">
                                <span style="font-size: 11px; color: var(--text-muted); font-weight: 600; text-align: center;">PROTEIN (g)</span>
                                <input type="number" step="0.1" name="protein" id="input-pro" value="0" class="form-input macro-input-readonly" readonly>
                            </div>
                            <div class="macro-card">
                                <span style="font-size: 11px; color: var(--text-muted); font-weight: 600; text-align: center;">CARBS (g)</span>
                                <input type="number" step="0.1" name="carbs" id="input-carb" value="0" class="form-input macro-input-readonly" readonly>
                            </div>
                            <div class="macro-card">
                                <span style="font-size: 11px; color: var(--text-muted); font-weight: 600; text-align: center;">FATS (g)</span>
                                <input type="number" step="0.1" name="fats" id="input-fat" value="0" class="form-input macro-input-readonly" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Image URL (Optional)</label>
                        <input name="imageUrl" class="form-input" placeholder="https://example.com/food-image.jpg" type="url"/>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Tags (Comma separated)</label>
                        <input type="text" name="tags" class="form-input" placeholder="e.g., #HighProtein, #Vegan, #Breakfast">
                    </div>

                    <div class="toggle-box">
                        <div>
                            <p class="toggle-text-main">Make Public</p>
                            <p class="toggle-text-sub">Share your recipe with the community.</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox" name="public" value="true" checked>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-primary" id="submit-recipe-btn">Create Recipe</button>
                        <a href="/my-recipes" class="btn-secondary">Cancel</a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const descInput = document.getElementById('recipe-desc');
        if (descInput) {
            descInput.addEventListener('input', function() {
                if (this.value.trim() === '') {
                    document.getElementById('input-cal').value = 0;
                    document.getElementById('input-pro').value = 0;
                    document.getElementById('input-carb').value = 0;
                    document.getElementById('input-fat').value = 0;
                    document.getElementById('input-servings').value = 0;
                    
                    const statusEl = document.getElementById('ai-status');
                    if (statusEl) {
                        statusEl.style.display = 'none';
                        const btn = document.getElementById('btn-ai-calc');
                        if (btn) btn.innerText = "Analyze Macros";
                    }
                }
            });
        }
    });

    function toggleSidebar(){
        document.getElementById('sidebar').classList.toggle('open');
        document.getElementById('overlay').classList.toggle('show');
    }

    async function calculateMacrosWithAI() {
        const title = document.getElementById('recipe-title').value;
        const desc = document.getElementById('recipe-desc').value;

        const statusEl = document.getElementById('ai-status');
        const btn = document.getElementById('btn-ai-calc');

        if(desc.trim().length < 10 || title.trim().length === 0) {
            alert("Please enter both Recipe Name and Description first!");
            return;
        }

        btn.disabled = true;
        btn.innerText = "Analyzing...";
        statusEl.style.display = 'block';
        statusEl.innerText = "AI is thinking... please wait.";
        statusEl.style.color = "var(--text-muted)";

        try {
            const webhookUrl = '${n8nWebhookUrl}/webhook/analyze-macros';
            console.log("Hitting Webhook: ", webhookUrl);

            const response = await fetch(webhookUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ title: title, text: desc })
            });

            if (response.ok) {
                let data = await response.json();

                if (Array.isArray(data)) {
                    data = data[0];
                }

                document.getElementById('input-cal').value = data.calories || 0;
                document.getElementById('input-pro').value = data.protein || 0;
                document.getElementById('input-carb').value = data.carbs || 0;
                document.getElementById('input-fat').value = data.fats || 0;
                document.getElementById('input-servings').value = data.servings || 0;

                statusEl.innerText = "✅ Macros calculated successfully!";
                statusEl.style.color = "var(--success)";
            } else {
                throw new Error("Failed to fetch from n8n. Status: " + response.status);
            }
        } catch (error) {
            console.error("AI Error:", error);
            statusEl.innerText = "❌ AI Server error. Check console for details.";
            statusEl.style.color = "var(--danger)";
        } finally {
            btn.disabled = false;
            btn.innerText = "Re-analyze";
        }
    }
</script>
</body>
</html>