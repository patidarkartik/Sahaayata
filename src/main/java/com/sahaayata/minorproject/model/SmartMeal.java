package com.sahaayata.minorproject.model;

import jakarta.persistence.*;

@Entity
@Table(name = "smart_meals")
public class SmartMeal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "food_name")
    private String foodName;
    private String category;
    @Column(name = "serving_unit")
    private String servingUnit;
    private Double calories;
    private Double protein;
    private Double carbs;
    private Double fats;
    @Column(name = "smart_filter")
    private String smartFilter;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getServingUnit() { return servingUnit; }
    public void setServingUnit(String servingUnit) { this.servingUnit = servingUnit; }
    public Double getCalories() { return calories; }
    public void setCalories(Double calories) { this.calories = calories; }
    public Double getProtein() { return protein; }
    public void setProtein(Double protein) { this.protein = protein; }
    public Double getCarbs() { return carbs; }
    public void setCarbs(Double carbs) { this.carbs = carbs; }
    public Double getFats() { return fats; }
    public void setFats(Double fats) { this.fats = fats; }
    public String getSmartFilter() { return smartFilter; }
    public void setSmartFilter(String smartFilter) { this.smartFilter = smartFilter; }
}