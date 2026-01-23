package com.example.taxi.repository;

import com.example.taxi.model.CommandeDiffusion;
import com.example.taxi.model.Payement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PayementRepository extends JpaRepository<Payement, Integer> {

    List<Payement> findByCommandeDiffusion(CommandeDiffusion commandeDiffusion);
}