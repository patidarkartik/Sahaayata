package com.sahaayata.minorproject.model;

import jakarta.persistence.*;

@Entity
@Table(name = "user_recipes")
public class Recipe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @Column(length = 2000)
    private String description;

    @Column(name = "image_url")
    private String imageUrl;

    // ==========================================
    // COMMUNITY FEATURES
    // ==========================================
    @Column(name = "is_public")
    private boolean isPublic = true;

    @Column(name = "likes_count")
    private int likesCount = 0;

    private String tags;

    // ==========================================
    // AI ESTIMATED MACROS & SERVINGS
    // ==========================================
    private Double servings = 1.0; // Naya field

    private Double calories = 0.0;
    private Double protein = 0.0;
    private Double carbs = 0.0;
    private Double fats = 0.0;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private userCredential user;

    // ==========================================
    // GETTERS & SETTERS
    // ==========================================

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public boolean isPublic() { return isPublic; }
    public void setPublic(boolean isPublic) { this.isPublic = isPublic; }

    public int getLikesCount() { return likesCount; }
    public void setLikesCount(int likesCount) { this.likesCount = likesCount; }

    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }

    public Double getServings() { return servings; }
    public void setServings(Double servings) { this.servings = servings; }

    public Double getCalories() { return calories; }
    public void setCalories(Double calories) { this.calories = calories; }

    public Double getProtein() { return protein; }
    public void setProtein(Double protein) { this.protein = protein; }

    public Double getCarbs() { return carbs; }
    public void setCarbs(Double carbs) { this.carbs = carbs; }

    public Double getFats() { return fats; }
    public void setFats(Double fats) { this.fats = fats; }

    public userCredential getUser() { return user; }
    public void setUser(userCredential user) { this.user = user; }
}