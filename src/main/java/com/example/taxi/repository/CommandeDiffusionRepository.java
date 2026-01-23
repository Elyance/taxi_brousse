package com.example.taxi.repository;

import com.example.taxi.model.CommandeDiffusion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommandeDiffusionRepository extends JpaRepository<CommandeDiffusion, Integer> {
}