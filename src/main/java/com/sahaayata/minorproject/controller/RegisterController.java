package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.model.userCredential;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class RegisterController {

    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody userCredential user) {

        if (user == null) {
            return ResponseEntity
                    .badRequest()
                    .body("User data is missing");
        }

        System.out.println(user.getUsername());
        System.out.println(user.getPassword());
        System.out.println(user.getEmail());

        return ResponseEntity.ok("User registered successfully");
    }


}
