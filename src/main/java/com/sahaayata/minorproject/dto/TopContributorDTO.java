package com.sahaayata.minorproject.dto;

public class TopContributorDTO {
    private String username;
    private Long recipeCount;

    public TopContributorDTO(String username, Long recipeCount) {
        this.username = username;
        this.recipeCount = recipeCount;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Long getRecipeCount() {
        return recipeCount;
    }

    public void setRecipeCount(Long recipeCount) {
        this.recipeCount = recipeCount;
    }
}
