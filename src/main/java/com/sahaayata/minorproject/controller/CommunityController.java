package com.sahaayata.minorproject.controller;

import com.sahaayata.minorproject.dto.CommunityPostDTO;
import com.sahaayata.minorproject.model.Recipe;
import com.sahaayata.minorproject.model.UserCredential;
import com.sahaayata.minorproject.repository.RecipeRepository;
import com.sahaayata.minorproject.service.CommunityService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    @Autowired
    private RecipeRepository recipeRepository;

    // ==========================================
    // 1. SHOW COMMUNITY FEED
    // ==========================================
    @GetMapping("/community")
    public String showCommunityPage(HttpSession session, Model model) {
        UserCredential loggedInUser = (UserCredential) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<CommunityPostDTO> recipesList = communityService.getAllCommunityPosts();
        model.addAttribute("communityRecipes", recipesList);

        List<com.sahaayata.minorproject.dto.TopContributorDTO> topContributors = communityService.getTopContributors();
        model.addAttribute("topContributors", topContributors);

        return "community";
    }

    // ==========================================
    // 2. SHARE RECIPE FROM MY RECIPES TO COMMUNITY
    // ==========================================
    @PostMapping("/share-to-community")
    public String shareRecipeToCommunity(@RequestParam("recipeId") Long recipeId, HttpSession session) {
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Optional<Recipe> recipeOpt = recipeRepository.findById(recipeId);

        // Validation check taaki koi dusre ki recipe share na kar sake
        if (recipeOpt.isPresent() && recipeOpt.get().getUser().getId().equals(user.getId())) {
            communityService.createPostFromRecipe(user, recipeOpt.get());
        }

        // Share hone ke baad seedha community timeline par bhej denge
        return "redirect:/community";
    }

    @Autowired
    private com.sahaayata.minorproject.repository.CommunityPostRepository communityPostRepository;

    @Autowired
    private com.sahaayata.minorproject.repository.PostCommentRepository postCommentRepository;

    // ==========================================
    // 3. LIKE POST
    // ==========================================
    @PostMapping("/like-post")
    @org.springframework.web.bind.annotation.ResponseBody
    public java.util.Map<String, Object> likePost(@RequestParam("postId") Long postId) {
        java.util.Map<String, Object> response = new java.util.HashMap<>();
        com.sahaayata.minorproject.model.CommunityPost post = communityPostRepository.findById(postId).orElse(null);
        if(post != null) {
            post.setLikesCount(post.getLikesCount() + 1);
            communityPostRepository.save(post);
            response.put("success", true);
            response.put("likes", post.getLikesCount());
        } else {
            response.put("success", false);
        }
        return response;
    }

    // ==========================================
    // 4. ADD COMMENT
    // ==========================================
    @PostMapping("/add-comment")
    @org.springframework.web.bind.annotation.ResponseBody
    public java.util.Map<String, Object> addComment(@RequestParam("postId") Long postId, @RequestParam("text") String text, HttpSession session) {
        java.util.Map<String, Object> response = new java.util.HashMap<>();
        UserCredential user = (UserCredential) session.getAttribute("loggedInUser");
        if (user == null) {
            response.put("success", false);
            return response;
        }

        com.sahaayata.minorproject.model.CommunityPost post = communityPostRepository.findById(postId).orElse(null);
        if(post != null && text != null && !text.trim().isEmpty()) {
            com.sahaayata.minorproject.model.PostComment comment = new com.sahaayata.minorproject.model.PostComment();
            comment.setPost(post);
            comment.setUser(user);
            comment.setCommentText(text.trim());
            postCommentRepository.save(comment);

            response.put("success", true);
            response.put("author", user.getUsername());
            response.put("text", comment.getCommentText());
        } else {
            response.put("success", false);
        }
        return response;
    }
}