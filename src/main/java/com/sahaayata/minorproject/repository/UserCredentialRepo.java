package com.sahaayata.minorproject.repository;

import com.sahaayata.minorproject.model.userCredential;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


// JPARepo<Entity_type,PrimaryKeytype>
@Repository
public interface UserCredentialRepo extends JpaRepository<userCredential,Long> {
    // methods used : save(), findById(), findAll(), deleteById() etc.

    userCredential findByUsername(String username);

    userCredential findByEmail(String email);
}
