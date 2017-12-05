<%-- 
    Document   : dashboardClinica
    Created on : Sep 20, 2017, 3:33:36 PM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Dashboard - DigitalCare</title>
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
                        <h1>Dashboard</h1>
                        <hr>
                        <div class="row dash-row">
                            <h2 class="mb-0 mt-0">Resumo de hoje</h2>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="data-box data-box-sm bg-warning-light ">
                                    <h2>
                                        <c:set var="isNull" value="true"/>
                                        <c:forEach items="${statusConsultas}" var="status">
                                            <c:if test="${status[0] == 'Em espera'}">
                                                ${status[1]}
                                                <c:set var="isNull" value="false"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${isNull == 'true'}">
                                            0
                                        </c:if>
                                    </h2>
                                    <p>Paciente(s) na sala de espera</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="data-box data-box-sm bg-blue-light">
                                    <h2>
                                        <c:set var="isNull" value="true"/>
                                        <c:forEach items="${statusConsultas}" var="status">
                                            <c:if test="${status[0] == 'Marcado'}">
                                                ${status[1]}
                                                <c:set var="isNull" value="false"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${isNull == 'true'}">
                                            0
                                        </c:if>
                                    </h2>
                                    <p>Paciente(s) agendado(s) para hoje</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="data-box data-box-sm bg-danger-light">
                                    <h2>
                                        <c:set var="isNull" value="true"/>
                                        <c:forEach items="${statusConsultas}" var="status">
                                            <c:if test="${status[0] == 'Cancelado'}">
                                                ${status[1]}
                                                <c:set var="isNull" value="false"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${isNull == 'true'}">
                                            0
                                        </c:if>
                                    </h2>
                                    <p>Paciente(s) cancelado(s) para hoje</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="data-box data-box-sm data-box-light">
                                    <h2>
                                        <c:set var="isNull" value="true"/>
                                        <c:forEach items="${statusConsultas}" var="status">
                                            <c:if test="${status[0] == 'Concluído'}">
                                                ${status[1]}
                                                <c:set var="isNull" value="false"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${isNull == 'true'}">
                                            0
                                        </c:if>
                                    </h2>
                                    <p>Paciente(s) concluído(s) hoje</p>
                                </div>
                            </div>
                        </div>

                        <hr>
                        <div class="row dash-row">
                            <h2>Consultas em andamento</h2>
                            <div class="col-md-12">
                                <div class="tabela-dash">
                                    <c:choose>
                                        <c:when test="${consultasAtuais.size() > 0}">
                                            <table id="dataTableAndamento" class="dataTable table">
                                                <thead class="thead-inverse">
                                                    <tr>
                                                        <th>Médico</th>
                                                        <th>Paciente</th>
                                                        <th>Horário da consulta</th>
                                                        <th>Matriz</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${consultasAtuais}" var="consulta">
                                                        <tr>
                                                            <td>Dr. ${consulta.medico.nome} ${consulta.medico.sobrenome}</td>
                                                            <td>${consulta.paciente.nome} ${consulta.paciente.sobrenome}</td>
                                                            <td><fmt:formatDate pattern = "HH:mm" value = "${consulta.dataHora}"/></td>
                                                            <td>${consulta.clinicaEndereco.nome}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-secondary" role="alert">
                                                <h4 class="text-muted">&nbsp;&nbsp;&nbsp;&nbsp;Não há consultas em andamento.</h4>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="row dash-row">
                            <h2>Próximos pacientes</h2>
                            <div class="col-md-12">
                                <div class="tabela-dash">
                                    <c:choose>
                                        <c:when test="${proximasConsultas.size() > 0}">
                                            <table id="dataTableProximos" class="dataTable table">
                                                <thead class="thead-inverse">
                                                    <tr>
                                                        <th>Médico</th>
                                                        <th>Paciente</th>
                                                        <th>Horário da consulta</th>
                                                        <th>Status da consulta</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${proximasConsultas}" var="consulta">
                                                        <tr>
                                                            <td>Dr. ${consulta.medico.nome} ${consulta.medico.sobrenome}</td>
                                                            <td>${consulta.paciente.nome} ${consulta.paciente.sobrenome}</td>
                                                            <td><fmt:formatDate pattern = "HH:mm" value = "${consulta.dataHora}"/></td>
                                                            <td>${consulta.status}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-secondary" role="alert">
                                                <h4 class="text-muted">&nbsp;&nbsp;&nbsp;&nbsp;Não há próximas consultas.</h4>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    $(document).ready(function () {
                        $('.dataTable').DataTable({
                            "paging": false,
                            "searching": false,
                            "info": false
                        });
                    });
                </script>
            </c:otherwise>
        </c:choose>
    </body>
</html>
