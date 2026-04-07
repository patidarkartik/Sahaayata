<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.sahaayata.minorproject.model.userCredential"%>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);
    userCredential user = (userCredential) session.getAttribute("loggedInUser");
    if (user == null) { response.sendRedirect("/login"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Settings — Sahaayata</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        :root{--primary:#4F6FEB;--primary-light:#EEF1FD;--primary-dark:#3451C7;--sidebar-width:240px;--sidebar-bg:#fff;--sidebar-border:#E8EAED;--text-main:#1a1d23;--text-muted:#6b7280;--text-light:#9ca3af;--bg-page:#F4F6FB;--bg-card:#fff;--nav-hover:#F4F6FB;--nav-active-bg:#EEF1FD;--nav-active-text:#4F6FEB;--radius:10px;--font:'DM Sans',system-ui,sans-serif;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        body{font-family:var(--font);background:var(--bg-page);color:var(--text-main);min-height:100vh;}
        .app-layout{display:flex;min-height:100vh;}
        .sidebar{width:var(--sidebar-width);background:var(--sidebar-bg);border-right:1px solid var(--sidebar-border);display:flex;flex-direction:column;position:fixed;top:0;left:0;bottom:0;z-index:100;transition:transform .25s ease;overflow-y:auto;}
        .sidebar-brand{display:flex;align-items:center;gap:10px;padding:20px 20px 16px;border-bottom:1px solid var(--sidebar-border);color:var(--primary);}
        .brand-icon{width:26px;height:26px;}.brand-name{font-size:17px;font-weight:700;color:var(--text-main);letter-spacing:-.3px;}
        .sidebar-user{display:flex;align-items:center;gap:10px;padding:14px 20px;border-bottom:1px solid var(--sidebar-border);}
        .user-avatar{width:36px;height:36px;border-radius:50%;}.user-name{font-size:13px;font-weight:600;}.user-role{font-size:11px;color:var(--text-light);}
        .sidebar-nav{flex:1;padding:14px 12px;display:flex;flex-direction:column;gap:2px;}
        .nav-section{font-size:10px;font-weight:600;text-transform:uppercase;letter-spacing:.08em;color:var(--text-light);padding:8px 8px 6px;}
        .nav-link{display:flex;align-items:center;gap:10px;padding:9px 10px;border-radius:8px;text-decoration:none;color:var(--text-muted);font-size:13.5px;font-weight:500;transition:background .15s,color .15s;}
        .nav-link:hover{background:var(--nav-hover);color:var(--text-main);}.nav-link.active{background:var(--nav-active-bg);color:var(--nav-active-text);font-weight:600;}
        .nav-icon{width:16px;height:16px;flex-shrink:0;}
        .sidebar-footer{padding:12px;border-top:1px solid var(--sidebar-border);}
        .logout-btn{display:flex;align-items:center;gap:8px;padding:9px 10px;border-radius:8px;border:none;background:none;color:#ef4444;font-size:13.5px;font-weight:500;cursor:pointer;text-decoration:none;transition:background .15s;width:100%;}.logout-btn:hover{background:#FEF2F2;}
        .main-content{flex:1;margin-left:var(--sidebar-width);display:flex;flex-direction:column;min-height:100vh;}
        .topbar{background:var(--bg-card);border-bottom:1px solid var(--sidebar-border);padding:0 24px;height:56px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:50;}
        .topbar-title{font-size:16px;font-weight:600;}
        .hamburger{display:none;background:none;border:none;cursor:pointer;color:var(--text-main);}
        .page-body{flex:1;padding:24px;max-width:680px;}

        /* settings */
        .settings-section{background:var(--bg-card);border:1px solid var(--sidebar-border);border-radius:var(--radius);margin-bottom:18px;overflow:hidden;}
        .section-header{padding:16px 20px;border-bottom:1px solid var(--sidebar-border);}
        .section-title{font-size:14px;font-weight:600;}
        .section-sub{font-size:12px;color:var(--text-light);margin-top:2px;}
        .section-body{padding:20px;}
        .form-group{margin-bottom:16px;}
        .form-label{display:block;font-size:12px;font-weight:600;color:var(--text-muted);margin-bottom:6px;text-transform:uppercase;letter-spacing:.04em;}
        .form-input,.form-select{width:100%;padding:9px 12px;border:1px solid var(--sidebar-border);border-radius:8px;font-size:14px;font-family:var(--font);color:var(--text-main);background:#fff;outline:none;transition:border-color .15s;}
        .form-input:focus,.form-select:focus{border-color:var(--primary);}
        .form-row{display:grid;grid-template-columns:1fr 1fr;gap:14px;}
        .btn-primary{background:var(--primary);color:#fff;border:none;padding:9px 18px;border-radius:8px;font-size:13.5px;font-weight:600;cursor:pointer;transition:background .15s;}
        .btn-primary:hover{background:var(--primary-dark);}

        /* avatar section */
        .avatar-row{display:flex;align-items:center;gap:16px;margin-bottom:20px;}
        .avatar-lg{width:64px;height:64px;border-radius:50%;}
        .avatar-info p{font-size:13px;color:var(--text-light);margin-top:3px;}

        .sidebar-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.35);z-index:99;}
        @media(max-width:768px){
            .sidebar{transform:translateX(-100%);}
            .sidebar.open{transform:translateX(0);}
            .sidebar-overlay.show{display:block;}
            .main-content{margin-left:0;}
            .hamburger{display:flex;}
            .page-body{padding:14px;}
            .form-row{grid-template-columns:1fr;}
        }
    </style>
</head>
<body>
<div class="app-layout">
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <svg class="brand-icon" viewBox="0 0 48 48" fill="none"><path clip-rule="evenodd" d="M24 4H6V17.3333V30.6667H24V44H42V30.6667V17.3333H24V4Z" fill="currentColor" fill-rule="evenodd"/></svg>
            <span class="brand-name">Sahaayata</span>
        </div>
        <div class="sidebar-user">
            <img class="user-avatar" src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=4F6FEB&color=fff&size=80" alt="avatar"/>
            <div><p class="user-name"><%= user.getUsername() %></p><p class="user-role">Member</p></div>
        </div>
        <nav class="sidebar-nav">
            <p class="nav-section">Main</p>
            <a href="/dashboard" class="nav-link"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/></svg>Dashboard</a>
            <a href="/my-recipes" class="nav-link"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/><rect x="9" y="3" width="6" height="4" rx="1"/><path d="M9 12h6M9 16h4"/></svg>My Recipes</a>
            <a href="/create-recipe" class="nav-link"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v8M8 12h8"/></svg>Create Recipe</a>
            <a href="/community" class="nav-link"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>Community</a>
            <p class="nav-section" style="margin-top:1.25rem;">Account</p>
            <a href="/settings" class="nav-link active"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/></svg>Settings</a>
            <a href="/change-password" class="nav-link"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>Change Password</a>
        </nav>
        <div class="sidebar-footer">
            <a href="/logout" class="logout-btn"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="15" height="15"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>Logout</a>
        </div>
    </aside>
    <div class="sidebar-overlay" id="overlay" onclick="toggleSidebar()"></div>

    <div class="main-content">
        <header class="topbar">
            <div style="display:flex;align-items:center;gap:12px;">
                <button class="hamburger" onclick="toggleSidebar()"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg></button>
                <span class="topbar-title">Settings</span>
            </div>
        </header>

        <div class="page-body">

            <!-- Profile -->
            <div class="settings-section">
                <div class="section-header">
                    <p class="section-title">Profile</p>
                    <p class="section-sub">Update your personal information</p>
                </div>
                <div class="section-body">
                    <div class="avatar-row">
                        <img class="avatar-lg" src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&background=4F6FEB&color=fff&size=128" alt="avatar"/>
                        <div>
                            <p style="font-size:14px;font-weight:600;"><%= user.getUsername() %></p>
                            <p style="font-size:13px;color:var(--text-light);">Avatar generated from name</p>
                        </div>
                    </div>
                    <form action="/update-profile" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-input" name="username" value="<%= user.getUsername() %>"/>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-input" name="email" value="<%= user.getEmail() %>"/>
                            </div>
                        </div>
                        <button type="submit" class="btn-primary">Save Changes</button>
                    </form>
                </div>
            </div>

            <!-- Body Stats -->
            <div class="settings-section">
                <div class="section-header">
                    <p class="section-title">Body Stats</p>
                    <p class="section-sub">Used to calculate your daily calorie target</p>
                </div>
                <div class="section-body">
                    <form action="/update-stats" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Age</label>
                                <input type="number" class="form-input" name="age" value="<%= user.getAge() %>" min="10" max="100"/>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Gender</label>
                                <select class="form-select" name="gender">
                                    <option value="Male" <%= "Male".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Male</option>
                                    <option value="Female" <%= "Female".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Height (cm)</label>
                                <input type="number" class="form-input" name="height" value="<%= user.getHeight() %>"/>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Weight (kg)</label>
                                <input type="number" class="form-input" name="weight" value="<%= user.getWeight() %>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Activity Level</label>
                            <select class="form-select" name="activityLevel">
                                <option value="1.2" <%= "1.2".equals(user.getActivityLevel()) ? "selected" : "" %>>Sedentary (little or no exercise)</option>
                                <option value="1.375" <%= "1.375".equals(user.getActivityLevel()) ? "selected" : "" %>>Lightly Active (1–3 days/week)</option>
                                <option value="1.55" <%= "1.55".equals(user.getActivityLevel()) ? "selected" : "" %>>Moderately Active (3–5 days/week)</option>
                                <option value="1.725" <%= "1.725".equals(user.getActivityLevel()) ? "selected" : "" %>>Very Active (6–7 days/week)</option>
                                <option value="1.9" <%= "1.9".equals(user.getActivityLevel()) ? "selected" : "" %>>Extra Active (physical job)</option>
                            </select>
                        </div>
                        <button type="submit" class="btn-primary">Update Stats</button>
                    </form>
                </div>
            </div>

            <!-- Danger zone -->
            <div class="settings-section">
                <div class="section-header">
                    <p class="section-title" style="color:#ef4444;">Danger Zone</p>
                    <p class="section-sub">These actions are permanent</p>
                </div>
                <div class="section-body">
                    <a href="/change-password" style="display:inline-flex;align-items:center;gap:6px;font-size:13.5px;font-weight:600;color:var(--primary);text-decoration:none;margin-bottom:12px;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>
                        Change Password
                    </a>
                    <br/>
                    <a href="/logout" style="display:inline-flex;align-items:center;gap:6px;font-size:13.5px;font-weight:600;color:#ef4444;text-decoration:none;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>
                        Sign Out
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>
<script>function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');document.getElementById('overlay').classList.toggle('show');}</script>
</body>
</html>
