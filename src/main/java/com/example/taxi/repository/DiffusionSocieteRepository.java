package com.example.taxi.repository;

import com.example.taxi.model.DiffusionSociete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiffusionSocieteRepository extends JpaRepository<DiffusionSociete, Integer> {

    @Query("SELECT d FROM DiffusionSociete d JOIN d.voyage v WHERE " +
           "(:idSociete IS NULL OR d.societe.idSociete = :idSociete) AND " +
           "(:month IS NULL OR EXTRACT(MONTH FROM d.daty) = :month) AND " +
           "(:year IS NULL OR EXTRACT(YEAR FROM d.daty) = :year) AND " +
           "(:idTrajet IS NULL OR v.trajet.idTrajet = :idTrajet) AND " +
           "(:idVehicule IS NULL OR v.vehicule.idVehicule = :idVehicule)")
    List<DiffusionSociete> findFiltered(@Param("idSociete") Integer idSociete,
                                        @Param("month") Integer month,
                                        @Param("year") Integer year,
                                        @Param("idTrajet") Integer idTrajet,
                                        @Param("idVehicule") Integer idVehicule);
}