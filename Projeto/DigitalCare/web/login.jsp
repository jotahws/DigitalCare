<%-- 
    Document   : login
    Created on : Sep 3, 2017, 11:58:35 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Entrar - DigitalCare</title>
    </head>
    <body class="login">
        <%@include file="/includes/header.jsp" %>

        <div class="row">
            <div class="col-md-4"></div>
            <div  class="panel-default col-md-4 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Realizar Login</h2>   
                </div>
                <form action="#" method="POST">
                    <fieldset>
                        <label for="email">E-mail:</label>
                        <input type="email" id="email" placeholder="jose@email.com">
                        <label for="password">Senha:</label>
                        <input type="password" id="password" placeholder="password">
                        <input type="submit" value="Entrar" class="btn btn-digital-green">
                        <div class="text-right">
                            <a href="${pageContext.request.contextPath}/cadastroPaciente.jsp">Novo por aqui?</a>
                        </div>
                    </fieldset>
                </form>
            </div>
            <div class="col-md-4"></div>
        </div>
    </body>
</html>