<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${param.success == '1'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Succès!</strong> Réservation effectuée avec succès.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>

<div class="page-title">Détails du Voyage #${voyage.idVoyage}</div>
<p class="page-subtitle">Informations complètes et tarifs des places</p>

<div class="row">
    <!-- Informations du voyage -->
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Informations du Voyage</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h6><i class="fas fa-route"></i> Trajet</h6>
                        <p class="mb-3">
                            <strong>${voyage.trajet.gareDepart.nom} (${voyage.trajet.gareDepart.ville.libelle})</strong><br>
                            <i class="fas fa-arrow-down text-muted mx-3"></i><br>
                            <strong>${voyage.trajet.gareArrivee.nom} (${voyage.trajet.gareArrivee.ville.libelle})</strong>
                        </p>

                        <h6><i class="fas fa-clock"></i> Date & Heure</h6>
                        <p class="mb-3">
                            <fmt:formatDate value="${voyage.dateDepart}" pattern="dd/MM/yyyy 'à' HH:mm"/>
                        </p>

                        <h6><i class="fas fa-road"></i> Distance</h6>
                        <p class="mb-3">${voyage.trajet.distanceKm} km</p>
                    </div>
                    <div class="col-md-6">
                        <h6><i class="fas fa-id-card"></i> Chauffeur</h6>
                        <p class="mb-3">
                            ${voyage.chauffeur.nom} ${voyage.chauffeur.prenom}<br>
                            <small class="text-muted">${voyage.chauffeur.telephone}</small>
                        </p>

                        <h6><i class="fas fa-car"></i> Véhicule</h6>
                        <p class="mb-3">
                            ${voyage.vehicule.vehiculeModele.modele}<br>
                            <small class="text-muted">Immatriculation: ${voyage.vehicule.immatriculation}</small>
                        </p>

                        <h6><i class="fas fa-info-circle"></i> Statut</h6>
                        <p class="mb-3">
                            <span class="badge bg-${voyage.voyageStatut.libelle == 'Actif' ? 'success' : voyage.voyageStatut.libelle == 'Annulé' ? 'danger' : 'secondary'}">
                                ${voyage.voyageStatut.libelle}
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tarifs -->
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Tarifs des Places</h5>
            </div>
            <div class="card-body">
                <c:forEach var="tarif" items="${tarifs}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span>${tarif.categoriePlace}</span>
                        <strong class="text-primary">${tarif.prix} €</strong>
                    </div>
                </c:forEach>
                <c:if test="${empty tarifs}">
                    <p class="text-muted mb-0">Aucun tarif défini pour ce trajet.</p>
                </c:if>
            </div>
        </div>

        <!-- Bouton Acheter Billet -->
        <div class="card mt-3">
            <div class="card-body text-center">
                <a href="<c:url value='/voyages/${voyage.idVoyage}/places'/>" class="btn btn-success btn-lg w-100">
                    <i class="fas fa-ticket-alt"></i> Acheter un Billet
                </a>
            </div>
        </div>
    </div>
</div>

<div class="row mt-3">
    <div class="col-12">
        <a href="<c:url value='/voyages'/>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Retour à la liste
        </a>
    </div>
</div>