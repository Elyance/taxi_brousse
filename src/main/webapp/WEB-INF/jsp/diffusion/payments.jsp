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
                    <h3 class="card-title">Liste des Paiements de Diffusion</h3>
                    <div class="card-tools">
                        <a href="<c:url value='/diffusion/payement'/>" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus"></i> Ajouter un Paiement
                        </a>
                        <a href="<c:url value='/diffusion/list'/>" class="btn btn-secondary btn-sm">
                            <i class="fas fa-list"></i> Liste des Diffusions
                        </a>
                    </div>
                </div>

                <!-- Filter Form -->
                <div class="card-header border-0">
                    <form method="GET" action="<c:url value='/diffusion/payments'/>" class="form-inline">
                        <div class="row w-100">
                            <div class="col-md-3">
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
                            <div class="col-md-3">
                                <div class="form-group mb-2">
                                    <label for="dateDebut" class="sr-only">Date début</label>
                                    <input type="date" class="form-control form-control-sm" id="dateDebut" name="dateDebut" value="${param.dateDebut}">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group mb-2">
                                    <label for="dateFin" class="sr-only">Date fin</label>
                                    <input type="date" class="form-control form-control-sm" id="dateFin" name="dateFin" value="${param.dateFin}">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary btn-sm mr-2">
                                    <i class="fas fa-search"></i> Filtrer
                                </button>
                                <a href="<c:url value='/diffusion/payments'/>" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-times"></i> Réinitialiser
                                </a>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="card-body">
                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="billet-stat-card">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-receipt"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Nombre de Paiements</div>
                                        <div class="billet-stat-value">${payments.size()}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="billet-stat-card billet-stat-success">
                                <div class="billet-stat-content">
                                    <div class="billet-stat-icon">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <div class="billet-stat-info">
                                        <div class="billet-stat-label">Montant Total Payé</div>
                                        <div class="billet-stat-value">
                                            <c:set var="totalPaye" value="0"/>
                                            <c:forEach var="payment" items="${payments}">
                                                <c:set var="totalPaye" value="${totalPaye + payment.montant}"/>
                                            </c:forEach>
                                            <fmt:formatNumber value="${totalPaye}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payments Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID Paiement</th>
                                    <th>Société</th>
                                    <th>Montant</th>
                                    <th>Date de Paiement</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="payment" items="${payments}">
                                    <tr>
                                        <td>${payment.idPayement}</td>
                                        <td>${payment.commandeDiffusion.societe.libelle}</td>
                                        <td>
                                            <strong><fmt:formatNumber value="${payment.montant}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${payment.datePayement}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty payments}">
                                    <tr>
                                        <td colspan="4" class="text-center text-muted">
                                            <i class="fas fa-info-circle"></i> Aucun paiement trouvé
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