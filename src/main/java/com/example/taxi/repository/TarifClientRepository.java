package com.example.taxi.repository;

import com.example.taxi.model.TarifClient;
import com.example.taxi.model.CategorieClient;
import com.example.taxi.model.Tarif;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TarifClientRepository extends JpaRepository<TarifClient, Integer> {
    Optional<TarifClient> findByTarifAndCategorieClient(Tarif tarif, CategorieClient categorieClient);
}