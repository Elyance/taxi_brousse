package com.example.taxi.repository;

import com.example.taxi.model.CommandeProduit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommandeProduitRepository extends JpaRepository<CommandeProduit, Integer> {
}