package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.Food;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FoodRepository extends JpaRepository<Food, Long> {
    // Ye method automatically "LIKE %query%" wali SQL query chala dega
    List<Food> findByFoodNameContainingIgnoreCase(String foodName);
}