<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - TaxiHub</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Global Styles -->
    <jsp:include page="/WEB-INF/jsp/includes/global-styles.jsp" />
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7fafc;
        }

        .layout-wrapper {
            display: flex;
            min-height: 100vh;
        }

        .layout-content {
            flex: 1;
            margin-left: 250px;
        }

        /* Header Styles */
        .header {
            background: white;
            padding: 20px 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e2e8f0;
        }

        .header-title {
            font-size: 24px;
            font-weight: 700;
            color: #1f2937;
        }

        .header-right {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .header-user {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #4299e1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        .header-user-name {
            color: #2d3748;
            font-weight: 600;
            font-size: 14px;
        }

        /* Main Content Styles */
        .main-content {
            padding: 30px;
        }

        .content-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            min-height: calc(100vh - 180px);
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 10px;
        }

        .page-subtitle {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 30px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .layout-content {
                margin-left: 0;
            }

            .header {
                padding: 15px;
            }

            .header-title {
                font-size: 18px;
            }

            .main-content {
                padding: 15px;
            }

            .content-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="layout-wrapper">
        <!-- Sidebar -->
        <jsp:include page="/WEB-INF/jsp/includes/sidebar.jsp" />

        <!-- Main Content Area -->
        <div class="layout-content">
            <!-- Header -->
            <div class="header">
                <h1 class="header-title">${pageTitle}</h1>
                <div class="header-right">
                    <div class="header-user">
                        <div class="header-user-avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.adminNom}">
                                    <c:out value="${sessionScope.adminNom.charAt(0)}"/>
                                </c:when>
                                <c:otherwise>A</c:otherwise>
                            </c:choose>
                        </div>
                        <div>
                            <div class="header-user-name">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.adminNom}">
                                        <c:out value="${sessionScope.adminNom}"/>
                                    </c:when>
                                    <c:otherwise>Administrateur</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Page Content -->
            <div class="main-content">
                <div class="content-card">
                    <jsp:include page="${contentPage}" />
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
