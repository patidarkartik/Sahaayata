package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.UserCredential;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserCredential, Long> {

    // Login ke liye ye method sabse zaroori hai
    UserCredential findByEmail(String email);

    // Registration ke waqt duplicate check karne ke liye
    UserCredential findByUsername(String username);
}