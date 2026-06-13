package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.UserCredential;
import com.sahaayata.minorproject.model.UserFollower;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserFollowerRepository extends JpaRepository<UserFollower, Long> {
    boolean existsByFollowerAndFollowing(UserCredential follower, UserCredential following);
    long countByFollowing(UserCredential user);
    long countByFollower(UserCredential user);
}