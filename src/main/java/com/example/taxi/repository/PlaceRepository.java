package com.example.taxi.repository;

import com.example.taxi.model.Place;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlaceRepository extends JpaRepository<Place, Integer> {

    List<Place> findByVehiculeIdVehicule(Integer idVehicule);

    @Query("SELECT p FROM Place p LEFT JOIN FETCH p.statutPlace LEFT JOIN FETCH p.categoriePlace WHERE p.vehicule.idVehicule = :idVehicule ORDER BY p.numeroPlace")
    List<Place> findByVehiculeIdVehiculeOrderByNumeroPlace(@Param("idVehicule") Integer idVehicule);
}