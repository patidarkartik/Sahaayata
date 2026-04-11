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

    @GetMapping("/recipes")
    public String showRecipesPage(HttpSession session, Model model) {
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        List<Food> allFoods = foodRepository.findAll();
        model.addAttribute("foodList", allFoods);
        return "recipes";
    }

    @GetMapping("/my-recipes")
    public String showMyRecipes(HttpSession session, Model model) {
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        List<Recipe> myRecipes = recipeRepository.findByUser(user);
        model.addAttribute("recipeList", myRecipes);
        return "my-recipes";
    }

    @GetMapping("/create-recipe")
    public String showCreateRecipePage(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "create-recipe";
    }

    @PostMapping("/save-recipe")
    public String saveRecipe(@ModelAttribute Recipe recipe, HttpSession session) {
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        recipe.setUser(user);
        if (recipe.getImageUrl() == null || recipe.getImageUrl().isEmpty()) {
            recipe.setImageUrl("https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=500&q=80");
        }
        recipeRepository.save(recipe);
        return "redirect:/my-recipes";
    }

    @GetMapping("/community")
    public String showCommunityPage(HttpSession session, Model model) {
        userCredential user = (userCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        List<Recipe> allRecipes = recipeRepository.findAll();
        model.addAttribute("communityRecipes", allRecipes);
        return "community";
    }

    @GetMapping("/log-meal")
    public String showLogMealPage(HttpSession session, Model model) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "log-meal";
    }

    @PostMapping("/save-daily-log")
    public String saveDailyLog(HttpServletRequest request, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "redirect:/dashboard";
    }

    // --- YE ROUTE FIX KARTA HAI 404 ERROR KO ---
    @GetMapping("/generate-plan")
    public String showGeneratePlanPage(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        return "generate-plan";
    }
}