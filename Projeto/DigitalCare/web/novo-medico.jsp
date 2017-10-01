<%-- 
    Document   : novo-medico
    Created on : Sep 21, 2017, 10:28:49 AM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Novo Médico - DigitalCare</title>
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
                        <h1>Cadastrar um novo médico</h1>
                        <hr>
                        <div style="" class="table-striped " id="resumo-dia"></div>
                        <div class="container">
                            <form action="${pageContext.request.contextPath}/MedicoServlet?action=register" method="POST">
                                <fieldset>
                                    <div class="form-row">
                                        <legend>Dados do médico</legend>
                                        <div class="form-group col-md-4">
                                            <label for="nome">Nome:</label>
                                            <input type="text" id="nome" name="nome"class="required form-control">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="sobrenome">Sobrenome:</label>
                                            <input type="text" id="sobrenome" name="sobrenome" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="email">E-mail:</label>
                                            <input type="email" id="email" name="email" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="dtnsc">Data de Nascimento:</label>
                                            <input type="text" id="dtnsc" class="data required form-control" name="dtnsc" >
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="cpf">CPF:</label>
                                            <input type="text" id="cpf" name="cpf" class="cpf required form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="datanasc">CRM:</label>
                                            <input type="text" id="datanasc" name="datanasc" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label for="expedicao">Expedição</label>
                                            <jsp:useBean id="estado" class="beans.Estado"/>
                                            <c:set var="lista" value="${estados}"/>
                                            <select id="expedicao" name="expedicao" class="custom-select">
                                                <c:forEach var="item" items="${lista}">
                                                    <option value="<c:out value="${item.id}"/>"><c:out value="${item.uf}"/></option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="senha1">Senha:</label>
                                            <input type="password" id="pssw" name="senha1" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="senha2">Confirmar Senha:</label>
                                            <input type="password" id="pssw2" name="senha2" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-4 ">
                                            <label for="">&nbsp;</label>
                                            <div class="form-group col-md-6 ">
                                                <input type="submit" value="Cadastrar" class="btn btn-digital-green form-control">
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
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