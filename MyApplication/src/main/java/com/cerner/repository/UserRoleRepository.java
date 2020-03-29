package com.cerner.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Service;

import com.cerner.model.UserRole;

@Service
public interface UserRoleRepository extends CrudRepository<UserRole, Integer>, JpaRepository<UserRole, Integer> {
	
}