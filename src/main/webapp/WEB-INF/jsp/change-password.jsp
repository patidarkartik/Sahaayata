<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.sahaayata.minorproject.model.UserCredential"%>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);
    UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
    if (user == null) { response.sendRedirect("/login"); return; }

    // Flash attributes from RedirectAttributes are stored in session
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Change Password — Sahaayata</title>
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
        .main-content{flex:1;margin-left:var(--sidebar-width);display:flex;flex-direction:column;}
        .topbar{background:var(--bg-card);border-bottom:1px solid var(--sidebar-border);padding:0 24px;height:56px;display:flex;align-items:center;gap:12px;position:sticky;top:0;z-index:50;}
        .topbar-title{font-size:16px;font-weight:600;}
        .hamburger{display:none;background:none;border:none;cursor:pointer;color:var(--text-main);}
        .page-body{flex:1;padding:24px;display:flex;align-items:flex-start;}
        .form-card{background:var(--bg-card);border:1px solid var(--sidebar-border);border-radius:var(--radius);padding:28px;width:100%;max-width:460px;}
        .form-card-title{font-size:17px;font-weight:700;margin-bottom:4px;}
        .form-card-sub{font-size:13px;color:var(--text-light);margin-bottom:24px;}
        .form-group{margin-bottom:16px;}
        .form-label{display:block;font-size:12px;font-weight:600;color:var(--text-muted);margin-bottom:6px;text-transform:uppercase;letter-spacing:.04em;}
        .input-wrapper{position:relative;}
        .form-input{width:100%;padding:9px 40px 9px 12px;border:1px solid var(--sidebar-border);border-radius:8px;font-size:14px;font-family:var(--font);color:var(--text-main);background:#fff;outline:none;transition:border-color .15s;}
        .form-input:focus{border-color:var(--primary);}
        .toggle-pw{position:absolute;right:10px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:var(--text-light);padding:4px;display:flex;align-items:center;transition:color .15s;}
        .toggle-pw:hover{color:var(--text-main);}
        .btn-primary{background:var(--primary);color:#fff;border:none;padding:10px 0;border-radius:8px;font-size:14px;font-weight:600;cursor:pointer;transition:background .15s, transform .1s;width:100%;}
        .btn-primary:hover{background:var(--primary-dark);}
        .btn-primary:active{transform:scale(0.98);}
        .btn-primary:disabled{opacity:.6;cursor:not-allowed;}

        /* Alerts */
        .alert{padding:10px 14px;border-radius:8px;font-size:13.5px;margin-bottom:18px;display:flex;align-items:center;gap:8px;animation:slideDown .3s ease;}
        .alert-error{background:#FEF2F2;color:#dc2626;border:1px solid #FCA5A5;}
        .alert-success{background:#D1FAE5;color:#059669;border:1px solid #6EE7B7;}
        @keyframes slideDown{from{opacity:0;transform:translateY(-8px);}to{opacity:1;transform:translateY(0);}}

        /* Password strength bar */
        .pw-strength{height:4px;border-radius:2px;background:#e5e7eb;margin-top:6px;overflow:hidden;transition:opacity .2s;}
        .pw-strength-bar{height:100%;border-radius:2px;width:0;transition:width .3s, background .3s;}
        .pw-hint{font-size:11px;color:var(--text-light);margin-top:4px;transition:color .2s;}

        .sidebar-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.35);z-index:99;}
        @media(max-width:768px){.sidebar{transform:translateX(-100%);}
            .sidebar.open{transform:translateX(0);}.sidebar-overlay.show{display:block;}.main-content{margin-left:0;}.hamburger{display:flex;}.page-body{padding:14px;}}
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
            <a href="/settings" class="nav-link"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/></svg>Settings</a>
            <a href="/change-password" class="nav-link active"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>Change Password</a>
        </nav>
        <div class="sidebar-footer">
            <a href="/logout" class="logout-btn"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="15" height="15"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>Logout</a>
        </div>
    </aside>
    <div class="sidebar-overlay" id="overlay" onclick="toggleSidebar()"></div>

    <div class="main-content">
        <header class="topbar">
            <button class="hamburger" onclick="toggleSidebar()"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg></button>
            <span class="topbar-title">Change Password</span>
        </header>
        <div class="page-body">
            <div class="form-card">
                <p class="form-card-title">Update Password</p>
                <p class="form-card-sub">Choose a strong new password to secure your account.</p>

                <% if (error != null) { %><div class="alert alert-error">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M15 9l-6 6M9 9l6 6"/></svg>
                    <%= error %>
                </div><% } %>
                <% if (success != null) { %><div class="alert alert-success">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><path d="M22 4L12 14.01l-3-3"/></svg>
                    <%= success %>
                </div><% } %>

                <form action="/change-password" method="post" id="changePasswordForm">
                    <div class="form-group">
                        <label class="form-label">Current Password</label>
                        <div class="input-wrapper">
                            <input type="password" class="form-input" name="currentPassword" id="currentPassword" required autocomplete="current-password"/>
                            <button type="button" class="toggle-pw" onclick="togglePassword('currentPassword', this)" title="Show password">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">New Password</label>
                        <div class="input-wrapper">
                            <input type="password" class="form-input" name="newPassword" id="newPassword" required minlength="8" autocomplete="new-password" oninput="checkStrength(this.value)"/>
                            <button type="button" class="toggle-pw" onclick="togglePassword('newPassword', this)" title="Show password">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                            </button>
                        </div>
                        <div class="pw-strength"><div class="pw-strength-bar" id="strengthBar"></div></div>
                        <p class="pw-hint" id="strengthHint">Minimum 8 characters</p>
                    </div>
                    <div class="form-group" style="margin-bottom:22px;">
                        <label class="form-label">Confirm New Password</label>
                        <div class="input-wrapper">
                            <input type="password" class="form-input" name="confirmPassword" id="confirmPassword" required minlength="8" autocomplete="new-password" oninput="checkMatch()"/>
                            <button type="button" class="toggle-pw" onclick="togglePassword('confirmPassword', this)" title="Show password">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                            </button>
                        </div>
                        <p class="pw-hint" id="matchHint" style="opacity:0;">&nbsp;</p>
                    </div>
                    <button type="submit" class="btn-primary" id="submitBtn">Update Password</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
function toggleSidebar(){
    document.getElementById('sidebar').classList.toggle('open');
    document.getElementById('overlay').classList.toggle('show');
}

function togglePassword(inputId, btn){
    var inp = document.getElementById(inputId);
    if(inp.type === 'password'){
        inp.type = 'text';
        btn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17.94 17.94A10.07 10.07 0 0112 20c-7 0-11-8-11-8a18.45 18.45 0 015.06-5.94M9.9 4.24A9.12 9.12 0 0112 4c7 0 11 8 11 8a18.5 18.5 0 01-2.16 3.19m-6.72-1.07a3 3 0 11-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>';
    } else {
        inp.type = 'password';
        btn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>';
    }
}

function checkStrength(pw){
    var bar = document.getElementById('strengthBar');
    var hint = document.getElementById('strengthHint');
    var score = 0;
    if(pw.length >= 8) score++;
    if(pw.length >= 12) score++;
    if(/[A-Z]/.test(pw)) score++;
    if(/[0-9]/.test(pw)) score++;
    if(/[^A-Za-z0-9]/.test(pw)) score++;

    var widths = ['0%','20%','40%','60%','80%','100%'];
    var colors = ['#e5e7eb','#ef4444','#f97316','#eab308','#22c55e','#059669'];
    var labels = ['Minimum 8 characters','Very Weak','Weak','Fair','Strong','Very Strong'];

    bar.style.width = widths[score];
    bar.style.background = colors[score];
    hint.textContent = labels[score];
    hint.style.color = colors[score];

    checkMatch();
}

function checkMatch(){
    var np = document.getElementById('newPassword').value;
    var cp = document.getElementById('confirmPassword').value;
    var hint = document.getElementById('matchHint');

    if(cp.length === 0){
        hint.style.opacity = '0';
        return;
    }
    hint.style.opacity = '1';
    if(np === cp){
        hint.textContent = '✓ Passwords match';
        hint.style.color = '#059669';
    } else {
        hint.textContent = '✗ Passwords do not match';
        hint.style.color = '#dc2626';
    }
}

// Auto-dismiss alerts after 5 seconds
document.addEventListener('DOMContentLoaded', function(){
    var alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(el){
        setTimeout(function(){
            el.style.transition = 'opacity .4s, transform .4s';
            el.style.opacity = '0';
            el.style.transform = 'translateY(-8px)';
            setTimeout(function(){ el.remove(); }, 400);
        }, 5000);
    });
});
</script>
</body>
</html>
