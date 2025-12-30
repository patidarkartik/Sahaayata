package com.sahaayata.minorproject.service;

import com.sahaayata.minorproject.model.userCredential;
import com.sahaayata.minorproject.repository.UserRepository; // ✅ Change 1: Naya Repo Import
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository; // ✅ Change 2: Type UserCredentialRepo se UserRepository hua

    @Transactional
    public userCredential registerUser(userCredential user){

        // Check 1: Username exist karta hai?
        if (userRepository.findByUsername(user.getUsername()) != null){
            throw new IllegalArgumentException("Username is already in use");
        }

        // Check 2: Email exist karta hai?
        if (userRepository.findByEmail(user.getEmail()) != null){
            throw new IllegalArgumentException("Email address is already registered.");
        }

        // Note: 'onboardingCompleted' default false hi rahega (Entity me set hai)

        return userRepository.save(user);
    }
}