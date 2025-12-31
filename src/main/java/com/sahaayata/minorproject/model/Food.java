package com.sahaayata.minorproject.model;

import jakarta.persistence.*;

@Entity
@Table(name = "foods")
public class Food {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "food_name")
    private String foodName;

    private String category; // Fruit, Vegetable, etc.

    @Column(name = "default_serving_weight")
    private double defaultServingWeight;

    @Column(name = "serving_unit")
    private String servingUnit;

    private double calories;
    private double protein;
    private double carbs;
    private double fats;
    private double fiber;

    @Column(name = "health_rating")
    private int healthRating; // 1-10

    @Column(name = "is_vegetarian")
    private boolean vegetarian;

    @Column(name = "recommended_for")
    private String recommendedFor; // Weight Loss, Muscle Gain

    // --- Getters and Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getDefaultServingWeight() { return defaultServingWeight; }
    public void setDefaultServingWeight(double defaultServingWeight) { this.defaultServingWeight = defaultServingWeight; }

    public String getServingUnit() { return servingUnit; }
    public void setServingUnit(String servingUnit) { this.servingUnit = servingUnit; }

    public double getCalories() { return calories; }
    public void setCalories(double calories) { this.calories = calories; }

    public double getProtein() { return protein; }
    public void setProtein(double protein) { this.protein = protein; }

    public double getCarbs() { return carbs; }
    public void setCarbs(double carbs) { this.carbs = carbs; }

    public double getFats() { return fats; }
    public void setFats(double fats) { this.fats = fats; }

    public double getFiber() { return fiber; }
    public void setFiber(double fiber) { this.fiber = fiber; }

    public int getHealthRating() { return healthRating; }
    public void setHealthRating(int healthRating) { this.healthRating = healthRating; }

    public boolean isVegetarian() { return vegetarian; }
    public void setVegetarian(boolean vegetarian) { this.vegetarian = vegetarian; }

    public String getRecommendedFor() { return recommendedFor; }
    public void setRecommendedFor(String recommendedFor) { this.recommendedFor = recommendedFor; }
}