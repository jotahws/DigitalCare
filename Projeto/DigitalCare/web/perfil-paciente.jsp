<%-- 
    Document   : perfil-paciente
    Created on : Sep 20, 2017, 8:11:27 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <%@include file="/includes/head.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Pacientes - DigitalCare</title>

        <!-- Style customizado -->
        <link href="${pageContext.request.contextPath}/stylesheet/dash.css" rel="stylesheet">
    </head>

    <body class="fixed-nav sticky-footer" id="page-top">
        <c:choose>
            <c:when test="${sessionLogin.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil != 2)}">
                <div class="content-wrapper">
                    <div class="container">
                        <%@include file="/includes/header.jsp" %>
                        <h1>Acesso Negado.</h1>
                        <h2>Apenas médicos podem acessar essa página</h2>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Navigation -->
                <%@include file="/includes/headerDash.jsp" %>

                <div class="content-wrapper">
                    <div class="container-fluid">
                        <div class="row container">
                            <div class="col-md-7">
                                <h1 class="col-md-12">Perfil de ~paciente~</h1>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="container">
                                <div class="row">
                                    <legend class="dados">Dados</legend>
                                    <p class="col-md-12 dados">Nome: ${paciente.nome} </p>                                            
                                    <p class="col-md-4 dados">CPF: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Data de Nascimento: <strong>13/05/1997</strong> </p>
                                    <p class="col-md-4 dados">Sexo: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Email: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Telefone 1: <strong>${paciente.telefone}</strong> </p>
                                    <p class="col-md-4 dados">Telefone 2: <strong>Algum dado</strong> </p>
                                    <legend class="dados"><hr>Dados Médicos</legend>
                                    <p class="col-md-4 dados">Plano de Saúde: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Tipo sanguíneo: <strong>Algum dado</strong> </p>
                                    <legend class="dados"><hr>Endereço</legend>
                                    <p class="col-md-12 dados">CEP: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Rua: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Número: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Complemento: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Bairro: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Cidade: <strong>Algum dado</strong> </p>
                                    <p class="col-md-4 dados">Estado: <strong>Algum dado</strong> </p>
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






