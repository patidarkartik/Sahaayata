package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.PostComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostCommentRepository extends JpaRepository<PostComment, Long> {
    List<PostComment> findByPost_PostIdOrderByCreatedAtAsc(Long postId);
}