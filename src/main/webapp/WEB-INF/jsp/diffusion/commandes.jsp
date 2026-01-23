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
                    <h3 class="card-title">Liste des Commandes de Diffusion</h3>
                    <div class="card-tools">
                        <a href="<c:url value='/diffusion/payement'/>" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus"></i> Ajouter un Paiement
                        </a>
                        <a href="<c:url value='/diffusion/list'/>" class="btn btn-secondary btn-sm">
                            <i class="fas fa-list"></i> Liste des Diffusions
                        </a>
                    </div>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Société</th>
                                    <th>Nb Totale de Diffusion</th>
                                    <th>Montant Total</th>
                                    <th>Reste à Payer</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="commande" items="${commandes}">
                                    <tr>
                                        <td>${commande.societe.libelle}</td>
                                        <td>${nbDiffusionMap[commande.idCommandeDiffusion]}</td>
                                        <td>
                                            <strong><fmt:formatNumber value="${montantTotalMap[commande.idCommandeDiffusion]}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                        <td>
                                            <strong><fmt:formatNumber value="${resteMap[commande.idCommandeDiffusion]}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                        <td>
                                            <a href="<c:url value='/diffusion/commande/${commande.idCommandeDiffusion}'/>" class="btn btn-info btn-sm">
                                                <i class="fas fa-eye"></i> Détails
                                            </a>
                                            <a href="<c:url value='/diffusion/payement?commandeId=${commande.idCommandeDiffusion}'/>" class="btn btn-success btn-sm">
                                                <i class="fas fa-money-bill-wave"></i> Payer
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty commandes}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted">
                                            <i class="fas fa-info-circle"></i> Aucune commande trouvée
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