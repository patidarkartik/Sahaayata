<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sahaayata.minorproject.model.userCredential" %>

<%-- 🛑 SECURITY & NO-CACHE LOGIC (Added) --%>
<%
    // 1. Browser ko bolo: Cache mat karo (Logout security ke liye)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // 2. Check: User Login hai ya nahi?
    userCredential user = (userCredential) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personalize Plan - Sahaayata</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #F3F4F6; font-family: 'Segoe UI', sans-serif; }
        .onboarding-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        .header-bg {
            background-color: #4F46E5;
            color: white;
            padding: 30px;
            text-align: center;
        }
        .form-label { font-weight: 600; color: #374151; }
        .input-group-text { background-color: white; border-right: none; }
        .form-control { border-left: none; }
        .form-control:focus { box-shadow: none; border-color: #ced4da; }
        .input-group:focus-within {
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2);
            border-radius: 6px;
        }
        .input-group:focus-within .form-control,
        .input-group:focus-within .input-group-text { border-color: #4F46E5; }

        /* Custom Radio Buttons for Gender */
        .gender-selector input { display: none; }
        .gender-selector label {
            display: block;
            padding: 15px;
            border: 2px solid #E5E7EB;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
        }
        .gender-selector input:checked + label {
            border-color: #4F46E5;
            background-color: #EEF2FF;
            color: #4F46E5;
            font-weight: bold;
        }

        .btn-continue {
            background-color: #4F46E5; color: white; padding: 12px; font-weight: 600;
            border-radius: 8px; border: none; width: 100%; margin-top: 20px;
        }
        .btn-continue:hover { background-color: #4338CA; color: white; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card onboarding-card">

                <div class="header-bg">
                    <h3><i class="fa-solid fa-clipboard-user me-2"></i>Let's know you better</h3>
                    <p class="mb-0 opacity-75">We need these details to calculate your perfect diet plan.</p>
                </div>

                <div class="card-body p-4 p-md-5 bg-white">
                    <form action="/save-onboarding" method="post">

                        <div class="mb-4">
                            <label class="form-label mb-3">Gender</label>
                            <div class="row g-3">
                                <div class="col-6 gender-selector">
                                    <input type="radio" name="gender" id="male" value="Male" required checked>
                                    <label for="male"><i class="fa-solid fa-person fa-2x mb-2"></i><br>Male</label>
                                </div>
                                <div class="col-6 gender-selector">
                                    <input type="radio" name="gender" id="female" value="Female">
                                    <label for="female"><i class="fa-solid fa-person-dress fa-2x mb-2"></i><br>Female</label>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label class="form-label">Age (Years)</label>
                                <input type="number" name="age" class="form-control p-2" placeholder="e.g. 25" required>
                            </div>
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label class="form-label">Weight (kg)</label>
                                <input type="number" step="0.1" name="weight" class="form-control p-2" placeholder="e.g. 70" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Height (cm)</label>
                                <input type="number" step="0.1" name="height" class="form-control p-2" placeholder="e.g. 175" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">How active are you?</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-person-running text-muted"></i></span>
                                <select name="activityLevel" class="form-select p-2" required>
                                    <option value="" selected disabled>Select Activity Level</option>
                                    <option value="1.2">Sedentary (Office Job, No Exercise)</option>
                                    <option value="1.375">Lightly Active (Exercise 1-3 days/week)</option>
                                    <option value="1.55">Moderately Active (Exercise 3-5 days/week)</option>
                                    <option value="1.725">Very Active (Heavy Exercise 6-7 days/week)</option>
                                    <option value="1.9">Extra Active (Physical Job + Training)</option>
                                </select>
                            </div>
                        </div>

                        <button type="submit" class="btn-continue">
                            Calculate My Plan <i class="fa-solid fa-arrow-right ms-2"></i>
                        </button>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>