<%-- 
    Document   : login
    Created on : Sep 3, 2017, 11:58:35 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Entrar - DigitalCare</title>
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
                <c:choose>
                    <c:when test="${(param.status == 'cadastro-ok')}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <strong>Cadastro efetuado!</strong> Faça o login para continuar
                        </div>
                    </c:when>
                    <c:when test="${(param.status == 'cadastro-erro')}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <strong>Ops! Ocorreu um erro...</strong> Verifique seus dados e cadastre novamente
                        </div>
                    </c:when>
                    <c:when test="${(param.status == 'login-erro')}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <strong>Ops!</strong> Email ou senha inválido(s)
                        </div>
                    </c:when>
                </c:choose>
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Realizar Login</h2>
                </div>
                <form action="${pageContext.request.contextPath}/LoginServlet?action=login" method="POST">
                    <fieldset>
                        <label for="email">E-mail:</label>
                        <input type="email" id="email" name="login" placeholder="jose@email.com">
                        <label for="password">Senha:</label>
                        <input type="password" id="password" name="senha" placeholder="password">
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