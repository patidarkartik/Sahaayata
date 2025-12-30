package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.userCredential;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<userCredential, Long> {

    // Login ke liye ye method sabse zaroori hai
    userCredential findByEmail(String email);

    // Registration ke waqt duplicate check karne ke liye
    userCredential findByUsername(String username);
}