package com.example.taxi.controller;

import com.example.taxi.model.Voyage;
import com.example.taxi.model.VoyageDetails;
import com.example.taxi.model.Trajet;
import com.example.taxi.model.TarifDetails;
import com.example.taxi.service.TarifService;
import com.example.taxi.service.VoyageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.stream.Collectors;
import java.text.SimpleDateFormat;
import java.util.Date;

import java.util.List;

@Controller
@RequestMapping("/voyages")
public class VoyageController {

    @Autowired
    private VoyageService voyageService;

    @Autowired
    private TarifService tarifService;

    @GetMapping("")
    public String voyages(HttpSession session, Model model,
                         @RequestParam(required = false) Integer idTrajet,
                         @RequestParam(required = false) String date) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }
        List<VoyageDetails> voyages = voyageService.getAllVoyageDetails();

        // Filter by trajet if provided
        if (idTrajet != null) {
            voyages = voyages.stream()
                    .filter(v -> idTrajet.equals(v.getIdTrajet()))
                    .collect(Collectors.toList());
        }

        // Filter by date if provided
        if (date != null && !date.isEmpty()) {
            voyages = voyages.stream()
                    .filter(v -> {
                        try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            Date filterDate = sdf.parse(date);
                            Date voyageDate = v.getDateDepart();
                            // Compare dates (ignoring time)
                            SimpleDateFormat dateOnly = new SimpleDateFormat("yyyy-MM-dd");
                            return dateOnly.format(filterDate).equals(dateOnly.format(voyageDate));
                        } catch (Exception e) {
                            return true; // If parsing fails, include the voyage
                        }
                    })
                    .collect(Collectors.toList());
        }

        model.addAttribute("voyages", voyages);
        model.addAttribute("trajets", voyageService.getAllTrajets());
        model.addAttribute("pageTitle", "Liste des Voyages");
        model.addAttribute("contentPage", "/WEB-INF/jsp/voyage/list.jsp");
        return "includes/layout";
    }

    @GetMapping("/{id}/details")
    public String voyageDetails(@PathVariable Integer id, HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }
        Voyage voyage = voyageService.getVoyageById(id).orElse(null);
        if (voyage == null) {
            return "redirect:/voyages";
        }
        List<TarifDetails> tarifs = tarifService.getTarifsByTrajet(voyage.getTrajet().getIdTrajet());
        model.addAttribute("voyage", voyage);
        model.addAttribute("tarifs", tarifs);
        model.addAttribute("pageTitle", "Détails du Voyage");
        model.addAttribute("contentPage", "/WEB-INF/jsp/voyage/details.jsp");
        return "includes/layout";
    }
}