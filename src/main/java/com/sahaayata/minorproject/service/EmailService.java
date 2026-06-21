package com.sahaayata.minorproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendOtp(String to, String otp) {
        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo(to);
        message.setSubject("Sahaayata Verification OTP");
        message.setText("Hello,\n\nYour One Time Password (OTP) for Sahaayata verification is: " + otp 
            + "\n\nThis OTP is valid for 5 minutes.\n\nThank you,\nSahaayata Team");

        mailSender.send(message);
    }
}
