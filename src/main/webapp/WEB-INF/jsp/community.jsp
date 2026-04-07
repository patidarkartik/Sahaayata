<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.sahaayata.minorproject.model.userCredential"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    userCredential user = (userCredential) session.getAttribute("loggedInUser");
    if (user == null) { response.sendRedirect("/login"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Community — Sahaayata</title>
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
        .page-body{flex:1;padding:24px;}

        /* community */
        .community-grid{display:grid;grid-template-columns:1fr 300px;gap:16px;}
        .recipe-feed{display:flex;flex-direction:column;gap:12px;}
        .feed-card{background:var(--bg-card);border:1px solid var(--sidebar-border);border-radius:var(--radius);overflow:hidden;}
        .feed-header{display:flex;align-items:center;gap:10px;padding:14px 16px;border-bottom:1px solid var(--sidebar-border);}
        .feed-avatar{width:36px;height:36px;border-radius:50%;}
        .feed-user{font-size:13.5px;font-weight:600;}
        .feed-time{font-size:11.5px;color:var(--text-light);}
        .feed-body{padding:14px 16px;}
        .feed-title{font-size:15px;font-weight:600;margin-bottom:4px;}
        .feed-desc{font-size:13px;color:var(--text-muted);line-height:1.5;}
        .feed-tags{display:flex;flex-wrap:wrap;gap:6px;margin-top:10px;}
        .tag{background:var(--primary-light);color:var(--primary);font-size:11.5px;font-weight:600;padding:3px 9px;border-radius:99px;}
        .feed-footer{display:flex;align-items:center;gap:14px;padding:10px 16px;border-top:1px solid var(--sidebar-border);}
        .feed-action{display:flex;align-items:center;gap:5px;font-size:12.5px;color:var(--text-light);cursor:pointer;transition:color .15s;}
        .feed-action:hover{color:var(--primary);}

        .sidebar-right{display:flex;flex-direction:column;gap:12px;align-self:start;position:sticky;top:72px;}
        .card{background:var(--bg-card);border:1px solid var(--sidebar-border);border-radius:var(--radius);padding:16px;}
        .card-title{font-size:13px;font-weight:600;color:var(--text-muted);text-transform:uppercase;letter-spacing:.04em;margin-bottom:12px;}
        .top-user{display:flex;align-items:center;gap:10px;padding:6px 0;}
        .top-avatar{width:32px;height:32px;border-radius:50%;}
        .top-name{font-size:13px;font-weight:500;}
        .top-count{font-size:11.5px;color:var(--text-light);}

        .sidebar-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.35);z-index:99;}
        @media(max-width:900px){.community-grid{grid-template-columns:1fr;}.sidebar-right{display:none;}}
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
            <a href="/community" class="nav-link active"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>Community</a>
            <p class="nav-section" style="margin-top:1.25rem;">Account</p>
            <a href="/settings" class="nav-link"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/></svg>Settings</a>
            <a href="/change-password" class="nav-link"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>Change Password</a>
        </nav>
        <div class="sidebar-footer">
            <a href="/logout" class="logout-btn"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="15" height="15"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>Logout</a>
        </div>
    </aside>
    <div class="sidebar-overlay" id="overlay" onclick="toggleSidebar()"></div>

    <div class="main-content">
        <header class="topbar">
            <button class="hamburger" onclick="toggleSidebar()"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg></button>
            <span class="topbar-title">Community</span>
        </header>
        <div class="page-body">
            <div class="community-grid">
                <div class="recipe-feed">
                    <%-- Dynamic feed rendered from model --%>
                    <c:choose>
                        <c:when test="${not empty communityRecipes}">
                            <c:forEach var="r" items="${communityRecipes}">
                            <div class="feed-card">
                                <div class="feed-header">
                                    <img class="feed-avatar" src="https://ui-avatars.com/api/?name=${r.authorName}&background=4F6FEB&color=fff&size=72" alt="avatar"/>
                                    <div>
                                        <p class="feed-user">${r.authorName}</p>
                                        <p class="feed-time">${r.postedDate}</p>
                                    </div>
                                </div>
                                <div class="feed-body">
                                    <p class="feed-title">${r.name}</p>
                                    <p class="feed-desc">${r.description}</p>
                                    <div class="feed-tags">
                                        <c:forEach var="tag" items="${r.tags}"><span class="tag">${tag}</span></c:forEach>
                                    </div>
                                </div>
                                <div class="feed-footer">
                                    <span class="feed-action">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.84 4.61a5.5 5.5 0 00-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 00-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 000-7.78z"/></svg>
                                        ${r.likes} Likes
                                    </span>
                                    <span class="feed-action">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg>
                                        Comment
                                    </span>
                                    <span class="feed-action">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="18" cy="5" r="3"/><circle cx="6" cy="12" r="3"/><circle cx="18" cy="19" r="3"/><line x1="8.59" y1="13.51" x2="15.42" y2="17.49"/><line x1="15.41" y1="6.51" x2="8.59" y2="10.49"/></svg>
                                        Share
                                    </span>
                                </div>
                            </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align:center;padding:60px 20px;color:var(--text-light);">
                                <svg width="56" height="56" viewBox="0 0 24 24" fill="none" stroke="#4F6FEB" stroke-width="1" style="opacity:.25;margin:0 auto 14px;display:block;"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>
                                <p style="font-size:15px;font-weight:500;color:var(--text-muted);margin-bottom:4px;">No community posts yet</p>
                                <p style="font-size:13px;">Be the first to share a recipe!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <aside class="sidebar-right">
                    <div class="card">
                        <p class="card-title">Top Contributors</p>
                        <div class="top-user"><img class="top-avatar" src="https://ui-avatars.com/api/?name=Priya+Sharma&background=10b981&color=fff&size=64" alt=""/><div><p class="top-name">Priya Sharma</p><p class="top-count">12 recipes</p></div></div>
                        <div class="top-user"><img class="top-avatar" src="https://ui-avatars.com/api/?name=Arjun+Mehta&background=f59e0b&color=fff&size=64" alt=""/><div><p class="top-name">Arjun Mehta</p><p class="top-count">9 recipes</p></div></div>
                        <div class="top-user"><img class="top-avatar" src="https://ui-avatars.com/api/?name=Sneha+Rao&background=ef4444&color=fff&size=64" alt=""/><div><p class="top-name">Sneha Rao</p><p class="top-count">7 recipes</p></div></div>
                    </div>
                    <div class="card">
                        <p class="card-title">Popular Tags</p>
                        <div style="display:flex;flex-wrap:wrap;gap:6px;">
                            <span style="background:var(--primary-light);color:var(--primary);font-size:12px;font-weight:600;padding:4px 10px;border-radius:99px;">#HighProtein</span>
                            <span style="background:#FEF3C7;color:#d97706;font-size:12px;font-weight:600;padding:4px 10px;border-radius:99px;">#Vegan</span>
                            <span style="background:#D1FAE5;color:#059669;font-size:12px;font-weight:600;padding:4px 10px;border-radius:99px;">#LowCarb</span>
                            <span style="background:#FEE2E2;color:#dc2626;font-size:12px;font-weight:600;padding:4px 10px;border-radius:99px;">#Keto</span>
                            <span style="background:#EDE9FE;color:#7c3aed;font-size:12px;font-weight:600;padding:4px 10px;border-radius:99px;">#QuickMeals</span>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </div>
</div>
<script>function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');document.getElementById('overlay').classList.toggle('show');}</script>
</body>
</html>
