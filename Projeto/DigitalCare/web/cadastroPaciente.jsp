<%-- 
    Document   : cadastroPaciente
    Created on : Sep 3, 2017, 5:04:03 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Cadastrar - DigitalCare</title>
    </head>
    <body class="login">
        <c:choose>
            <c:when test="${sessionLogin.email != null}">
                <c:redirect url="/index.jsp"/>
            </c:when>
        </c:choose>
        <%@include file="/includes/header.jsp" %>
        <div class="row">
            <div class="col-md-2"></div>
            <div  class="panel-default col-md-8 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Novo Cadastro</h2>   
                </div>
                <form action="${pageContext.request.contextPath}/PacienteServlet?action=register" method="POST">
                    <fieldset>
                        <div class="form-row">
                            <legend>Sobre você</legend>
                            <div class="form-group col-md-6">
                                <label for="nome">Nome:</label>
                                <input type="text" id="nome" name="nome" placeholder="Pedro" class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="sobrenome">Sobrenome:</label>
                                <input type="text" id="sobrenome" name="sobrenome" placeholder="da Silva" class="required">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="cpf">CPF:</label>
                                <input type="text" id="cpf" name="cpf" placeholder="" class="required">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="dtnsc">Data de Nascimento:</label>
                                <input type="text" id="dtnsc" class="data required" name="dtnsc" placeholder="" class="required">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="sexo">Sexo:</label>
                                <select id="sexo" name="sexo" class="custom-select">
                                    <option value="M">Masculino</option>
                                    <option value="F">Feminino</option>
                                </select>
                            </div>
                            <legend>Seus Dados</legend>
                            <div class="form-group col-md-4">
                                <label for="tel1">Telefone 1:</label>
                                <input type="text" id="tel1" class="telefone required" name="tel1" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="tel2">Telefone 2:</label>
                                <input type="text" id="tel2" class="telefone" name="tel2" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="email">E-mail:</label>
                                <input type="email" id="email" name="email" placeholder="pedro@email.com" class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="pssw">Senha:</label>
                                <input type="password" id="pssw" name="pssw" placeholder="senha123" class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="pssw2">Confirmar Senha:</label>
                                <input type="password" id="pssw2" name="pssw2" placeholder="senha123" class="required">
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
                                <input type="text" id="bairro" name="bairro" placeholder="" readonly="true">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="cidade">Cidade:</label>
                                <input type="text" id="cidade" name="cidade" placeholder="" readonly="true">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="estado">Estado:</label>
                                <input type="text" id="estado" name="estado" placeholder="" readonly="true">
                            </div>
                            <!--<div class="form-group col-md-6">
                                <label for="estado">Estado:</label>
                                <select id="estado" name="estado" class="custom-select">
                                    <//c:forEach var="item" items="${estados}">
                                        <option value="${item.id}">
                                            <//c:out value="${item.nome}"/>
                                        </option>
                                    <//c:forEach>                       
                                </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label  for="cidade">Cidade:</label>
                                <select id="cidade" name="cidade" class="custom-select">
                                    <option value="1">1</option>
                                </select>
                            </div>-->
                            <div class="form-group col-md-12">
                                <input type="submit" value="Cadastrar" class="btn btn-digital-green">
                                <div class="text-right">
                                    <a href="${pageContext.request.contextPath}/cadastroClinica.jsp">Deseja cadastrar sua clínica?</a>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>

    </body>
</html>
