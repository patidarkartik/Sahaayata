package com.sahaayata.minorproject.service;

import com.sahaayata.minorproject.dto.CommunityPostDTO;
import com.sahaayata.minorproject.model.CommunityPost;
import com.sahaayata.minorproject.model.UserCredential;
import com.sahaayata.minorproject.repository.CommunityPostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class CommunityService {

    @Autowired
    private CommunityPostRepository postRepository;

    public void createPostFromRecipe(UserCredential user, com.sahaayata.minorproject.model.Recipe recipe) {
        CommunityPost post = new CommunityPost();
        post.setUser(user);
        post.setTitle(recipe.getTitle());

        String formattedContent = recipe.getDescription() + "\n\n" +
                "🔥 Macros per serving:\n" +
                "Calories: " + recipe.getCalories() + " kcal | " +
                "Protein: " + recipe.getProtein() + "g | " +
                "Carbs: " + recipe.getCarbs() + "g | " +
                "Fats: " + recipe.getFats() + "g";

        post.setContent(formattedContent);

        if (recipe.getImageUrl() != null && !recipe.getImageUrl().isEmpty()) {
            post.setImageUrl(recipe.getImageUrl());
        }

        post.setLikesCount(0);
        postRepository.save(post);
    }

    public List<CommunityPostDTO> getAllCommunityPosts() {
        List<CommunityPost> posts = postRepository.findAllByOrderByCreatedAtDesc();
        List<CommunityPostDTO> postDTOs = new ArrayList<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");

        for (CommunityPost post : posts) {
            CommunityPostDTO dto = new CommunityPostDTO();
            dto.setId(post.getPostId()); // Id set kiya

            if(post.getUser() != null) {
                dto.setAuthorName(post.getUser().getUsername());
            } else {
                dto.setAuthorName("Anonymous Chef");
            }

            dto.setPostedDate(post.getCreatedAt().format(formatter));
            dto.setName(post.getTitle());
            dto.setDescription(post.getContent());
            dto.setLikes(post.getLikesCount());
            dto.setImageUrl(post.getImageUrl());
            dto.setTags(Arrays.asList("Healthy", "Sahaayata Community"));

            // Load comments efficiently
            List<String> commentStrings = new ArrayList<>();
            if (post.getComments() != null) {
                for (com.sahaayata.minorproject.model.PostComment comment : post.getComments()) {
                    String author = comment.getUser() != null ? comment.getUser().getUsername() : "Anonymous";
                    commentStrings.add("<b>" + author + ":</b> " + comment.getCommentText());
                }
            }
            dto.setComments(commentStrings);

            postDTOs.add(dto);
        }

        return postDTOs;
    }

    public List<com.sahaayata.minorproject.dto.TopContributorDTO> getTopContributors() {
        List<Object[]> results = postRepository.findTopContributors(org.springframework.data.domain.PageRequest.of(0, 3));
        List<com.sahaayata.minorproject.dto.TopContributorDTO> topContributors = new ArrayList<>();
        for (Object[] row : results) {
            String username = (String) row[0];
            Long count = (Long) row[1];
            topContributors.add(new com.sahaayata.minorproject.dto.TopContributorDTO(username, count));
        }
        return topContributors;
    }
}