package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.model.userCredential;
import com.sahaayata.minorproject.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class RegisterController {

    private final UserService userService;

    public RegisterController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody userCredential user) {
        try {
            userCredential registerUser = userService.registerUser(user);
            return new ResponseEntity<>(registerUser, HttpStatus.CREATED);
        }
        catch (IllegalArgumentException e) {
            return new ResponseEntity<>(
                    java.util.Collections.singletonMap("message", e.getMessage()),
                    HttpStatus.BAD_REQUEST
            );
        }
        catch (Exception e) {
            return new ResponseEntity<>("Registration failed due to an internal error.", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
