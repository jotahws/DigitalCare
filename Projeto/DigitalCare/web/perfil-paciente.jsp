<%-- 
    Document   : perfil-paciente
    Created on : Sep 20, 2017, 8:11:27 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil - DigitalCare</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/carousel.css">
        <%@include file="/includes/head.jsp" %>
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionLogin.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil != 1)}">
                <div class="container" style="margin-top: 50px">
                    <%@include file="/includes/header.jsp" %>
                    <h1>Acesso Negado.</h1>
                    <h2>Apenas pacientes podem acessar essa página</h2>
                </div>
            </c:when>
            <c:otherwise>
                <%@include file="/includes/header.jsp" %>
                <div class="container paciente">
                    <div class="row">
                        <div class="col-md-7">
                            <h1 class="">Seu Perfil</h1>
                        </div>
                        <div class="col-md-5 text-right">
                            <a href="configuracoes-paciente.jsp" class="btn btn-dark ">Editar Perfil</a>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="container ">
                    <div class="row">
                        <legend class="dados">Dados</legend>
                        <jsp:useBean id="pacienteEdita" class="beans.PacienteUsuario"/>
                        <c:set var="item" value="${paciente}"/>

                        <p class="col-md-12 dados">Nome:  <c:out value="${item.paciente.nome}"/> </p>                                            
                        <p class="col-md-4 dados">CPF: <strong>Algum dado</strong> </p>
                        <p class="col-md-4 dados">Data de Nascimento: <strong>13/05/1997</strong> </p>
                        <p class="col-md-4 dados">Sexo: <strong>Algum dado</strong> </p>
                        <p class="col-md-4 dados">Email: <strong>Algum dado</strong> </p>
                        <p class="col-md-4 dados">Telefone 1: <strong><c:out value="${item.telefone}"/></strong> </p>
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
                <%@include file="/includes/footer.jsp" %>
            </c:otherwise>
        </c:choose>
    </body>
</html>
