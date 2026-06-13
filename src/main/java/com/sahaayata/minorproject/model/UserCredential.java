package com.sahaayata.minorproject.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "user_details")
public class UserCredential {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(unique = true, nullable = false)
    private String email;

    private String password;

    // --- NEW: Phone Number (Settings page ke liye) ---
    private String phoneNumber;

    // --- Onboarding Logic ---
    @Column(columnDefinition = "boolean default false")
    private boolean onboardingCompleted = false;

    // --- Health Data (From Onboarding form) ---
    private int age;
    private double height; // in cm
    private double weight; // in kg
    private String gender;
    private String activityLevel;

    // Community data

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<CommunityPost> posts;

    @OneToMany(mappedBy = "following", cascade = CascadeType.ALL)
    private List<UserFollower> followers;

    @OneToMany(mappedBy = "follower", cascade = CascadeType.ALL)
    private List<UserFollower> following;

    // Getters and Setters for the new relations
    public List<CommunityPost> getPosts() { return posts; }
    public void setPosts(List<CommunityPost> posts) { this.posts = posts; }

    public List<UserFollower> getFollowers() { return followers; }
    public void setFollowers(List<UserFollower> followers) { this.followers = followers; }

    public List<UserFollower> getFollowing() { return following; }
    public void setFollowing(List<UserFollower> following) { this.following = following; }

    // ==========================
    //    Getters and Setters
    // ==========================

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // ✅ NEW Getter/Setter for Phone Number
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    // Onboarding Getters/Setters
    public boolean isOnboardingCompleted() {
        return onboardingCompleted;
    }

    public void setOnboardingCompleted(boolean onboardingCompleted) {
        this.onboardingCompleted = onboardingCompleted;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getActivityLevel() {
        return activityLevel;
    }

    public void setActivityLevel(String activityLevel) {
        this.activityLevel = activityLevel;
    }

    @Override
    public String toString() {
        return "userCredential{" +
                "username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", onboardingCompleted=" + onboardingCompleted +
                '}';
    }



}