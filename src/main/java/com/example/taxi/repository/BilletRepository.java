package com.example.taxi.repository;

import com.example.taxi.model.Billet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface BilletRepository extends JpaRepository<Billet, Integer> {

}
