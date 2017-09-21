<%-- 
    Document   : dashboardClinica
    Created on : Sep 20, 2017, 3:33:36 PM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Dashboard - DigitalCare</title>
        <%@include file="/includes/head.jsp" %>
        <!-- Style customizado -->
        <link href="${pageContext.request.contextPath}/stylesheet/dash.css" rel="stylesheet">
    </head>

    <body class="fixed-nav sticky-footer" id="page-top">
        <c:choose>
            <c:when test="${sessionLogin.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil != 3)}">
                <div class="content-wrapper">
                    <div class="container">
                        <%@include file="/includes/header.jsp" %>
                        <h1>Acesso Negado.</h1>
                        <h2>Apenas Clínicas podem acessar a essa página</h2>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Navigation -->
                <%@include file="/includes/headerDash.jsp" %>
                <div class="content-wrapper">
                    <div class="container-fluid">
                        <h1>Dashboard Clínica</h1>
                        <hr>
                        <div style="" class="table-striped " id="resumo-dia"></div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="data-box data-box-dark">
                                    <h2>10</h2>
                                    <p>Texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto </p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="data-box data-box-light">
                                    <h2>10</h2>
                                    <p>Texto texto texto texto texto texto texto texto texto </p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="data-box data-box-dark">
                                    <h2>10</h2>
                                    <p>Texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto </p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="data-box data-box-light">
                                    <h2>10</h2>
                                    <p>Texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
            </c:otherwise>
        </c:choose>
    </body>
</html>
