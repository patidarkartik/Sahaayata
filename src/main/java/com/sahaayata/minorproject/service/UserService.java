package com.sahaayata.minorproject.service;

import com.sahaayata.minorproject.model.userCredential;
import com.sahaayata.minorproject.repository.UserCredentialRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

    @Autowired
    private UserCredentialRepo userRepository;

    @Transactional
    public userCredential registerUser(userCredential user){

        if (userRepository.findByUsername(user.getUsername()) != null){
            throw new IllegalArgumentException("Username is already in use");
        }
        if (userRepository.findByEmail(user.getEmail()) != null){
            throw new IllegalArgumentException("Email address is already registered.");
        }
        return userRepository.save(user);
    }
}
