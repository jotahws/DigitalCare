<%-- 
    Document   : perfil-paciente
    Created on : Sep 20, 2017, 8:11:27 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
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
                <div class="container marketing">
                    <div class="row featurette">
                        <div class="col-md-7">
                            <h1 class="featurette-heading">Paciente - Perfil </h1>
                        </div>
                    </div>
                    <hr class="featurette-divider">
                </div>
                <%@include file="/includes/footer.jsp" %>
            </c:otherwise>
        </c:choose>
    </body>
</html>
