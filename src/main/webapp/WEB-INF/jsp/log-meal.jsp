<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>

<%-- SECURITY & LOGIC CHECK --%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    userCredential user = (userCredential) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("/login");
        return;
    }

    // Safely fetch the 'meal' parameter from the URL
    String mealParam = request.getParameter("meal");
    String currentMeal = (mealParam != null && !mealParam.trim().isEmpty()) ? mealParam : "Breakfast";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Add Today's Meal — Sahaayata</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --primary: #4F6FEB; --primary-light: #EEF1FD; --primary-dark: #3451C7;
            --sidebar-width: 240px; --sidebar-bg: #fff; --sidebar-border: #E8EAED;
            --text-main: #1a1d23; --text-muted: #6b7280; --text-light: #9ca3af;
            --bg-page: #F4F6FB; --bg-card: #fff;
            --nav-hover: #F4F6FB; --nav-active-bg: #EEF1FD; --nav-active-text: #4F6FEB;
            --radius: 10px; --font: 'DM Sans', system-ui, sans-serif;
            --danger: #ef4444; --success: #10b981; --warning: #f59e0b;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: var(--font); background: var(--bg-page); color: var(--text-main); min-height: 100vh; overflow-x: hidden; }

        /* Layout & Sidebar */
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

        /* Main Content */
        .main-content { flex: 1; margin-left: var(--sidebar-width); display: flex; flex-direction: column; }
        .topbar { background: var(--bg-card); border-bottom: 1px solid var(--sidebar-border); padding: 0 24px; height: 56px; display: flex; align-items: center; gap: 12px; position: sticky; top: 0; z-index: 50; }
        .topbar-title { font-size: 16px; font-weight: 600; }
        .hamburger { display: none; background: none; border: none; cursor: pointer; color: var(--text-main); }
        .page-body { flex: 1; padding: 24px; display: flex; flex-direction: column; gap: 24px; max-width: 1200px; margin: 0 auto; width: 100%; }

        /* General Card & Components */
        .card { background: var(--bg-card); border: 1px solid var(--sidebar-border); border-radius: var(--radius); padding: 24px; box-shadow: 0 2px 8px rgba(0,0,0,0.02); }
        .section-title { font-size: 18px; font-weight: 700; margin-bottom: 16px; }
        .input-group { position: relative; width: 100%; }
        .form-input { width: 100%; padding: 11px 16px; border: 1px solid var(--sidebar-border); border-radius: 8px; font-size: 14.5px; font-family: var(--font); color: var(--text-main); background: #fff; outline: none; transition: border-color .15s, box-shadow .15s; }
        .form-input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px var(--primary-light); }

        .btn { border: none; padding: 10px 18px; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background .15s, transform .1s; font-family: var(--font); display: inline-flex; align-items: center; justify-content: center; gap: 8px; }
        .btn:active { transform: scale(0.98); }
        .btn-primary { background: var(--primary); color: #fff; }
        .btn-primary:hover { background: var(--primary-dark); }
        .btn-success { background: var(--success); color: #fff; }
        .btn-danger { background: var(--danger); color: #fff; }
        .btn-secondary { background: var(--bg-page); color: var(--text-muted); border: 1px solid var(--sidebar-border); }
        .btn-secondary:hover { background: #E8EAED; color: var(--text-main); }

        /* Search Section */
        .search-results { display: none; position: absolute; width: 100%; z-index: 10; margin-top: 4px; max-height: 300px; overflow-y: auto; border: 1px solid var(--sidebar-border); border-radius: 8px; background: #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .search-item { padding: 12px 16px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--sidebar-border); cursor: pointer; transition: background .15s; }
        .search-item:last-child { border-bottom: none; }
        .search-item:hover { background: var(--bg-page); }
        .food-name { font-weight: 600; font-size: 14px; }
        .food-meta { color: var(--text-light); font-size: 12px; margin-top: 2px; }

        /* Food Details and Logging */
        #food-details { display: none; margin-top: 24px; }
        .details-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-top: 16px; }
        .stat-card { background: var(--bg-page); border: 1px solid var(--sidebar-border); border-radius: 8px; padding: 16px; text-align: center; }
        .stat-label { font-size: 12px; color: var(--text-muted); text-transform: uppercase; font-weight: 600; letter-spacing: 0.5px; }
        .stat-value { font-size: 24px; font-weight: 700; color: var(--primary); margin-top: 4px; }
        .serving-control { display: flex; align-items: center; flex-wrap: wrap; gap: 12px; margin-top: 20px; }

        /* Image Logging Section */
        #prediction-result { display: none; margin-top: 20px; text-align: center; border-top: 1px solid var(--sidebar-border); padding-top: 20px; }
        #prediction-text { font-size: 16px; font-weight: 600; color: var(--text-main); }
        .confirm-actions { display: flex; gap: 10px; justify-content: center; margin-top: 16px; }

        /* Popup / Modal CSS */
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

        @media(max-width:768px){
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .sidebar-overlay.show { display: block; }
            .main-content { margin-left: 0; }
            .hamburger { display: flex; }
            .page-body { padding: 16px; }
            .serving-control { flex-direction: column; align-items: stretch; }
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
            <a href="/dashboard" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/></svg>
                Dashboard
            </a>
            <a href="/log-meal" class="nav-link active">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v8M8 12h8"/></svg>
                Log Meal
            </a>
            <a href="/my-recipes" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/><rect x="9" y="3" width="6" height="4" rx="1"/><path d="M9 12h6M9 16h4"/></svg>
                My Recipes
            </a>
            <a href="/community" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>
                Community
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
            <span class="topbar-title">Add Today's Meal (<%= currentMeal %>)</span>
        </header>

        <div class="page-body">

            <div class="card">
                <p class="section-title">Search & Log Food</p>

                <form action="/save-daily-log" method="POST" id="logFoodForm">
                    <input type="hidden" name="foodId" id="hidden-food-id">
                    <input type="hidden" name="mealType" value="<%= currentMeal %>" id="hidden-meal-type">

                    <div class="input-group">
                        <input type="text" id="food-search" class="form-input" placeholder="Search for food (e.g., Apple, Chicken Breast)..." oninput="showSearchResults()" onkeydown="return event.key != 'Enter';" autocomplete="off"/>

                        <div id="search-results" class="search-results"></div>
                    </div>

                    <div id="food-details">
                        <div class="details-grid">
                            <div class="stat-card"><p class="stat-label">Calories</p><p class="stat-value" id="val-cal">0 kcal</p></div>
                            <div class="stat-card"><p class="stat-label">Protein</p><p class="stat-value" id="val-prot">0 g</p></div>
                            <div class="stat-card"><p class="stat-label">Carbs</p><p class="stat-value" id="val-carbs">0 g</p></div>
                            <div class="stat-card"><p class="stat-label">Fats</p><p class="stat-value" id="val-fats">0 g</p></div>
                        </div>

                        <div class="serving-control">
                            <label for="serving-size" class="form-label" style="font-size: 14px; font-weight: 600; color: var(--text-muted);">Serving Size (g/ml)</label>
                            <input type="number" name="servingSize" id="serving-size" class="form-input" value="100" style="width: 120px;" oninput="updateNutrition()" required>

                            <div style="flex: 1;"></div> <button type="button" class="btn btn-secondary" onclick="showQualityScore()">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14M22 4L12 14.01l-3-3"/></svg>
                            Check Quality
                        </button>
                            <button type="submit" class="btn btn-primary" id="btn-add-log">Add to Log</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="card">
                <p class="section-title">Upload Food Image to Log (AI Assistance)</p>
                <div style="display: flex; flex-direction: column; align-items: center; gap: 16px;">
                    <button class="btn btn-secondary" style="width: 100%; border-style: dashed;" onclick="document.getElementById('image-upload').click()">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 8px; vertical-align: middle;"><path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M17 8l-5-5-5 5M12 3v12"/></svg>
                        Choose Food Image
                    </button>
                    <input type="file" id="image-upload" style="display: none;" accept="image/*" onchange="predictImage(event)">

                    <img id="uploaded-image-preview" src="#" alt="Preview" style="display: none; max-width: 100%; max-height: 200px; border-radius: 8px; border: 1px solid var(--sidebar-border); margin-top: 10px;"/>
                </div>

                <div id="prediction-result">
                    <p id="prediction-text">Thinking...</p>
                    <div class="confirm-actions">
                        <button id="btn-predict-yes" class="btn btn-success" style="display: none;" onclick="confirmPrediction(true)">Yes</button>
                        <button id="btn-predict-no" class="btn btn-danger" style="display: none;" onclick="confirmPrediction(false)">No</button>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div id="quality-modal" class="modal-overlay">
    <div class="modal-card">
        <p class="modal-title">Food Quality Score</p>

        <div id="score-circle" class="score-circle">
            <span id="score-value">0</span>
        </div>

        <p id="score-feedback" class="modal-desc">Loading nutritional data...</p>

        <button class="btn btn-secondary" style="width: 100%;" onclick="closeQualityScore()">Got it</button>
    </div>
</div>

<script>
    function toggleSidebar(){
        document.getElementById('sidebar').classList.toggle('open');
        document.getElementById('overlay').classList.toggle('show');
    }

    // --- SEARCH & REALTIME UPDATE LOGIC ---
    let currentFood = null;

    async function showSearchResults() {
        const query = document.getElementById('food-search').value.trim();
        const resultsDropdown = document.getElementById('search-results');

        if (query.length > 2) {
            try {
                console.log("Frontend: Searching for ->", query);

                // NO Template Literals used here to avoid JSP EL crash
                const response = await fetch('/searchFood?q=' + encodeURIComponent(query));

                console.log("Backend Response Status ->", response.status);

                if (response.ok) {
                    const foods = await response.json();
                    console.log("Data Received from DB ->", foods);

                    resultsDropdown.innerHTML = '';

                    if(foods.length === 0) {
                        resultsDropdown.innerHTML = '<div class="search-item"><p class="food-meta">No food found in database.</p></div>';
                    } else {
                        foods.forEach(food => {
                            const itemDiv = document.createElement('div');
                            itemDiv.className = 'search-item';
                            itemDiv.onclick = () => selectFood(food);

                            const servingU = food.servingUnit || 'per 100g';
                            const fCat = food.category || 'Food';

                            itemDiv.innerHTML =
                                '<div>' +
                                '<p class="food-name">' + food.foodName + ' (' + servingU + ')</p>' +
                                '<p class="food-meta">' + food.calories + ' kcal per 100g | ' + fCat + '</p>' +
                                '</div>' +
                                '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>';

                            resultsDropdown.appendChild(itemDiv);
                        });
                    }
                    resultsDropdown.style.display = 'block';
                } else {
                    console.error("Backend Error: Status code", response.status);
                    resultsDropdown.innerHTML = '<div class="search-item"><p class="food-meta" style="color: red;">Error fetching data. Check Console.</p></div>';
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

        // Populate UI
        document.getElementById('food-search').value = foodObj.foodName;
        document.getElementById('search-results').style.display = 'none';
        document.getElementById('food-details').style.display = 'block';

        // Populate hidden fields for Database Save
        document.getElementById('hidden-food-id').value = foodObj.id;

        // Auto-fill serving size
        document.getElementById('serving-size').value = foodObj.defaultServingWeight || 100;

        updateNutrition();
    }

    function updateNutrition() {
        if (!currentFood) return;

        const servingSize = parseFloat(document.getElementById('serving-size').value) || 100;
        const ratio = servingSize / 100;

        // Using standard concatenation to avoid JSP EL error
        document.getElementById('val-cal').innerText = Math.round(currentFood.calories * ratio) + " kcal";
        document.getElementById('val-prot').innerText = (currentFood.protein * ratio).toFixed(1) + " g";
        document.getElementById('val-carbs').innerText = (currentFood.carbs * ratio).toFixed(1) + " g";
        document.getElementById('val-fats').innerText = (currentFood.fats * ratio).toFixed(1) + " g";
    }

    // --- FOOD QUALITY SCORE LOGIC ---
    function showQualityScore() {
        if (!currentFood) return;

        let score = (currentFood.healthRating || 5) * 10;

        const circle = document.getElementById('score-circle');
        const feedback = document.getElementById('score-feedback');

        circle.className = 'score-circle';

        const recFor = currentFood.recommendedFor || 'general health';
        const glyInd = currentFood.glycemicIndex || 'Low';

        if (score >= 80) {
            circle.classList.add('score-high');
            feedback.innerHTML = '<strong>Excellent choice!</strong><br/> Ideal for ' + recFor + '. It is a ' + glyInd + ' Glycemic Index food.';
        } else if (score >= 50) {
            circle.classList.add('score-mid');
            feedback.innerHTML = '<strong>Decent option.</strong><br/> Good in moderation. It is a ' + glyInd + ' Glycemic Index food.';
        } else {
            circle.classList.add('score-low');
            feedback.innerHTML = '<strong>Low Quality.</strong><br/> Consider healthier alternatives. This is high in empty calories or fats.';
        }

        document.getElementById('score-value').innerText = score;
        document.getElementById('quality-modal').classList.add('show');
    }

    function closeQualityScore() {
        document.getElementById('quality-modal').classList.remove('show');
    }

    // Close search dropdown if clicked outside
    document.addEventListener('click', function(event) {
        const searchBox = document.querySelector('.input-group');
        if (!searchBox.contains(event.target)) {
            document.getElementById('search-results').style.display = 'none';
        }
    });

    // --- IMAGE LOGGING (Future AI Scope Mockup) ---
    function predictImage(event) {
        const input = event.target;
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const previewElement = document.getElementById('uploaded-image-preview');
                previewElement.src = e.target.result;
                previewElement.style.display = 'block';
            }
            reader.readAsDataURL(input.files[0]);

            const predictionResult = document.getElementById('prediction-result');
            const predictionText = document.getElementById('prediction-text');
            const btnYes = document.getElementById('btn-predict-yes');
            const btnNo = document.getElementById('btn-predict-no');

            predictionResult.style.display = 'block';
            predictionText.innerText = 'Analyzing Image with Sahaayata AI...';
            btnYes.style.display = 'none';
            btnNo.style.display = 'none';

            setTimeout(() => {
                const predictedFood = "Chicken Breast";
                predictionText.innerHTML = 'Model predicts: <strong>' + predictedFood + '</strong>. Is this correct?';
                btnYes.style.display = 'inline-block';
                btnNo.style.display = 'inline-block';
            }, 2500);
        }
    }

    function confirmPrediction(isCorrect) {
        const predictionText = document.getElementById('prediction-text');
        const btnYes = document.getElementById('btn-predict-yes');
        const btnNo = document.getElementById('btn-predict-no');

        if (isCorrect) {
            predictionText.innerHTML = '<span style="color: var(--success);">Great! Finding nutritional data...</span>';
            document.getElementById('food-search').value = "Chicken Breast";
            showSearchResults();
        } else {
            predictionText.innerHTML = '<span style="color: var(--danger);">Sorry about that. Please search for the food manually above.</span>';
        }
        btnYes.style.display = 'none';
        btnNo.style.display = 'none';
    }

</script>
</body>
</html>