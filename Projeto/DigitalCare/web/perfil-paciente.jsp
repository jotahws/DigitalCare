<%-- 
    Document   : perfil-paciente
    Created on : Sep 20, 2017, 8:11:27 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <%@include file="/includes/head.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Pacientes - DigitalCare</title>

        <!-- Style customizado -->
        <link href="${pageContext.request.contextPath}/stylesheet/dash.css" rel="stylesheet">
    </head>

    <body class="fixed-nav sticky-footer" id="page-top">
        <c:choose>
            <c:when test="${sessionLogin.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil != 2)}">
                <div class="content-wrapper">
                    <div class="container">
                        <%@include file="/includes/header.jsp" %>
                        <h1>Acesso Negado.</h1>
                        <h2>Apenas médicos podem acessar essa página</h2>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Navigation -->
                <%@include file="/includes/headerDash.jsp" %>

                <div class="content-wrapper">
                    <div class="container-fluid">
                        <div class="row container">
                            <jsp:useBean id="pacientePerfil" class="beans.PacienteUsuario"/>
                            <div class="col-md-7">
                                <h1 class="col-md-12"><strong>Paciente: </strong>${perfilPaciente.paciente.nome}</h1>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="container">
                                <div class="row">
                                    <legend class="dados">Dados</legend>
                                    <p class="col-md-12 dados">Nome:<strong> ${perfilPaciente.paciente.nome}  ${perfilPaciente.paciente.sobrenome}</strong></p>                                            
                                    <p class="col-md-4 dados">CPF: <strong>${perfilPaciente.paciente.cpf}</strong> </p>
                                    <p class="col-md-4 dados">Data de Nascimento: <strong>${perfilPaciente.paciente.dataNascimento}</strong> </p>
                                    <p class="col-md-4 dados">Sexo: <strong>${perfilPaciente.paciente.sexo}</strong> </p>
                                    <p class="col-md-4 dados">Email: <strong>${perfilPaciente.login.email}</strong> </p>
                                    <p class="col-md-4 dados">Telefone 1: <strong>${perfilPaciente.telefone}</strong> </p>
                                    <p class="col-md-4 dados">Telefone 2: <strong>${perfilPaciente.telefone2}</strong> </p>
                                    <legend class="dados"><hr>Dados Médicos</legend>
                                    <c:forEach var="item" items="${listConveniosPac}">
                                        <p class="col-md-4 dados">Plano de Saúde: <strong>${item.convenio.nome}</strong> </p>
                                        <p class="col-md-4 dados">Validade: <strong>${item.validade}</strong> </p>
                                        <p class="col-md-4 dados">Número: <strong>${item.numero}</strong> </p>
                                    </c:forEach>
                                    <legend class="dados"><hr>Endereço</legend>
                                    <p class="col-md-12 dados">CEP: <strong>${perfilPaciente.endereco.cep}</strong> </p>
                                    <p class="col-md-4 dados">Rua: <strong>${perfilPaciente.endereco.rua}</strong> </p>
                                    <p class="col-md-4 dados">Número: <strong>${perfilPaciente.endereco.numero}</strong> </p>
                                    <p class="col-md-4 dados">Complemento: <strong>${perfilPaciente.endereco.complemento}o</strong> </p>
                                    <p class="col-md-4 dados">Bairro: <strong>${perfilPaciente.endereco.bairro}</strong> </p>
                                    <p class="col-md-4 dados">Cidade: <strong>${perfilPaciente.endereco.cidade.nome}</strong> </p>
                                    <p class="col-md-4 dados">Estado: <strong>${perfilPaciente.endereco.cidade.estado.uf}</strong> </p>
                                </div>
                            </div>
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






