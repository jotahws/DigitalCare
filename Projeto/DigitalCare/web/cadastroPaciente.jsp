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
            <div class="col-md-4"></div>
            <div  class="panel-default col-md-4 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Novo Cadastro</h2>   
                </div>
                <form action="#" method="POST">
                    <fieldset>
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" placeholder="João">
                        <label for="sobrenome">Sobrenome:</label>
                        <input type="text" id="sobrenome" placeholder="da Silva">
                        <label for="cpf">CPF:</label>
                        <input type="text" id="cpf" placeholder="">
                        <label for="dtnsc">Data de Nascimento:</label>
                        <input type="text" id="dtnsc" placeholder="">
                        <label for="sexo">Sexo:</label>
                        <select class="custom-select">
                            <option value="Masculino">Masculino</option>
                            <option value="Feminino">Feminino</option>
                        </select><br>
                        <label for="tel1">Telefone 1:</label>
                        <input type="text" id="tel1" placeholder="">
                        <label for="tel2">Telefone 2:</label>
                        <input type="text" id="tel2" placeholder="">
                        <label for="email">E-mail:</label>
                        <input type="email" id="email" placeholder="pedro@email.com">
                        <label for="password">Senha:</label>
                        <input type="password" id="password" placeholder="senha123">
                        <label for="password">Confirmar Senha:</label>
                        <input type="password" id="password" placeholder="senha123">
                        <label for="cep">CEP:</label>
                        <input type="text" id="cep" placeholder="">
                        <label for="">Rua:</label>
                        <input type="text" id="" placeholder="">
                        <label for="">Numero:</label>
                        <input type="text" id="" placeholder="">
                        <label for="">Complemento:</label>
                        <input type="text" id="" placeholder="">
                        <label for="">Bairro:</label>
                        <input type="text" id="" placeholder="">
                        <label for="">Estado:</label>
                        <select class="custom-select">
                            <c:forEach var="item" items="${estados}">
                                <option value="${item.id}">
                                    <c:out value="${item.nome}"/>
                                </option>
                            </c:forEach>                       
                        </select>
                        <label for="custom-select">Cidade:</label>
                        <select class="custom-select">

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
