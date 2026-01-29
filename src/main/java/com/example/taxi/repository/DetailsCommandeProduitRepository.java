package com.example.taxi.repository;

import com.example.taxi.model.DetailsCommandeProduit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetailsCommandeProduitRepository extends JpaRepository<DetailsCommandeProduit, Integer> {
}