package com.example.taxi.repository;

import com.example.taxi.model.Tarif;
import com.example.taxi.model.Trajet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TarifRepository extends JpaRepository<Tarif, Integer> {
    List<Tarif> findByTrajet(Trajet trajet);
}