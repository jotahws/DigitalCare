<%-- 
    Document   : nova-localizacao-clinica
    Created on : Oct 4, 2017, 10:23:07 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Novo Endereço - DigitalCare</title>
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
                        <h1>Novo endereço de clínica</h1>
                        <hr>
                        <div class="container">
                            <form action="${pageContext.request.contextPath}/ClinicaServlet?action=alter" method="POST">
                                <fieldset>
                                    <div class="form-row">
                                        <legend>Dados da sede:</legend>
                                        <div class="form-group col-md-4">
                                            <label for="tel1">Telefone 1:</label>
                                            <input type="text" id="tel1" class="telresidencial required form-control" name="tel1" placeholder="">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="tel2">Telefone 2:</label>
                                            <input type="text" id="tel2" class="telresidencial form-control" name="tel2" placeholder="">
                                        </div>
                                        <legend>Endereço:</legend>
                                        <div class="form-group col-md-4">
                                            <label for="cep">CEP: <a href="http://www.buscacep.correios.com.br/sistemas/buscacep/" target="_blank"><i class="fa fa-fw fa-question-circle-o"></i></a></label>
                                            <input type="text" id="cep" name="cep" placeholder="" class="required form-control" >
                                        </div>
                                        <div class="form-group col-md-8">
                                            <label for="rua">Rua:</label>
                                            <input type="text" id="rua" name="rua" readonly="true" class="locked form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="numero">Número:</label>
                                            <input type="text" id="numero" name="numero"  class="required form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="compl">Complemento:</label>
                                            <input type="text" id="compl" name="compl" class="form-control">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="bairro">Bairro:</label>
                                            <input type="text" id="bairro" name="bairro"  readonly="true" class="locked form-control">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="cidade">Cidade:</label>
                                            <input type="text" id="cidade" name="cidade" readonly="true" class="locked form-control">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="estado">Estado:</label>
                                            <input type="text" id="estado" name="estado" readonly="true" class="locked form-control">
                                        </div>
                                        <div class="form-group col-md-12 text-right">
                                            <input type="submit" id="VerificaDados" value="Salvar Alterações" class="btn btn-lg btn-digital-green ">
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
