<%-- 
    Document   : cadastroClinica
    Created on : Sep 3, 2017, 5:43:50 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Cadastrar Clínica - DigitalCare</title>
    </head>
    <body class="login">
        <c:choose>
            <c:when test="${sessionLogin.email != null}">
                <c:redirect url="/index.jsp"/>
            </c:when>
        </c:choose>
        <%@include file="/includes/header.jsp" %>
        <div class="row">
            <div class="col-md-4"></div>
            <div  class="panel-default col-md-4 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Novo Cadastro de Clínica</h2>   
                </div>
                <form action="#" method="POST">
                    <fieldset>
                        <label for="nome">Nome da Clínica:</label>
                        <input type="text" id="nome" placeholder="Clínica Dom Pedro">
                        <label for="">Texto:</label>
                        <input type="text" id="" placeholder="text">
                        <label for="">Texto:</label>
                        <input type="text" id="" placeholder="text">
                        <label for="">Texto:</label>
                        <input type="text" id="" placeholder="text">
                        <label for="">Texto:</label>
                        <input type="text" id="" placeholder="text">
                        <label for="password">Senha:</label>
                        <input type="password" id="password" placeholder="senha123">
                        <input type="submit" value="Cadastrar" class="btn btn-digital-green">
                        <div class="text-right">
                            <a href="${pageContext.request.contextPath}/cadastroPaciente.jsp">É uma pessoa física?</a>
                        </div>
                    </fieldset>
                </form>
            </div>
            <div class="col-md-4"></div>
        </div>
    </body>
</html>
