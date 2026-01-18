package com.example.taxi.repository;

import com.example.taxi.model.Voyage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VoyageRepository extends JpaRepository<Voyage, Integer> {

    @Query("SELECT v FROM Voyage v " +
           "JOIN FETCH v.chauffeur " +
           "JOIN FETCH v.vehicule ve " +
           "JOIN FETCH ve.vehiculeModele " +
           "JOIN FETCH v.trajet t " +
           "JOIN FETCH t.gareDepart gd " +
           "JOIN FETCH gd.ville vd " +
           "JOIN FETCH t.gareArrivee ga " +
           "JOIN FETCH ga.ville va " +
           "JOIN FETCH v.voyageStatut")
    List<Voyage> findAllWithDetails();
}