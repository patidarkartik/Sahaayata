package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.DailyLog;
import com.sahaayata.minorproject.model.UserCredential;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;

@Repository
public interface DailyLogRepository extends JpaRepository<DailyLog, Long> {

    @Query("SELECT SUM(d.food.calories * d.quantity) FROM DailyLog d WHERE d.user = :user AND d.logDate = :date")
    Double getTotalCaloriesForToday(@Param("user") UserCredential user, @Param("date") LocalDate date);

    // Apni existing calories wali query ke theek niche inko paste karein:

    @Query("SELECT SUM(d.food.protein * d.quantity) FROM DailyLog d WHERE d.user = :user AND d.logDate = :date")
    Double getTotalProteinForToday(@Param("user") UserCredential user, @Param("date") LocalDate date);

    @Query("SELECT SUM(d.food.carbs * d.quantity) FROM DailyLog d WHERE d.user = :user AND d.logDate = :date")
    Double getTotalCarbsForToday(@Param("user") UserCredential user, @Param("date") LocalDate date);

    @Query("SELECT SUM(d.food.fats * d.quantity) FROM DailyLog d WHERE d.user = :user AND d.logDate = :date")
    Double getTotalFatsForToday(@Param("user") UserCredential user, @Param("date") LocalDate date);

    @Query("SELECT SUM(d.food.calories * d.quantity) FROM DailyLog d WHERE d.user = :user AND d.logDate = :date AND d.mealType = :mealType")
    Double getTotalCaloriesForMealToday(@Param("user") UserCredential user, @Param("date") LocalDate date, @Param("mealType") String mealType);
}