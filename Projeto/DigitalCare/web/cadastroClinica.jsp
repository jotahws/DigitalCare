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
            <div class="col-md-3"></div>
            <div  class="panel-default col-md-6 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Novo Cadastro de Clínica</h2>   
                </div>
                <form action="${pageContext.request.contextPath}/ClinicaServlet?action=register" method="POST">
                    <fieldset>
                        <div class="form-row">
                            <legend>Sobre sua Empresa</legend>
                            <div class="form-group col-md-6">
                                <label for="nomeFantasia">Nome fantasia:</label>
                                <input type="text" id="nomeFantasia" name="nomeFantasia" placeholder="Clínica" class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="razaoSocial">Razão social:</label>
                                <input type="text" id="razaoSocial" name="razaoSocial" placeholder="Clínica LTDA" class="required">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="cnpj">CNPJ:</label>
                                <input type="text" id="cnpj" name="cnpj" placeholder="" class="cnpj required">
                            </div>
                            <div class="form-group col-md-7">
                                <label for="site">Site:</label>
                                <input type="text" id="site" class="required" name="site" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="tel1">Telefone 1:</label>
                                <input type="text" id="tel1" class="telresidencial required" name="tel1" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="tel2">Telefone 2:</label>
                                <input type="text" id="tel2" class="telresidencial" name="tel2" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="email">E-mail:</label>
                                <input type="email" id="email" name="email" placeholder="clinica@email.com" class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="senha">Senha:</label>
                                <input type="password" id="senha" name="senha" placeholder="senha123" class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="senha2">Confirmar Senha:</label>
                                <input type="password" id="senha2" name="senha2" placeholder="senha123" class="required">
                            </div>
                            <legend>Endereço</legend>
                            <div class="form-group col-md-4">
                                <label for="cep">CEP: <a href="http://www.buscacep.correios.com.br/sistemas/buscacep/" target="_blank"><i class="fa fa-fw fa-question-circle-o"></i></a></label>
                                <input type="text" id="cep" name="cep" placeholder="" class="required">
                            </div>
                            <div class="form-group col-md-8">
                                <label for="rua">Rua:</label>
                                <input type="text" id="rua" name="rua" placeholder="Rua das Flores" readonly="true">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="numero">Número:</label>
                                <input type="text" id="numero" name="numero" placeholder="2042" class="required">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="compl">Complemento:</label>
                                <input type="text" id="compl" name="compl" placeholder="ap 302 bloco 2">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="bairro">Bairro:</label>
                                <input type="text" id="bairro" name="bairro" placeholder="Batel" readonly="true">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="cidade">Cidade:</label>
                                <input type="text" id="cidade" name="cidade" placeholder="Curitiba" readonly="true">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="estado">Estado:</label>
                                <input type="text" id="estado" name="estado" placeholder="PR" readonly="true">
                            </div>
                            <div class="form-group col-md-12">
                                <input type="submit" value="Cadastrar" class="btn btn-digital-green">
                                <div class="text-right">
                                    <a href="${pageContext.request.contextPath}/cadastroPaciente.jsp">É uma pessoa física?</a>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
