package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.model.Food;
import com.sahaayata.minorproject.repository.FoodRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class FoodAPIController {

    @Autowired
    private FoodRepository foodRepository;

    @GetMapping("/searchFood")
    public ResponseEntity<List<Food>> searchFood(@RequestParam("q") String query) {
        // Database se food search karke maximum 10 results return karenge
        List<Food> foods = foodRepository.findByFoodNameContainingIgnoreCase(query);

        // Agar list bahut lambi hai toh top 10 items bhejenge
        if(foods.size() > 10) {
            foods = foods.subList(0, 10);
        }
        return ResponseEntity.ok(foods);
    }
}