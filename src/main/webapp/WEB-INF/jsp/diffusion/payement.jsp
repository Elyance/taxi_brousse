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
                    <h3 class="card-title">Ajouter un Paiement</h3>
                    <div class="card-tools">
                        <a href="<c:url value='/diffusion/payments'/>" class="btn btn-info btn-sm">
                            <i class="fas fa-list"></i> Liste des Paiements
                        </a>
                        <a href="<c:url value='/diffusion/list'/>" class="btn btn-secondary btn-sm">
                            <i class="fas fa-arrow-left"></i> Retour
                        </a>
                    </div>
                </div>

                <div class="card-body">
                    <form method="POST" action="<c:url value='/diffusion/payement'/>" class="form">
                        <div class="form-group">
                            <label for="commande">Commande Diffusion</label>
                            <select class="form-control" id="commande" name="commandeDiffusion.idCommandeDiffusion" required>
                                <option value="">Sélectionner une commande</option>
                                <c:forEach var="commande" items="${commandes}">
                                    <option value="${commande.idCommandeDiffusion}" ${selectedCommande != null && selectedCommande.idCommandeDiffusion == commande.idCommandeDiffusion ? 'selected' : ''}>${commande.societe.libelle} - ${commande.montantTotal} Ar</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="montant">Montant</label>
                            <input type="number" step="0.01" class="form-control" id="montant" name="montant" required>
                        </div>
                        <div class="form-group">
                            <label for="datePayement">Date de Paiement</label>
                            <input type="datetime-local" class="form-control" id="datePayement" name="datePayement" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Ajouter</button>
                        <a href="<c:url value='/diffusion/list'/>" class="btn btn-secondary">Annuler</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>