<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        ${sessionScope.successMessage}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Liste des Billets</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#filterModal">
                            <i class="fas fa-filter"></i> Filtres
                        </button>
                    </div>
                </div>
                <div class="card-body">

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="billet-stat-card">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-ticket-alt"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Total Billets</div>
                                        <div class="billet-stat-value">${billets.size()}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="billet-stat-card billet-stat-success">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Chiffre d'Affaires</div>
                                        <div class="billet-stat-value">
                                            <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="billet-stat-card billet-stat-info">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-route"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Trajets</div>
                                        <div class="billet-stat-value">${trajets.size()}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="billet-stat-card">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-bus"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Véhicules</div>
                                        <div class="billet-stat-value">${vehicules.size()}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Billets Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Code Billet</th>
                                    <th>Client</th>
                                    <th>Voyage</th>
                                    <th>Trajet</th>
                                    <th>Véhicule</th>
                                    <th>Place</th>
                                    <th>Date Départ</th>
                                    <th>Montant</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="billet" items="${billets}">
                                    <tr>
                                        <td>
                                            <span class="badge badge-primary">${billet.codeBillet}</span>
                                        </td>
                                        <td>
                                            <strong>${billet.client.nomComplet}</strong><br>
                                            <small class="text-muted">${billet.client.telephone}</small>
                                            <c:if test="${not empty billet.client.categorieClient}">
                                                <br><span class="badge badge-info">${billet.client.categorieClient.libelle}</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            Voyage #${billet.voyage.idVoyage}
                                        </td>
                                        <td>
                                            ${billet.voyage.trajet.gareDepart.ville.libelle} →
                                            ${billet.voyage.trajet.gareArrivee.ville.libelle}
                                        </td>
                                        <td>
                                            ${billet.voyage.vehicule.immatriculation}<br>
                                            <small class="text-muted">${billet.voyage.vehicule.vehiculeModele.modele}</small>
                                        </td>
                                        <td>
                                            <span class="badge badge-secondary">${billet.place.numeroPlace}</span>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${billet.voyage.dateDepart}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <strong><fmt:formatNumber value="${billet.montantTotal}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty billets}">
                                    <tr>
                                        <td colspan="8" class="text-center text-muted">
                                            <i class="fas fa-info-circle"></i> Aucun billet trouvé
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Filter Modal -->
<div class="modal fade" id="filterModal" tabindex="-1" role="dialog" aria-labelledby="filterModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="filterModalLabel">Filtrer les Billets</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="GET" action="<c:url value='/billet/list'/>">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="idTrajet">Trajet</label>
                        <select class="form-control" id="idTrajet" name="idTrajet">
                            <option value="">Tous les trajets</option>
                            <c:forEach var="trajet" items="${trajets}">
                                <option value="${trajet.idTrajet}" ${param.idTrajet == trajet.idTrajet ? 'selected' : ''}>
                                    ${trajet.gareDepart.ville.libelle} → ${trajet.gareArrivee.ville.libelle}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="idVehicule">Véhicule</label>
                        <select class="form-control" id="idVehicule" name="idVehicule">
                            <option value="">Tous les véhicules</option>
                            <c:forEach var="vehicule" items="${vehicules}">
                                <option value="${vehicule.idVehicule}" ${param.idVehicule == vehicule.idVehicule ? 'selected' : ''}>
                                    ${vehicule.immatriculation} - ${vehicule.vehiculeModele.modele}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="date">Date</label>
                        <input type="date" class="form-control" id="date" name="date" value="${param.date}">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Appliquer les filtres</button>
                </div>
            </form>
        </div>
    </div>
</div>