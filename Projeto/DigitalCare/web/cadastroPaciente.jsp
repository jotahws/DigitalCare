<%-- 
    Document   : cadastroPaciente
    Created on : Sep 3, 2017, 5:04:03 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Cadastrar - DigitalCare</title>
    </head>
    <body class="login">
        <%@include file="/includes/header.jsp" %>
        <div class="row">
            <div class="col-md-4"></div>
            <div  class="panel-default col-md-4 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Novo Cadastro</h2>   
                </div>
                <form action="#" method="POST">
                    <fieldset>
                        <label for="password">Nome:</label>
                        <input type="text" id="password" placeholder="Dom Pedro">
                        <label for="email">E-mail:</label>
                        <input type="email" id="email" placeholder="pedro@email.com">
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
                            <a href="${pageContext.request.contextPath}/cadastroClinica.jsp">Deseja cadastrar sua clínica?</a>
                        </div>
                    </fieldset>
                </form>
            </div>
            <div class="col-md-4"></div>
        </div>
    </body>
</html>
