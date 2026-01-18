package com.example.taxi.repository;

import com.example.taxi.model.StatutPlace;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StatutPlaceRepository extends JpaRepository<StatutPlace, Integer> {

    StatutPlace findByLibelle(String libelle);
}