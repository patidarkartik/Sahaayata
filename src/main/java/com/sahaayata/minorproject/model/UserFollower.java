package com.sahaayata.minorproject.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_followers")
public class UserFollower {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Relates to UserCredential now
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "follower_id", nullable = false)
    private UserCredential follower;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "following_id", nullable = false)
    private UserCredential following;

    @Column(updatable = false)
    private LocalDateTime followedAt;

    public UserFollower() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public UserCredential getFollower() { return follower; }
    public void setFollower(UserCredential follower) { this.follower = follower; }

    public UserCredential getFollowing() { return following; }
    public void setFollowing(UserCredential following) { this.following = following; }

    public LocalDateTime getFollowedAt() { return followedAt; }
    public void setFollowedAt(LocalDateTime followedAt) { this.followedAt = followedAt; }

    @PrePersist
    protected void onCreate() {
        this.followedAt = LocalDateTime.now();
    }
}
