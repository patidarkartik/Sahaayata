package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.SmartMeal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SmartMealRepository extends JpaRepository<SmartMeal, Long> {
    @Query(value = "SELECT * FROM smart_meals WHERE smart_filter = :filter AND category IN (:categories) ORDER BY RAND() LIMIT 1", nativeQuery = true)
    SmartMeal getFilteredMeal(@Param("filter") String filter, @Param("categories") List<String> categories);

    @Query(value = "SELECT * FROM smart_meals WHERE category IN (:categories) ORDER BY RAND() LIMIT 1", nativeQuery = true)
    SmartMeal getFallbackMeal(@Param("categories") List<String> categories);

    @Query(value = "SELECT * FROM smart_meals WHERE smart_filter = :filter AND category IN (:categories) ORDER BY RAND()", nativeQuery = true)
    List<SmartMeal> getFilteredMeals(@Param("filter") String filter, @Param("categories") List<String> categories);

    @Query(value = "SELECT * FROM smart_meals WHERE category IN (:categories) ORDER BY RAND()", nativeQuery = true)
    List<SmartMeal> getFallbackMeals(@Param("categories") List<String> categories);
}