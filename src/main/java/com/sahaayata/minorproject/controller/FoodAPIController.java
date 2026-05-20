package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.model.Food;
import com.sahaayata.minorproject.model.SmartMeal;
import com.sahaayata.minorproject.repository.FoodRepository;
import com.sahaayata.minorproject.repository.SmartMealRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
public class FoodAPIController {

    @Autowired
    private FoodRepository foodRepository;

    @Autowired
    private SmartMealRepository smartMealRepository;

    @GetMapping("/searchFood")
    public List<Food> searchFood(@RequestParam("q") String q) {
        return foodRepository.findByFoodNameContainingIgnoreCase(q);
    }

    // ========================================================
    // PART 1: SUGGESTION LIST (UNTOUCHED AS REQUESTED)
    // ========================================================
    @GetMapping("/getSuggestions")
    public List<Food> getSuggestions(@RequestParam("meal") String meal, @RequestParam("filter") String filter) {

        List<String> mappedGoals = new ArrayList<>();
        if (filter.equalsIgnoreCase("Weight Loss") || filter.equalsIgnoreCase("Low Carb") || filter.equalsIgnoreCase("Low Fat")) {
            mappedGoals.addAll(Arrays.asList("Weight Loss", "General Health", "Both"));
        } else if (filter.equalsIgnoreCase("Muscle Gain") || filter.equalsIgnoreCase("High Protein")) {
            mappedGoals.addAll(Arrays.asList("Muscle Gain", "General Health", "Both"));
        } else {
            mappedGoals.addAll(Arrays.asList("General Health", "Both", "Weight Loss", "Muscle Gain"));
        }

        List<String> validCategories;
        if (meal.equalsIgnoreCase("Breakfast") || meal.equalsIgnoreCase("Snacks")) {
            validCategories = Arrays.asList("Fruit", "Snack", "Dairy", "Protein", "Grains");
        } else {
            validCategories = Arrays.asList("Vegetable", "Cooked Dish", "Grains", "Protein");
        }

        return foodRepository.findSuggestions(validCategories, mappedGoals);
    }

    // ========================================================
    // PART 2: GENERATE FULL MEAL PLAN
    // ========================================================
    @GetMapping("/getMultiplePlans")
    public List<Map<String, Object>> getMultiplePlans(@RequestParam("filter") String filter, @RequestParam("target") Double targetCalories) {

        if (targetCalories < 500) targetCalories = 1500.0;
        List<Map<String, Object>> multipleOptions = new ArrayList<>();

        for (int i = 1; i <= 3; i++) {
            Map<String, Object> plan = new HashMap<>();
            plan.put("optionName", "Option " + i);

            double bfTarget = targetCalories * 0.25;
            double lunchTarget = targetCalories * 0.35;
            double dinnerTarget = targetCalories * 0.30;
            double snackTarget = targetCalories * 0.10;

            SmartMeal bfItem = getSmartItem(filter, Arrays.asList("Snack", "Protein", "Fruit", "Dairy"));
            plan.put("breakfast", calculateQuantity(bfItem, bfTarget));

            SmartMeal lunchGrain = getSmartItem(filter, Arrays.asList("Grains"));
            SmartMeal lunchDish = getSmartItem(filter, Arrays.asList("Cooked Dish", "Protein"));
            plan.put("lunch", calculateComboQuantity(lunchGrain, lunchDish, lunchTarget));

            SmartMeal dinnerGrain = getSmartItem(filter, Arrays.asList("Grains"));
            SmartMeal dinnerDish = getSmartItem(filter, Arrays.asList("Cooked Dish", "Protein"));
            plan.put("dinner", calculateComboQuantity(dinnerGrain, dinnerDish, dinnerTarget));

            SmartMeal snackItem = getSmartItem(filter, Arrays.asList("Fruit", "Snack"));
            plan.put("snacks", calculateQuantity(snackItem, snackTarget));

            multipleOptions.add(plan);
        }
        return multipleOptions;
    }

    private SmartMeal getSmartItem(String filter, List<String> categories) {
        String dbFilter = filter;
        if (filter.equalsIgnoreCase("Low Carb") || filter.equalsIgnoreCase("Low Fat")) dbFilter = "Weight Loss";

        SmartMeal item = smartMealRepository.getFilteredMeal(dbFilter, categories);
        if (item == null) {
            item = smartMealRepository.getFallbackMeal(categories);
        }
        return item;
    }

    private Map<String, Object> calculateQuantity(SmartMeal food, double targetCal) {
        Map<String, Object> result = new HashMap<>();
        if(food == null) {
            result.put("name", "Healthy Snack"); result.put("qty", 1); result.put("unit", "serving"); result.put("cal", Math.round(targetCal)); return result;
        }
        double rawQty = targetCal / food.getCalories();
        double finalQty = Math.round(rawQty * 2) / 2.0;
        if(finalQty < 0.5) finalQty = 0.5;

        result.put("name", food.getFoodName());
        result.put("qty", finalQty);
        // Null safety added here
        result.put("unit", food.getServingUnit() != null ? food.getServingUnit() : "serving");
        result.put("cal", Math.round(food.getCalories() * finalQty));
        return result;
    }

    private Map<String, Object> calculateComboQuantity(SmartMeal grain, SmartMeal dish, double targetCal) {
        Map<String, Object> result = new HashMap<>();
        if(grain == null || dish == null) {
            result.put("grainName", "Healthy Carbs"); result.put("grainQty", 1); result.put("grainUnit", "serving");
            result.put("dishName", "Protein Source"); result.put("dishQty", 1); result.put("dishUnit", "serving");
            result.put("totalCal", Math.round(targetCal)); return result;
        }
        double grainRawQty = (targetCal * 0.5) / grain.getCalories();
        double dishRawQty = (targetCal * 0.5) / dish.getCalories();
        double finalGrainQty = Math.round(grainRawQty * 2) / 2.0;
        double finalDishQty = Math.round(dishRawQty * 2) / 2.0;
        if(finalGrainQty < 0.5) finalGrainQty = 1.0;
        if(finalDishQty < 0.5) finalDishQty = 0.5;

        result.put("grainName", grain.getFoodName());
        result.put("grainQty", finalGrainQty);
        result.put("grainUnit", grain.getServingUnit() != null ? grain.getServingUnit() : "serving");

        result.put("dishName", dish.getFoodName());
        result.put("dishQty", finalDishQty);
        result.put("dishUnit", dish.getServingUnit() != null ? dish.getServingUnit() : "serving");

        result.put("totalCal", Math.round((grain.getCalories() * finalGrainQty) + (dish.getCalories() * finalDishQty)));
        return result;
    }




}