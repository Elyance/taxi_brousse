package com.example.taxi.repository;

import com.example.taxi.model.Billet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface BilletRepository extends JpaRepository<Billet, Integer> {

    @Query("SELECT b FROM Billet b " +
           "LEFT JOIN FETCH b.client c " +
           "LEFT JOIN FETCH c.categorieClient " +
           "LEFT JOIN FETCH b.voyage v " +
           "LEFT JOIN FETCH v.trajet t " +
           "LEFT JOIN FETCH t.gareDepart gd " +
           "LEFT JOIN FETCH gd.ville vd " +
           "LEFT JOIN FETCH t.gareArrivee ga " +
           "LEFT JOIN FETCH ga.ville va " +
           "LEFT JOIN FETCH v.vehicule veh " +
           "LEFT JOIN FETCH veh.vehiculeModele " +
           "LEFT JOIN FETCH b.place p " +
           "LEFT JOIN FETCH p.categoriePlace " +
           "LEFT JOIN FETCH p.statutPlace")
    List<Billet> findAllWithDetails();

}
