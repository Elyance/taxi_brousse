package com.example.taxi.controller;

import com.example.taxi.model.*;
import com.example.taxi.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Collectors;
import java.util.stream.Collectors;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/voyages")
public class VoyageController {

    @Autowired
    private VoyageService voyageService;

    @Autowired
    private TarifService tarifService;

    @Autowired
    private ClientService clientService;

    @Autowired
    private TrajetService trajetService;

    @Autowired
    private VoyageDetailsService voyageDetailsService;

    @Autowired
    private BilletService billetService;

    @GetMapping("")
    public String voyages(HttpSession session, Model model,
                         @RequestParam(required = false) Integer idTrajet,
                         @RequestParam(required = false) String date) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }
        List<VoyageDetails> voyages = voyageDetailsService.getAllVoyageDetails();

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
        model.addAttribute("trajets", trajetService.getAllTrajets());
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

    @GetMapping("/{id}/places")
    public String voyagePlaces(@PathVariable Integer id, HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }
        Voyage voyage = voyageService.getVoyageById(id).orElse(null);
        if (voyage == null) {
            return "redirect:/voyages";
        }
        List<Place> places = voyageService.getPlacesForVoyage(id);
        List<Client> clients = clientService.getAllClients();
        List<CategorieClient> categories = clientService.getAllCategories();
        List<Tarif> tarifs = voyageService.getTarifsForTrajet(voyage.getTrajet());

        // Créer les tarifs avec prix par défaut (pour client sans catégorie spécifique)
        List<TarifWithClientPrice> tarifsWithPrices = tarifs.stream()
                .map(tarif -> new TarifWithClientPrice(tarif, tarif.getPrix()))
                .toList();

        model.addAttribute("voyage", voyage);
        model.addAttribute("places", places);
        model.addAttribute("clients", clients);
        model.addAttribute("categories", categories);
        model.addAttribute("tarifs", tarifs);
        model.addAttribute("pageTitle", "Sélection des Places");
        model.addAttribute("contentPage", "/WEB-INF/jsp/voyage/places.jsp");
        return "includes/layout";
    }

    @GetMapping("/{id}/tarifs")
    @ResponseBody
    public List<TarifWithClientPrice> getTarifsForClient(@PathVariable Integer id,
                                                         @RequestParam(required = false) Integer idClient,
                                                         @RequestParam(required = false) Integer idCategorieClient) {
        Voyage voyage = voyageService.getVoyageById(id).orElse(null);
        if (voyage == null) {
            return List.of();
        }

        List<Tarif> tarifs = voyageService.getTarifsForTrajet(voyage.getTrajet());
        CategorieClient categorieClient = null;

        // Déterminer la catégorie du client
        if (idClient != null) {
            // Client existant
            Client client = clientService.getAllClients().stream()
                    .filter(c -> c.getIdClient().equals(idClient))
                    .findFirst().orElse(null);
            if (client != null) {
                categorieClient = client.getCategorieClient();
            }
        } else if (idCategorieClient != null) {
            // Nouveau client avec catégorie sélectionnée
            categorieClient = clientService.getAllCategories().stream()
                    .filter(c -> c.getIdCategorieClient().equals(idCategorieClient))
                    .findFirst().orElse(null);
        }

        // Calculer les prix selon la catégorie
        final CategorieClient finalCategorieClient = categorieClient;
        return tarifs.stream()
                .map(tarif -> {
                    BigDecimal prix = voyageService.getPrixForClient(tarif, finalCategorieClient);
                    return new TarifWithClientPrice(tarif, prix);
                })
                .toList();
    }

    @PostMapping("/{id}/book")
    public String bookTicket(@PathVariable Integer id, HttpSession session, Model model,
                             @RequestParam(required = false) Integer idClient,
                             @RequestParam(required = false) String nomComplet,
                             @RequestParam(required = false) String telephone,
                             @RequestParam(required = false) Integer idCategorieClient,
                             @RequestParam("selectedPlaces") Integer[] selectedPlaces,
                             @RequestParam String clientType) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }
//verifier si le client est nouveau ou existant 
        Client client;
        if ("new".equals(clientType)) {
            client = new Client();
            client.setNomComplet(nomComplet);
            client.setTelephone(telephone);
            if (idCategorieClient != null) {
                CategorieClient categorie = clientService.getAllCategories().stream()
                        .filter(c -> c.getIdCategorieClient().equals(idCategorieClient))
                        .findFirst().orElse(null);
                client.setCategorieClient(categorie);
            }
            client = clientService.saveClient(client);
        } else {
            client = clientService.getAllClients().stream()
                    .filter(c -> c.getIdClient().equals(idClient))
                    .findFirst().orElse(null);
            if (client == null) {
                return "redirect:/voyages/" + id + "/places";
            }
        }

        // Créer les billets pour chaque place sélectionnée
        Voyage voyage = voyageService.getVoyageById(id).orElse(null);
        if (voyage == null) {
            return "redirect:/voyages";
        }

        BigDecimal totalAmount = BigDecimal.ZERO;
        int bookedPlaces = 0;

        for (Integer placeId : selectedPlaces) {
            Place place = voyageService.getPlacesForVoyage(id).stream()
                    .filter(p -> p.getIdPlace().equals(placeId))
                    .findFirst().orElse(null);

            if (place != null && !place.isReserved()) {
                Billet billet = new Billet();
                billet.setClient(client);
                billet.setVoyage(voyage);
                billet.setPlace(place);

                // Calculer le prix pour cette place et ce client
                BigDecimal prix = voyageService.getPrixForPlaceAndClientAvecRemise(
                    voyage.getTrajet(),
                    place.getCategoriePlace(),
                    client.getCategorieClient()
                );
                billet.setMontantTotal(prix);
                totalAmount = totalAmount.add(prix);

                // Sauvegarder le billet
                billetService.saveBillet(billet);

                // Mettre à jour le statut de la place à "Reservee"
                voyageService.reserverPlace(placeId);

                bookedPlaces++;
            }
        }

        // TODO: Create reservation/billet logic here
        // For now, just redirect with success
        session.setAttribute("successMessage", "Réservation effectuée avec succès pour " + bookedPlaces + " place(s)! Montant total: " + totalAmount + " Ar");
        return "redirect:/voyages/" + id + "/details";
    }

}