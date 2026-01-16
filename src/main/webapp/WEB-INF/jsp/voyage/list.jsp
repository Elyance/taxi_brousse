<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="list-header">
    <h2 class="list-title"><i class="fas fa-bus"></i> Gestion des Voyages</h2>
    <div class="list-actions">
        <button class="btn-primary" onclick="window.location.href='<c:url value='/voyages/create'/>'">
            <i class="fas fa-plus"></i> Ajouter un Voyage
        </button>
    </div>
</div>

<div class="filter-section">
    <div class="filter-section-title">
        <i class="fas fa-filter"></i> Filtres
    </div>
    <form method="get" action="<c:url value='/voyages'/>" class="filter-form">
        <div class="filter-group">
            <div class="filter-item">
                <label class="filter-label">Trajet</label>
                <select name="idTrajet" class="filter-select">
                    <option value="">Tous les trajets</option>
                    <c:forEach items="${trajets}" var="trajet">
                        <option value="${trajet.idTrajet}" <c:if test="${param.idTrajet == trajet.idTrajet}">selected</c:if>>
                            ${trajet.gareDepart.nom} → ${trajet.gareArrivee.nom}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="filter-item">
                <label class="filter-label">Date</label>
                <input type="date" name="date" class="filter-input" value="${param.date}">
            </div>
        </div>
        <div class="filter-actions">
            <button type="submit" class="btn-filter">
                <i class="fas fa-search"></i> Filtrer
            </button>
            <a href="<c:url value='/voyages'/>" class="btn-reset" style="text-decoration: none; display: inline-flex; align-items: center;">
                <i class="fas fa-redo"></i> Réinitialiser
            </a>
        </div>
    </form>
</div>

<c:choose>
    <c:when test="${empty voyages}">
        <div class="empty-state">
            <div class="empty-state-icon"><i class="fas fa-inbox"></i></div>
            <div class="empty-state-title">Aucun voyage trouvé</div>
            <div class="empty-state-text">Aucun voyage ne correspond à vos critères de recherche.</div>
            <button class="btn-primary" onclick="window.location.href='<c:url value='/voyages/create'/>'">
                <i class="fas fa-plus"></i> Ajouter un Voyage
            </button>
        </div>
    </c:when>
    <c:otherwise>
        <div style="overflow-x: auto;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Trajet</th>
                        <th>Date</th>
                        <th>Chauffeur</th>
                        <th>Véhicule</th>
                        <th>Prix (Fr)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${voyages}" var="voyage">
                        <tr>
                            <td>
                                <strong>${voyage.gareDepart}</strong>
                                <i class="fas fa-arrow-right" style="margin: 0 8px; color: #9ca3af;"></i>
                                <strong>${voyage.gareArrivee}</strong>
                            </td>
                            <td><fmt:formatDate value="${voyage.dateDepart}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>${voyage.chauffeurNom} ${voyage.chauffeurPrenom}</td>
                            <td>${voyage.immatriculation} (${voyage.vehiculeModele})</td>
                            <td style="text-align: right; font-weight: 700; color: #059669;">
                                ${voyage.tarifPrix} Fr
                            </td>
                            <td>
                                <div class="table-actions">
                                    <a href="<c:url value='/voyages/${voyage.idVoyage}/details'/>" class="btn-action" style="background-color: #6b7280; color: white; text-decoration: none; display: inline-flex; align-items: center; padding: 6px 12px; border-radius: 4px; font-size: 13px; gap: 6px; transition: all 0.3s ease; margin-right: 8px;">
                                        <i class="fas fa-eye"></i> Détails
                                    </a>
                                    <a href="<c:url value='/voyages/${voyage.idVoyage}/details'/>" class="btn-action" style="background-color: #3b82f6; color: white; text-decoration: none; display: inline-flex; align-items: center; padding: 6px 12px; border-radius: 4px; font-size: 13px; gap: 6px; transition: all 0.3s ease;">
                                        <i class="fas fa-chair"></i> Acheter Billet
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <p style="text-align: center; color: #6b7280; font-size: 13px; margin-top: 15px;">
            Affichage de <strong>${voyages.size()}</strong> voyage(s)
        </p>
    </c:otherwise>
</c:choose>