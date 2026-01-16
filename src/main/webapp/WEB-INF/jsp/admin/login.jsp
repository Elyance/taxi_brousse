<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion Administrateur - TaxiHub</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-page-wrapper {
            width: 100%;
            height: 100vh;
            display: flex;
            overflow: hidden;
        }

        /* Section Gauche - Formulaire */
        .login-form-wrapper {
            flex: 1;
            background: #ffffff;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .login-form-wrapper::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: none;
            pointer-events: none;
        }

        .form-content {
            position: relative;
            z-index: 1;
            max-width: 450px;
            margin: 0 auto;
        }

        /* Logo et Nom Entreprise */
        .company-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 40px;
        }

        .company-logo {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #2d3748;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .company-name {
            font-size: 28px;
            font-weight: 800;
            color: #1f2937;
            letter-spacing: -0.5px;
        }

        .company-tagline {
            font-size: 14px;
            color: #6b7280;
            margin-top: -5px;
        }

        .login-form-title {
            font-size: 32px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 10px;
            margin-top: 20px;
        }

        .login-form-subtitle {
            font-size: 16px;
            color: #6b7280;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
            display: block;
            font-size: 14px;
        }

        .form-control {
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 15px;
            transition: all 0.2s ease;
            background-color: #fff;
            color: #1f2937;
        }

        .form-control:focus {
            border-color: #4b5563;
            box-shadow: 0 0 0 3px rgba(75, 85, 99, 0.1);
            outline: none;
            transform: none;
        }

        .form-control::placeholder {
            color: #9ca3af;
        }

        .btn-login {
            background: #2d3748;
            border: none;
            border-radius: 8px;
            padding: 14px 30px;
            font-weight: 600;
            font-size: 16px;
            color: white;
            width: 100%;
            transition: all 0.2s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
        }

        .btn-login:hover {
            background: #1f2937;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            color: white;
        }

        .btn-login:active {
            transform: translateY(-1px);
        }

        .forgot-password {
            text-align: center;
            margin-top: 20px;
        }

        .forgot-password a {
            color: #4b5563;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .forgot-password a:hover {
            color: #2d3748;
            text-decoration: underline;
        }

        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 20px;
            padding: 14px 16px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .alert-danger {
            background-color: #fef2f2;
            color: #7f1d1d;
            border-left: 4px solid #dc2626;
        }

        /* Section Droite - Image */
        .login-image-wrapper {
            flex: 1;
            position: relative;
            overflow: hidden;
            display: none;
        }

        .login-image-wrapper.show {
            display: flex;
        }

        .login-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .login-image-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(45, 55, 72, 0.3) 0%, rgba(75, 85, 99, 0.3) 100%);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .login-page-wrapper {
                height: auto;
            }

            .login-form-wrapper {
                padding: 40px 20px;
                min-height: 100vh;
            }

            .login-image-wrapper {
                display: none !important;
            }

            .login-form-title {
                font-size: 26px;
            }

            .company-header {
                margin-bottom: 30px;
            }
        }

        /* Animation d'entrée */
        .form-content {
            animation: slideInLeft 0.6s ease-out;
        }

        .login-image-wrapper {
            animation: slideInRight 0.6s ease-out;
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
    </style>
</head>
<body>
    <div class="login-page-wrapper">
        <!-- Section Formulaire (Gauche) -->
        <div class="login-form-wrapper">
            <div class="form-content">
                <!-- Header Entreprise -->
                <div class="company-header">
                    <div class="company-logo">
                        <i class="fas fa-taxi"></i>
                    </div>
                    <div>
                        <div class="company-name">TaxiHub</div>
                        <div class="company-tagline">Management Platform</div>
                    </div>
                </div>

                <h1 class="login-form-title">Bienvenue</h1>
                <p class="login-form-subtitle">Connectez-vous à votre compte administrateur</p>

                <!-- Message d'erreur -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong><i class="fas fa-exclamation-circle"></i> Erreur!</strong> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Formulaire de connexion -->
                <form action="<c:url value='login'/>" method="post" class="needs-validation" novalidate>
                    <div class="form-group">
                        <label for="nom" class="form-label"><i class="fas fa-user"></i> Nom d'utilisateur</label>
                        <input type="text"
                               class="form-control"
                               id="nom"
                               name="nom"
                               placeholder="Entrez votre nom d'utilisateur"
                               required
                               value="${param.nom}">
                    </div>

                    <div class="form-group">
                        <label for="mdp" class="form-label"><i class="fas fa-lock"></i> Mot de passe</label>
                        <input type="password"
                               class="form-control"
                               id="mdp"
                               name="mdp"
                               placeholder="Entrez votre mot de passe"
                               required>
                    </div>

                    <button type="submit" class="btn btn-login">
                        <i class="fas fa-sign-in-alt"></i> Se connecter
                    </button>
                </form>

                <div class="forgot-password">
                    <a href="#"><i class="fas fa-key"></i> Mot de passe oublié ?</a>
                </div>
            </div>
        </div>

        <!-- Section Image (Droite) -->
        <div class="login-image-wrapper show">
            <img src="/images/accueil.jpg" alt="Taxi Service" />
            <div class="login-image-overlay"></div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Validation du formulaire
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()

        // Animation au focus
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.01)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>