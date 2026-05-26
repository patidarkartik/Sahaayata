package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.Recipe;
import com.sahaayata.minorproject.model.userCredential;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecipeRepository extends JpaRepository<Recipe, Long> {

    // Logged-in user ki saari recipes nikalne ke liye custom method
    List<Recipe> findByUser(userCredential user);

}