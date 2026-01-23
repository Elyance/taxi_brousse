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
                    <h3 class="card-title">Liste des Diffusions</h3>
                    <div class="card-tools">
                        <a href="<c:url value='/diffusion/payement'/>" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus"></i> Ajouter un Paiement
                        </a>
                        <a href="<c:url value='/diffusion/payments'/>" class="btn btn-info btn-sm">
                            <i class="fas fa-list"></i> Liste des Paiements
                        </a>
                        <a href="<c:url value='/diffusion/commandes'/>" class="btn btn-warning btn-sm">
                            <i class="fas fa-shopping-cart"></i> Liste des Commandes
                        </a>
                    </div>
                </div>

                <!-- Filter Form -->
                <div class="card-header border-0">
                    <form method="GET" action="<c:url value='/diffusion/list'/>" class="form-inline">
                        <div class="row w-100">
                            <div class="col-md-2">
                                <div class="form-group mb-2">
                                    <label for="idSociete" class="sr-only">Société</label>
                                    <select class="form-control form-control-sm" id="idSociete" name="idSociete">
                                        <option value="">Toutes les sociétés</option>
                                        <c:forEach var="societe" items="${societes}">
                                            <option value="${societe.idSociete}" ${param.idSociete == societe.idSociete ? 'selected' : ''}>
                                                ${societe.libelle}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group mb-2">
                                    <label for="month" class="sr-only">Mois</label>
                                    <select class="form-control form-control-sm" id="month" name="month">
                                        <option value="">Tous les mois</option>
                                        <option value="1" ${param.month == '1' ? 'selected' : ''}>Janvier</option>
                                        <option value="2" ${param.month == '2' ? 'selected' : ''}>Février</option>
                                        <option value="3" ${param.month == '3' ? 'selected' : ''}>Mars</option>
                                        <option value="4" ${param.month == '4' ? 'selected' : ''}>Avril</option>
                                        <option value="5" ${param.month == '5' ? 'selected' : ''}>Mai</option>
                                        <option value="6" ${param.month == '6' ? 'selected' : ''}>Juin</option>
                                        <option value="7" ${param.month == '7' ? 'selected' : ''}>Juillet</option>
                                        <option value="8" ${param.month == '8' ? 'selected' : ''}>Août</option>
                                        <option value="9" ${param.month == '9' ? 'selected' : ''}>Septembre</option>
                                        <option value="10" ${param.month == '10' ? 'selected' : ''}>Octobre</option>
                                        <option value="11" ${param.month == '11' ? 'selected' : ''}>Novembre</option>
                                        <option value="12" ${param.month == '12' ? 'selected' : ''}>Décembre</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group mb-2">
                                    <label for="year" class="sr-only">Année</label>
                                    <input type="number" class="form-control form-control-sm" id="year" name="year" placeholder="Année" value="${param.year}">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group mb-2">
                                    <label for="idTrajet" class="sr-only">Trajet</label>
                                    <select class="form-control form-control-sm" id="idTrajet" name="idTrajet">
                                        <option value="">Tous les trajets</option>
                                        <c:forEach var="trajet" items="${trajets}">
                                            <option value="${trajet.idTrajet}" ${param.idTrajet == trajet.idTrajet ? 'selected' : ''}>
                                                ${trajet.gareDepart.ville.libelle} → ${trajet.gareArrivee.ville.libelle}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group mb-2">
                                    <label for="idVehicule" class="sr-only">Véhicule</label>
                                    <select class="form-control form-control-sm" id="idVehicule" name="idVehicule">
                                        <option value="">Tous les véhicules</option>
                                        <c:forEach var="vehicule" items="${vehicules}">
                                            <option value="${vehicule.idVehicule}" ${param.idVehicule == vehicule.idVehicule ? 'selected' : ''}>
                                                ${vehicule.immatriculation} - ${vehicule.vehiculeModele.modele}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary btn-sm mr-2">
                                    <i class="fas fa-search"></i> Filtrer
                                </button>
                                <a href="<c:url value='/diffusion/list'/>" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-times"></i> Réinitialiser
                                </a>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="card-body">

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <div class="billet-stat-card">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-building"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Total Sociétés</div>
                                        <div class="billet-stat-value">${summaries.size()}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="billet-stat-card billet-stat-primary">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-bullhorn"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Total Diffusions</div>
                                        <div class="billet-stat-value">${totalNbDiffusion}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="billet-stat-card billet-stat-success">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Chiffre d'Affaires Total</div>
                                        <div class="billet-stat-value">
                                            <fmt:formatNumber value="${totalCA}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Diffusions Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Société</th>
                                    <th>Prix Diffusion</th>
                                    <th>Nb Diffusion</th>
                                    <th>Chiffre d'Affaire</th>
                                    <th>Payé</th>
                                    <th>Reste à payer</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="summary" items="${summaries}">
                                    <tr>
                                        <td>${summary.societe.libelle}</td>
                                        <td>
                                            <strong><fmt:formatNumber value="${summary.prixDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                        <td>
                                            <span class="badge badge-primary">${summary.nbDiffusion}</span>
                                        </td>
                                        <td>
                                            <strong><fmt:formatNumber value="${summary.chiffreAffaire}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                        <td>
                                            <strong><fmt:formatNumber value="${summary.paye}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                        <td>
                                            <strong><fmt:formatNumber value="${summary.reste}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty summaries}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">
                                            <i class="fas fa-info-circle"></i> Aucune diffusion trouvée
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