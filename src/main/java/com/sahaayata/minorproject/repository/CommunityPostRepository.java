package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.CommunityPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommunityPostRepository extends JpaRepository<CommunityPost, Long> {
    List<CommunityPost> findAllByOrderByCreatedAtDesc();

    @org.springframework.data.jpa.repository.Query("SELECT p.user.username, COUNT(p) as postCount FROM CommunityPost p GROUP BY p.user.username ORDER BY postCount DESC")
    List<Object[]> findTopContributors(org.springframework.data.domain.Pageable pageable);
}