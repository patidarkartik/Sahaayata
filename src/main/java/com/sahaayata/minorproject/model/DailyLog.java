package com.sahaayata.minorproject.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "daily_logs")
public class DailyLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "user_id",nullable = false)
    private userCredential user;

    @ManyToOne
    @JoinColumn(name = "food_id",nullable = false)
    private Food food;
    private Double quantity;

    @Column(name = "log_date")
    private LocalDate logDate;
    @Column(name = "meal_type")
    private String mealType;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public userCredential getUser() {
        return user;
    }

    public void setUser(userCredential user) {
        this.user = user;
    }

    public Food getFood() {
        return food;
    }

    public void setFood(Food food) {
        this.food = food;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public LocalDate getLogDate() {
        return logDate;
    }

    public void setLogDate(LocalDate logDate) {
        this.logDate = logDate;
    }

    public String getMealType() {
        return mealType;
    }

    public void setMealType(String mealType) {
        this.mealType = mealType;
    }

}
