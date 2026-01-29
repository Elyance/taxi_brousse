package com.example.taxi.repository;

import com.example.taxi.model.CommandeProduit;
import com.example.taxi.model.PaiementCommandeProduit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaiementCommandeProduitRepository extends JpaRepository<PaiementCommandeProduit, Integer> {

    List<PaiementCommandeProduit> findByCommandeProduit(CommandeProduit commandeProduit);
}