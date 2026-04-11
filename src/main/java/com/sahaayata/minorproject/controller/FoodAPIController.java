package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.model.Food;
import com.sahaayata.minorproject.repository.FoodRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@RestController
public class FoodAPIController {

    @Autowired
    private FoodRepository foodRepository;

    // Normal Text Search (e.g., typing "Apple")
    @GetMapping("/searchFood")
    public List<Food> searchFood(@RequestParam("q") String q) {
        return foodRepository.findByFoodNameContainingIgnoreCase(q);
    }

    // NAYI SMART API: Dashboard se redirect hone par suggestions fetch karne ke liye
    @GetMapping("/getSuggestions")
    public List<Food> getSuggestions(@RequestParam("meal") String meal, @RequestParam("filter") String filter) {

        List<String> validCategories;

        // Backend AI Logic: Meal ke hisaab se category decide karna
        if (meal.equalsIgnoreCase("Breakfast") || meal.equalsIgnoreCase("Snacks")) {
            // Subah ya shaam ke snacks me light cheezein
            validCategories = Arrays.asList("Snack", "Fruit", "Dairy", "Protein");
        } else if (meal.equalsIgnoreCase("Lunch") || meal.equalsIgnoreCase("Dinner")) {
            // Lunch/Dinner me heavy khana
            validCategories = Arrays.asList("Cooked Dish", "Grains", "Protein", "Vegetable");
        } else {
            validCategories = Arrays.asList("Snack", "Fruit", "Dairy", "Protein", "Cooked Dish", "Grains", "Vegetable");
        }

        // Database ko query bhejna
        return foodRepository.findSuggestions(filter, validCategories);
    }
}