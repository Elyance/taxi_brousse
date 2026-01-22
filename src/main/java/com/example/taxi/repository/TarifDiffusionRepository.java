package com.example.taxi.repository;

import com.example.taxi.model.TarifDiffusion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TarifDiffusionRepository extends JpaRepository<TarifDiffusion, Integer> {
}