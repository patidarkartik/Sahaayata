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
        Set<Long> usedIds = new HashSet<>();

        for (int i = 1; i <= 3; i++) {
            Map<String, Object> plan = new HashMap<>();
            plan.put("optionName", "Option " + i);

            double bfTarget = targetCalories * 0.25;
            double lunchTarget = targetCalories * 0.35;
            double dinnerTarget = targetCalories * 0.30;
            double snackTarget = targetCalories * 0.10;

            SmartMeal bfItem = getSmartItem(filter, Arrays.asList("Snack", "Protein", "Fruit", "Dairy"), usedIds, bfTarget);
            plan.put("breakfast", calculateQuantity(bfItem, bfTarget));

            SmartMeal lunchGrain = getSmartItem(filter, Arrays.asList("Grains"), usedIds, lunchTarget * 0.5);
            SmartMeal lunchDish = getSmartItem(filter, Arrays.asList("Cooked Dish", "Protein"), usedIds, lunchTarget * 0.5);
            plan.put("lunch", calculateComboQuantity(lunchGrain, lunchDish, lunchTarget));

            SmartMeal dinnerGrain = getSmartItem(filter, Arrays.asList("Grains"), usedIds, dinnerTarget * 0.5);
            SmartMeal dinnerDish = getSmartItem(filter, Arrays.asList("Cooked Dish", "Protein"), usedIds, dinnerTarget * 0.5);
            plan.put("dinner", calculateComboQuantity(dinnerGrain, dinnerDish, dinnerTarget));

            SmartMeal snackItem = getSmartItem(filter, Arrays.asList("Fruit", "Snack"), usedIds, snackTarget);
            plan.put("snacks", calculateQuantity(snackItem, snackTarget));

            multipleOptions.add(plan);
        }
        return multipleOptions;
    }

    private SmartMeal getSmartItem(String filter, List<String> categories, Set<Long> usedIds, double targetCal) {
        String dbFilter = filter;
        if (filter.equalsIgnoreCase("Low Carb") || filter.equalsIgnoreCase("Low Fat")) dbFilter = "Weight Loss";

        List<SmartMeal> items = smartMealRepository.getFilteredMeals(dbFilter, categories);
        SmartMeal selected = pickBestItem(items, usedIds, targetCal);
        
        if (selected == null) {
            List<SmartMeal> fallbackItems = smartMealRepository.getFallbackMeals(categories);
            selected = pickBestItem(fallbackItems, usedIds, targetCal);
            if (selected == null && !fallbackItems.isEmpty()) {
                selected = fallbackItems.get(0);
            }
        } else if (selected == null && !items.isEmpty()) {
             selected = items.get(0);
        }
        
        if (selected != null) {
            usedIds.add(selected.getId());
        }
        return selected;
    }

    private SmartMeal pickBestItem(List<SmartMeal> items, Set<Long> usedIds, double targetCal) {
        SmartMeal bestItem = null;
        double bestDiff = Double.MAX_VALUE;

        for (SmartMeal item : items) {
            if (!usedIds.contains(item.getId())) {
                double qty = targetCal / item.getCalories();
                if (qty >= 0.5 && qty <= 3.0) {
                    return item; // perfect match
                }
                
                double diff = Math.abs(qty - 1.5);
                if (diff < bestDiff) {
                    bestDiff = diff;
                    bestItem = item;
                }
            }
        }
        return bestItem;
    }

    private Map<String, Object> calculateQuantity(SmartMeal food, double targetCal) {
        Map<String, Object> result = new HashMap<>();
        if(food == null) {
            result.put("name", "Healthy Snack"); result.put("qty", 1); result.put("unit", "serving"); result.put("cal", Math.round(targetCal)); return result;
        }
        double rawQty = targetCal / food.getCalories();
        double finalQty = Math.round(rawQty * 2) / 2.0;
        if(finalQty < 0.5) finalQty = 0.5;
        if(finalQty > 3.0) finalQty = 3.0; // Prevent unrealistic amounts

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
        
        if(finalGrainQty > 3.0) finalGrainQty = 3.0; // Prevent unrealistic amounts
        if(finalDishQty > 3.0) finalDishQty = 3.0; // Prevent unrealistic amounts

        result.put("grainName", grain.getFoodName());
        result.put("grainQty", finalGrainQty);
        result.put("grainUnit", grain.getServingUnit() != null ? grain.getServingUnit() : "serving");

        result.put("dishName", dish.getFoodName());
        result.put("dishQty", finalDishQty);
        result.put("dishUnit", dish.getServingUnit() != null ? dish.getServingUnit() : "serving");

        result.put("totalCal", Math.round((grain.getCalories() * finalGrainQty) + (dish.getCalories() * finalDishQty)));
        return result;
    }

    // ========================================================
    // PART 3: LOG FULL PLAN TO DASHBOARD
    // ========================================================
    @Autowired
    private com.sahaayata.minorproject.repository.DailyLogRepository dailyLogRepository;

    @org.springframework.web.bind.annotation.PostMapping("/log-full-plan")
    public Map<String, Object> logFullPlan(@org.springframework.web.bind.annotation.RequestBody List<Map<String, Object>> payload, jakarta.servlet.http.HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        com.sahaayata.minorproject.model.UserCredential user = (com.sahaayata.minorproject.model.UserCredential) session.getAttribute("loggedInUser");
        if (user == null) {
            response.put("success", false);
            return response;
        }

        try {
            for (Map<String, Object> item : payload) {
                String mealType = (String) item.get("mealType");
                String name = (String) item.get("name");
                Double qty = Double.valueOf(item.get("quantity").toString());

                // Find food by name
                List<Food> foods = foodRepository.findByFoodNameContainingIgnoreCase(name);
                if (!foods.isEmpty()) {
                    Food food = foods.get(0); // pick first match
                    com.sahaayata.minorproject.model.DailyLog log = new com.sahaayata.minorproject.model.DailyLog();
                    log.setUser(user);
                    log.setFood(food);
                    log.setQuantity(qty);
                    log.setMealType(mealType);
                    log.setLogDate(java.time.LocalDate.now());
                    dailyLogRepository.save(log);
                }
            }
            response.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
        }
        return response;
    }
}