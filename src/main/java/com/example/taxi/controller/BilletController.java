package com.example.taxi.controller;

import com.example.taxi.model.*;
import com.example.taxi.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/billet")
public class BilletController {

    @Autowired
    private BilletService billetService;

    @Autowired
    private VoyageService voyageService;

    @Autowired
    private TrajetService trajetService;

    @Autowired
    private ClientService clientService;

    @GetMapping("/list")
    public String listBillets(HttpSession session, Model model,
                             @RequestParam(required = false) Integer idTrajet,
                             @RequestParam(required = false) Integer idVehicule,
                             @RequestParam(required = false) String date) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        List<Billet> billets = billetService.getAllBillets();

        // Filter by trajet if provided
        if (idTrajet != null) {
            billets = billets.stream()
                    .filter(b -> b.getVoyage() != null && idTrajet.equals(b.getVoyage().getTrajet().getIdTrajet()))
                    .collect(Collectors.toList());
        }

        // Filter by vehicule if provided
        if (idVehicule != null) {
            billets = billets.stream()
                    .filter(b -> b.getVoyage() != null && idVehicule.equals(b.getVoyage().getVehicule().getIdVehicule()))
                    .collect(Collectors.toList());
        }

        // Filter by date if provided
        if (date != null && !date.isEmpty()) {
            billets = billets.stream()
                    .filter(b -> {
                        if (b.getVoyage() == null || b.getVoyage().getDateDepart() == null) {
                            return false;
                        }
                        try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            Date filterDate = sdf.parse(date);
                            Date voyageDate = b.getVoyage().getDateDepart();
                            // Compare dates (ignoring time)
                            SimpleDateFormat dateOnly = new SimpleDateFormat("yyyy-MM-dd");
                            return dateOnly.format(filterDate).equals(dateOnly.format(voyageDate));
                        } catch (Exception e) {
                            return true; // If parsing fails, include the billet
                        }
                    })
                    .collect(Collectors.toList());
        }

        // Calculate total revenue for filtered results
        BigDecimal totalRevenue = billets.stream()
                .map(Billet::getMontantTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("billets", billets);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("trajets", trajetService.getAllTrajets());
        model.addAttribute("vehicules", voyageService.getAllVoyages().stream()
                .map(Voyage::getVehicule)
                .distinct()
                .collect(Collectors.toList()));
        model.addAttribute("pageTitle", "Liste des Billets");
        model.addAttribute("contentPage", "/WEB-INF/jsp/billet/list.jsp");
        return "includes/layout";
    }
}