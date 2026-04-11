package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.Food;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FoodRepository extends JpaRepository<Food, Long> {

    List<Food> findByFoodNameContainingIgnoreCase(String name);

    // Ye recommended_for column check karega (as per food1.sql)
    @Query(value = "SELECT * FROM foods WHERE category IN (:categories) AND recommended_for IN (:recommended)", nativeQuery = true)
    List<Food> findSuggestions(@Param("categories") List<String> categories, @Param("recommended") List<String> recommended);
}