package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.dto.LoginRequest;
import com.sahaayata.minorproject.model.UserCredential;
import com.sahaayata.minorproject.repository.DailyLogRepository;
import com.sahaayata.minorproject.repository.UserRepository;
import com.sahaayata.minorproject.service.UserService;
import com.sahaayata.minorproject.util.UserServiceUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@Controller
public class AuthController {

    @Autowired
    private UserService userService; // Registration ke liye

    @Autowired
    private UserRepository userRepository; // Login/Onboarding/Settings updates ke liye

    @Autowired
    private DailyLogRepository  dailyLogRepository;

    // 1. PAGE VIEW METHODS (GET Requests)

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register"; // register.jsp
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // login.jsp
    }

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        // Agar user login hai lekin Onboarding bacha hai, wahan bhejo
        if (!user.isOnboardingCompleted()) {
            return "redirect:/onboarding";
        }

        java.time.LocalDate today = java.time.LocalDate.now();

        // 1. Fetch from Database
        Double consumedCals = dailyLogRepository.getTotalCaloriesForToday(user, today);
        Double consumedProt = dailyLogRepository.getTotalProteinForToday(user, today);
        Double consumedCarbs = dailyLogRepository.getTotalCarbsForToday(user, today);
        Double consumedFats = dailyLogRepository.getTotalFatsForToday(user, today);

        // 2. Handle Nulls (agar 0 meal log hui hai)
        int totalConsumed = (consumedCals != null) ? consumedCals.intValue() : 0;
        int totalProtein = (consumedProt != null) ? consumedProt.intValue() : 0;
        int totalCarbs = (consumedCarbs != null) ? consumedCarbs.intValue() : 0;
        int totalFats = (consumedFats != null) ? consumedFats.intValue() : 0;

        // Fetch Meal-wise Calories
        Double bCals = dailyLogRepository.getTotalCaloriesForMealToday(user, today, "Breakfast");
        Double lCals = dailyLogRepository.getTotalCaloriesForMealToday(user, today, "Lunch");
        Double dCals = dailyLogRepository.getTotalCaloriesForMealToday(user, today, "Dinner");
        Double sCals = dailyLogRepository.getTotalCaloriesForMealToday(user, today, "Snacks");

        int breakfastCals = (bCals != null) ? bCals.intValue() : 0;
        int lunchCals = (lCals != null) ? lCals.intValue() : 0;
        int dinnerCals = (dCals != null) ? dCals.intValue() : 0;
        int snacksCals = (sCals != null) ? sCals.intValue() : 0;

        // 3. Send to Dashboard (JSP)
        model.addAttribute("consumedCalories", totalConsumed);
        model.addAttribute("consumedProtein", totalProtein);
        model.addAttribute("consumedCarbs", totalCarbs);
        model.addAttribute("consumedFats", totalFats);
        
        model.addAttribute("breakfastCals", breakfastCals);
        model.addAttribute("lunchCals", lunchCals);
        model.addAttribute("dinnerCals", dinnerCals);
        model.addAttribute("snacksCals", snacksCals);

        return "dashboard";
    }

    @GetMapping("/onboarding")
    public String showOnboardingPage(HttpSession session) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // Agar already complete hai, to wapas dashboard bhejo
        if (user.isOnboardingCompleted()) {
            return "redirect:/dashboard";
        }

        return "onboarding"; // onboarding.jsp
    }


    // 2. SETTINGS & PROFILE (GET & POST)

    // Settings Page Dikhana
    @GetMapping("/settings")
    public String showSettingsPage(HttpSession session) {
        // Security Check
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        // Database se fresh data fetch karo (Recommended)
        UserCredential dbUser = userRepository.findById(user.getId()).orElse(null);

        if (dbUser != null) {
            session.setAttribute("loggedInUser", dbUser); // Session Refresh
        } else {
            session.invalidate(); // Agar user DB me nahi hai to logout
            return "redirect:/login";
        }

        return "settings"; // settings.jsp load karega
    }

    // ✅ Profile Info Update (Username)
    @PostMapping("/update-profile")
    public String updateProfile(@RequestParam("username") String username,
                                HttpSession session, RedirectAttributes redirectAttributes) {
        UserCredential currentUser = (UserCredential) session.getAttribute("loggedInUser");
        if (currentUser == null) return "redirect:/login";

        UserCredential dbUser = userRepository.findById(currentUser.getId()).orElse(null);
        if (dbUser != null) {
            UserCredential existingUser = userRepository.findByUsername(username);
            if (existingUser != null && !existingUser.getId().equals(dbUser.getId())) {
                redirectAttributes.addFlashAttribute("errorProfile", "Username is already taken!");
                return "redirect:/settings";
            }

            dbUser.setUsername(username);
            userRepository.save(dbUser);
            session.setAttribute("loggedInUser", dbUser);
            redirectAttributes.addFlashAttribute("successProfile", "Profile updated successfully!");
        }
        return "redirect:/settings";
    }

    // ✅ Body Stats Update
    @PostMapping("/update-stats")
    public String updateStats(@RequestParam("age") int age,
                              @RequestParam("gender") String gender,
                              @RequestParam("height") double height,
                              @RequestParam("weight") double weight,
                              @RequestParam("activityLevel") String activityLevel,
                              HttpSession session, RedirectAttributes redirectAttributes) {
        UserCredential currentUser = (UserCredential) session.getAttribute("loggedInUser");
        if (currentUser == null) return "redirect:/login";

        UserCredential dbUser = userRepository.findById(currentUser.getId()).orElse(null);
        if (dbUser != null) {
            dbUser.setAge(age);
            dbUser.setGender(gender);
            dbUser.setHeight(height);
            dbUser.setWeight(weight);
            dbUser.setActivityLevel(activityLevel);
            userRepository.save(dbUser);
            session.setAttribute("loggedInUser", dbUser);
            redirectAttributes.addFlashAttribute("successStats", "Body stats updated successfully!");
        }
        return "redirect:/settings";
    }



    // 3. API METHODS (POST Requests - JSON)

    // --- REGISTER LOGIC ---
    @PostMapping("/register")
    @ResponseBody // JSON return karne ke liye
    public ResponseEntity<?> registerUser(@RequestBody UserCredential user) {
        try {
            // Service call karke user save karein
            String hashedPass = UserServiceUtil.hashPassword(user.getPassword());
            user.setPassword(hashedPass);
            UserCredential registeredUser = userService.registerUser(user);
            return new ResponseEntity<>(registeredUser, HttpStatus.CREATED);
        }
        catch (IllegalArgumentException e) {
            return new ResponseEntity<>(
                    Collections.singletonMap("message", e.getMessage()),
                    HttpStatus.BAD_REQUEST
            );
        }
        catch (Exception e) {
            return new ResponseEntity<>(
                    Collections.singletonMap("message", "Registration failed due to server error."),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    // --- LOGIN LOGIC ---
    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<?> loginUser(@RequestBody LoginRequest loginRequest, HttpSession session) {

        UserCredential user = userRepository.findByEmail(loginRequest.getEmail());

        // Password Check
        if (user != null && UserServiceUtil.checkPassword(loginRequest.getPassword(), user.getPassword())){

            session.setAttribute("loggedInUser", user);

            Map<String, String> response = new HashMap<>();

            if (user.isOnboardingCompleted()) {
                response.put("redirectUrl", "/dashboard");
            } else {
                response.put("redirectUrl", "/onboarding");
            }

            return ResponseEntity.ok(response);

        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Collections.singletonMap("message", "Invalid Email or Password"));
        }
    }

    // --- ONBOARDING SAVE LOGIC (Form Submit) ---
    @PostMapping("/save-onboarding")
    public String saveOnboardingData(@ModelAttribute UserCredential formData, HttpSession session) {

        UserCredential sessionUser = (UserCredential) session.getAttribute("loggedInUser");
        if (sessionUser == null) return "redirect:/login";

        UserCredential dbUser = userRepository.findById(sessionUser.getId()).orElse(null);

        if (dbUser != null) {
            dbUser.setAge(formData.getAge());
            dbUser.setGender(formData.getGender());
            dbUser.setHeight(formData.getHeight());
            dbUser.setWeight(formData.getWeight());
            dbUser.setActivityLevel(formData.getActivityLevel());

            dbUser.setOnboardingCompleted(true);

            userRepository.save(dbUser);
            session.setAttribute("loggedInUser", dbUser);
        }

        return "redirect:/dashboard";
    }

    // --- LOGOUT LOGIC ---
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    // ==========================================
    // 6. CHANGE PASSWORD LOGIC
    // ==========================================

    // 1. Show Change Password Page
    @GetMapping("/change-password")
    public String showChangePasswordPage(HttpSession session) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        return "change-password"; // change-password.jsp load karega
    }

    // 2. Process Password Update
    @PostMapping("/change-password")
    public String updatePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        UserCredential sessionUser = (UserCredential) session.getAttribute("loggedInUser");
        if (sessionUser == null) {
            return "redirect:/login";
        }

        // 1. Fetch User from DB
        UserCredential dbUser = userRepository.findById(sessionUser.getId()).orElse(null);

        if (dbUser == null) {
            session.invalidate();
            return "redirect:/login";
        }

        // 2. Verify Current Password using BCrypt
        if (!UserServiceUtil.checkPassword(currentPassword, dbUser.getPassword())) {
            redirectAttributes.addFlashAttribute("error", "Current password is incorrect!");
            return "redirect:/change-password";
        }

        // 3. Check minimum password length
        if (newPassword.length() < 8) {
            redirectAttributes.addFlashAttribute("error", "New password must be at least 8 characters long!");
            return "redirect:/change-password";
        }

        // 4. Check if new passwords match
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "New passwords do not match!");
            return "redirect:/change-password";
        }

        // 5. Check that new password is different from current
        if (UserServiceUtil.checkPassword(newPassword, dbUser.getPassword())) {
            redirectAttributes.addFlashAttribute("error", "New password must be different from current password!");
            return "redirect:/change-password";
        }

        // 6. Hash and save new password using BCrypt
        String hashedNewPassword = UserServiceUtil.hashPassword(newPassword);
        dbUser.setPassword(hashedNewPassword);
        userRepository.save(dbUser);

        // 7. Update Session
        session.setAttribute("loggedInUser", dbUser);

        // 8. Success message
        redirectAttributes.addFlashAttribute("success", "Password changed successfully!");
        return "redirect:/change-password";
    }

    // ==========================================
    // 7. FORGOT PASSWORD LOGIC (Simple Implementation)
    // ==========================================
    @PostMapping("/forgot-password")
    @ResponseBody
    public ResponseEntity<?> forgotPassword(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        String newPassword = payload.get("newPassword");

        if (email == null || newPassword == null || email.trim().isEmpty() || newPassword.trim().isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Collections.singletonMap("message", "Email and New Password are required."));
        }

        UserCredential user = userRepository.findByEmail(email.trim());
        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Collections.singletonMap("message", "No account found with this email."));
        }

        if (newPassword.length() < 8) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Collections.singletonMap("message", "New password must be at least 8 characters long."));
        }

        user.setPassword(UserServiceUtil.hashPassword(newPassword));
        userRepository.save(user);

        return ResponseEntity.ok(Collections.singletonMap("message", "Password reset successfully. You can now log in."));
    }

}