<%-- 
    Document   : cadastroPaciente
    Created on : Sep 3, 2017, 5:04:03 PM
    Author     : JotaWind
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div class="col-md-2"></div>
            <div  class="panel-default col-md-8 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Novo Cadastro</h2>   
                </div>
                <form action="${pageContext.request.contextPath}/PacienteServlet?action=register" method="POST">
                    <fieldset>
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" placeholder="João">
                        <label for="sobrenome">Sobrenome:</label>
                        <input type="text" id="sobrenome" name="sobrenome" placeholder="da Silva">
                        <label for="cpf">CPF:</label>
                        <input type="text" id="cpf" name="cpf" placeholder="">
                        <label for="dtnsc">Data de Nascimento:</label>
                        <input type="text" id="dtnsc" name="dtnsc" placeholder="">
                        <label for="sexo">Sexo:</label>
                        <select id="sexo" name="sexo" class="custom-select">
                            <option value="Masculino">Masculino</option>
                            <option value="Feminino">Feminino</option>
                        </select><br>
                        <label for="tel1">Telefone 1:</label>
                        <input type="text" id="tel1" name="tel1" placeholder="">
                        <label for="tel2">Telefone 2:</label>
                        <input type="text" id="tel2" name="tel2" placeholder="">
                        <label for="email">E-mail:</label>
                        <input type="email" id="email" name="email" placeholder="pedro@email.com">
                        <label for="pssw">Senha:</label>
                        <input type="password" id="pssw" name="pssw" placeholder="senha123">
                        <label for="pssw2">Confirmar Senha:</label>
                        <input type="password" id="pssw2" name="pssw2" placeholder="senha123">
                        <label for="cep">CEP:</label>
                        <input type="text" id="cep" name="cep" placeholder="">
                        <label for="rua">Rua:</label>
                        <input type="text" id="rua" name="rua" placeholder="">
                        <label for="numero">Numero:</label>
                        <input type="text" id="numero" name="numero" placeholder="">
                        <label for="compl">Complemento:</label>
                        <input type="text" id="compl" name="compl" placeholder="">
                        <label for="bairro">Bairro:</label>
                        <input type="text" id="bairro" name="bairro" placeholder="">
                        <label for="estado">Estado:</label>
                        <select id="estado" name="estado" class="custom-select">
                            <c:forEach var="item" items="${estados}">
                                <option value="${item.id}">
                                    <c:out value="${item.nome}"/>
                                </option>
                            </c:forEach>                       
                        </select>
                        <label  for="cidade">Cidade:</label>
                        <select id="cidade" name="cidade" class="custom-select">
                            <option value="1">1</option>
                        </select>
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
