package com.sahaayata.minorproject.model;

import jakarta.persistence.*;

@Entity
@Table(name = "user_recipes")
public class Recipe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @Column(length = 1000)
    private String description;

    @Column(name = "image_url")
    private String imageUrl;

    // Link Recipe to User
    @ManyToOne
    @JoinColumn(name = "user_id")
    private userCredential user;

    // --- Getters & Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public userCredential getUser() { return user; }
    public void setUser(userCredential user) { this.user = user; }
}