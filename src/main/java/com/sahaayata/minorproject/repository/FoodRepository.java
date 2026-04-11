package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.Food;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FoodRepository extends JpaRepository<Food, Long> {

    // Normal search bar ke liye
    List<Food> findByFoodNameContainingIgnoreCase(String name);

    // Naya SMART FILTER query (Jo Meal Type aur Smart Filter dono check karega)
    @Query("SELECT f FROM Food f WHERE f.smartFilter = :filter AND f.category IN :categories")
    List<Food> findSuggestions(@Param("filter") String filter, @Param("categories") List<String> categories);
}