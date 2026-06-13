package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.model.DailyLog;
import com.sahaayata.minorproject.model.Food;
import com.sahaayata.minorproject.model.Recipe;
import com.sahaayata.minorproject.model.UserCredential;
import com.sahaayata.minorproject.repository.DailyLogRepository;
import com.sahaayata.minorproject.repository.FoodRepository;
import com.sahaayata.minorproject.repository.RecipeRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class FoodController {

    // ==========================================
    // SECTION 1: REPOSITORIES SETUP
    // ==========================================

    @Autowired
    private FoodRepository foodRepository;

    @Autowired
    private RecipeRepository recipeRepository;

    @Autowired
    private DailyLogRepository dailyLogRepository;


    // ==========================================
    // SECTION 2: RECIPE CREATION & MANAGEMENT
    // ==========================================

    @GetMapping("/create-recipe")
    public String showCreateRecipePage(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "create-recipe";
    }

    @PostMapping("/save-recipe")
    public String saveRecipe(@ModelAttribute Recipe recipe, HttpSession session) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        recipe.setUser(user);

        if (recipe.getImageUrl() == null || recipe.getImageUrl().isEmpty()) {
            recipe.setImageUrl("https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=500&q=80");
        }

        // AI Macros Safety Check (Taaki database me null na jaye)
        if (recipe.getServings() == null) recipe.setServings(1.0);
        if (recipe.getCalories() == null) recipe.setCalories(0.0);
        if (recipe.getProtein() == null) recipe.setProtein(0.0);
        if (recipe.getCarbs() == null) recipe.setCarbs(0.0);
        if (recipe.getFats() == null) recipe.setFats(0.0);

        recipeRepository.save(recipe);
        return "redirect:/my-recipes";
    }

    @GetMapping("/my-recipes")
    public String showMyRecipes(HttpSession session, Model model) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        List<Recipe> myRecipes = recipeRepository.findByUser(user);
        model.addAttribute("recipes", myRecipes);

        return "my-recipes";
    }

    @GetMapping("/recipe/{id}")
    public String viewRecipeDetail(@PathVariable Long id, Model model, HttpSession session) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Optional<Recipe> recipeOpt = recipeRepository.findById(id);
        if (recipeOpt.isPresent()) {
            model.addAttribute("recipe", recipeOpt.get());
            return "recipe-detail";
        }
        return "redirect:/my-recipes";
    }

    @GetMapping("/delete-recipe")
    public String deleteRecipe(@RequestParam Long id, HttpSession session) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Optional<Recipe> recipeOpt = recipeRepository.findById(id);
        // Delete sirf tabhi hoga jab wo recipe current user ki ho
        if (recipeOpt.isPresent() && recipeOpt.get().getUser().getId().equals(user.getId())) {
            recipeRepository.deleteById(id);
        }
        return "redirect:/my-recipes";
    }


    // ==========================================
    // SECTION 3: FOOD BROWSE
    // ==========================================

    @GetMapping("/recipes")
    public String showRecipesPage(HttpSession session, Model model) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        List<Food> allFoods = foodRepository.findAll();
        model.addAttribute("foodList", allFoods);
        return "recipes";
    }


    // ==========================================
    // SECTION 4: DAILY LOGGING & MEAL PLANS
    // ==========================================

    @GetMapping("/generate-plan")
    public String showGeneratePlanPage(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "generate-plan";
    }

    @GetMapping("/log-meal")
    public String showLogMealPage(HttpSession session, Model model) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "log-meal";
    }

    @PostMapping("/save-daily-log")
    public String saveDailyLog(
            @RequestParam("foodId") Long foodId,
            @RequestParam("servingQty") Double quantity,
            @RequestParam("mealType") String mealType,
            HttpSession session) {

        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Food food = foodRepository.findById(foodId).orElse(null);
        if (food != null) {
            DailyLog log = new DailyLog();
            log.setUser(user);
            log.setFood(food);
            log.setQuantity(quantity);
            log.setMealType(mealType);
            log.setLogDate(java.time.LocalDate.now());

            dailyLogRepository.save(log);
        }
        return "redirect:/dashboard";
    }
}