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

        // 3. Send to Dashboard (JSP)
        model.addAttribute("consumedCalories", totalConsumed);
        model.addAttribute("consumedProtein", totalProtein);
        model.addAttribute("consumedCarbs", totalCarbs);
        model.addAttribute("consumedFats", totalFats);
        // Model ke andar attribute share karein taaki dashboard.jsp isko read kar sake
        model.addAttribute("consumedCalories", totalConsumed);

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

    // ✅ UPDATED PROFILE LOGIC (Ab Weight, Height, Age bhi save karega)
    @PostMapping("/update-profile")
    public String updateProfile(@RequestParam("username") String username,
                                @RequestParam("gender") String gender,
                                @RequestParam(value = "phoneNumber", required = false) String phoneNumber,
                                @RequestParam("weight") double weight,   // ✅ Added
                                @RequestParam("height") double height,   // ✅ Added
                                @RequestParam("age") int age,            // ✅ Added
                                HttpSession session) {

        // Session check
        UserCredential currentUser = (UserCredential) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        // Database se user nikalo
        UserCredential dbUser = userRepository.findById(currentUser.getId()).orElse(null);

        if (dbUser != null) {
            // Basic Info Update
            dbUser.setUsername(username);
            dbUser.setGender(gender);

            // Phone Number Update (Optional check)
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                dbUser.setPhoneNumber(phoneNumber);
            }

            // ✅ Health Stats Update
            dbUser.setWeight(weight);
            dbUser.setHeight(height);
            dbUser.setAge(age);

            // Database mein save karo
            userRepository.save(dbUser);

            // Session mein bhi update karo taaki Dashboard par nayi calories dikhein
            session.setAttribute("loggedInUser", dbUser);
        }

        // Wapas settings page par bhejo
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
    public String updatePassword(@RequestParam("new-password") String newPassword, @RequestParam("confirm-password") String confirmPassword, HttpSession session, Model model) {

        UserCredential sessionUser = (UserCredential) session.getAttribute("loggedInUser");
        if (sessionUser == null) {
            return "redirect:/login";
        }

        // 1. Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match!");
            return "change-password";
        }

        // 2. Fetch User from DB
        UserCredential dbUser = userRepository.findById(sessionUser.getId()).orElse(null);

        if (dbUser != null) {
            // 3. Update Password
            dbUser.setPassword(newPassword); // Note: Production me encryption (BCrypt) use karein
            userRepository.save(dbUser);

            // 4. Update Session
            session.setAttribute("loggedInUser", dbUser);
        }

        // Success ke baad settings page par bhej do
        return "redirect:/settings";
    }

}