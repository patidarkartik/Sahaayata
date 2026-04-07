package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.model.Food;
import com.sahaayata.minorproject.model.Recipe;
import com.sahaayata.minorproject.model.userCredential;
import com.sahaayata.minorproject.repository.FoodRepository;
import com.sahaayata.minorproject.repository.RecipeRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class FoodController {

    @Autowired
    private FoodRepository foodRepository;

    @Autowired
    private RecipeRepository recipeRepository;

    // ==========================================
    // 1. FOOD DATABASE (Recipes Page)
    // ==========================================
    @GetMapping("/recipes")
    public String showRecipesPage(HttpSession session, Model model) {
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // Database se saare foods fetch karein
        List<Food> allFoods = foodRepository.findAll();
        model.addAttribute("foodList", allFoods);

        return "recipes"; // recipes.jsp load karega
    }

    // ==========================================
    // 2. MY RECIPES SECTION (User Personal Recipes)
    // ==========================================

    // List My Recipes
    @GetMapping("/my-recipes")
    public String showMyRecipes(HttpSession session, Model model) {
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // Sirf is user ki recipes fetch karein
        List<Recipe> myRecipes = recipeRepository.findByUser(user);
        model.addAttribute("recipeList", myRecipes);

        return "my-recipes"; // my-recipes.jsp
    }

    // Show Create Recipe Page
    @GetMapping("/create-recipe")
    public String showCreateRecipePage(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "create-recipe"; // create-recipe.jsp
    }

    // Save New Recipe
    @PostMapping("/save-recipe")
    public String saveRecipe(@ModelAttribute Recipe recipe, HttpSession session) {
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        recipe.setUser(user);

        // Default Image Logic
        if (recipe.getImageUrl() == null || recipe.getImageUrl().isEmpty()) {
            recipe.setImageUrl("https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=500&q=80");
        }

        recipeRepository.save(recipe);
        return "redirect:/my-recipes";
    }

    // ==========================================
    // 3. COMMUNITY PAGE
    // ==========================================

    @GetMapping("/community")
    public String showCommunityPage(HttpSession session, Model model) {
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // Fetch ALL recipes from database for the community feed
        List<Recipe> allRecipes = recipeRepository.findAll();

        // Add to model
        model.addAttribute("communityRecipes", allRecipes);

        return "community"; // community.jsp
    }

    // ==========================================
    // 4. LOG MEAL PAGE
    // ==========================================

    @GetMapping("/log-meal")
    public String showLogMealPage(HttpSession session, Model model) {
        // Security Check
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        // Return the name of your JSP file (without .jsp extension)
        return "log-meal";
    }

    // ==========================================
    // 5. SAVE DAILY LOG (MOCK)
    // ==========================================
    @PostMapping("/save-daily-log")
    public String saveDailyLog(HttpServletRequest request, HttpSession session) {
        // Security Check
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        // Form se data nikalna
        String foodId = request.getParameter("foodId");
        String servingSize = request.getParameter("servingSize");
        String mealType = request.getParameter("mealType");

        // TODO: Yahan hum database (DAILY_LOG table) mein data save karne ka code likhenge
        System.out.println("Food ID: " + foodId + " | Serving: " + servingSize + " | Meal: " + mealType);

        // Save hone ke baad wapas dashboard par bhej do
        return "redirect:/dashboard";
    }
}