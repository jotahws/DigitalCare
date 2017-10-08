<%-- 
    Document   : medicos
    Created on : Sep 20, 2017, 7:43:50 PM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Medicos - DigitalCare</title>
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
                        <div class="row">
                            <div class="col-md-8">
                                <h1>Lista de Médicos</h1>
                            </div>
                            <div class="col-md-4 text-right">
                                <a href="${pageContext.request.contextPath}/ListaMedicoServlet?action=listaRegisterMedico" class="btn btn-lg btn-digital-green">
                                    <i class="fa fa-fw fa-plus"></i>Adicionar Novo Médico
                                </a>
                            </div>
                        </div>
                        <hr>
                        <div style="" class="table-striped " id="resumo-dia"></div>
                        <div class="row">

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
