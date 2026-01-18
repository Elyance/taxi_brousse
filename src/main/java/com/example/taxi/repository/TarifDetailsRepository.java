package com.example.taxi.repository;

import com.example.taxi.model.TarifDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TarifDetailsRepository extends JpaRepository<TarifDetails, Integer> {

    @Query("SELECT t FROM TarifDetails t WHERE t.idTrajet = :idTrajet")
    List<TarifDetails> findByIdTrajet(@Param("idTrajet") Integer idTrajet);
}