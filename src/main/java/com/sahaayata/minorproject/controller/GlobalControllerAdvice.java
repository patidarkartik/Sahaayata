package com.sahaayata.minorproject.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    // application.properties se URL fetch karega
    @Value("${n8n.webhook.url}")
    private String n8nWebhookUrl;

    // Ye method is URL ko 'n8nWebhookUrl' naam se har JSP me bhej dega
    @ModelAttribute("n8nWebhookUrl")
    public String globalN8nWebhookUrl() {
        return n8nWebhookUrl;
    }
}