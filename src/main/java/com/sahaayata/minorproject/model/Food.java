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

    private String category;

    @Column(name = "default_serving_weight")
    private Double defaultServingWeight;

    @Column(name = "serving_unit")
    private String servingUnit;

    private Double calories;
    private Double protein;
    private Double carbs;
    private Double fats;
    private Double fiber;

    @Column(name = "glycemic_index")
    private String glycemicIndex;

    @Column(name = "health_rating")
    private Integer healthRating;

    @Column(name = "is_vegetarian")
    private Boolean isVegetarian;

    @Column(name = "recommended_for")
    private String recommendedFor;

    // ---- NAYA COLUMN FILTERS KE LIYE ----
    @Column(name = "smart_filter")
    private String smartFilter;

    // --- Getters and Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Double getDefaultServingWeight() { return defaultServingWeight; }
    public void setDefaultServingWeight(Double defaultServingWeight) { this.defaultServingWeight = defaultServingWeight; }

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

    public Double getFiber() { return fiber; }
    public void setFiber(Double fiber) { this.fiber = fiber; }

    public String getGlycemicIndex() { return glycemicIndex; }
    public void setGlycemicIndex(String glycemicIndex) { this.glycemicIndex = glycemicIndex; }

    public Integer getHealthRating() { return healthRating; }
    public void setHealthRating(Integer healthRating) { this.healthRating = healthRating; }

    public Boolean getVegetarian() { return isVegetarian; }
    public void setVegetarian(Boolean vegetarian) { isVegetarian = vegetarian; }

    public String getRecommendedFor() { return recommendedFor; }
    public void setRecommendedFor(String recommendedFor) { this.recommendedFor = recommendedFor; }

    public String getSmartFilter() { return smartFilter; }
    public void setSmartFilter(String smartFilter) { this.smartFilter = smartFilter; }
}