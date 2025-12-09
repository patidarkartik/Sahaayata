package com.sahaayata.minorproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class MainController {

    @RequestMapping("/")
    public String home(){
        return "landing";
    }

    @RequestMapping("/register")
    public String register(){
        return "register";
    }

    @RequestMapping("/login")
    public String  login(){
        return "login";
    }

}
