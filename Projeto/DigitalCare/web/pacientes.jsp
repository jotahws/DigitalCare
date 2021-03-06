<%-- 
    Document   : pacientes
    Created on : Sep 16, 2017, 10:46:13 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
                        <div class="row">
                            <h1 class="col-9">Pacientes</h1>
                        </div>
                        <hr>
                        <div class="container">
                            <table id="dataTablePaciente" class="dataTable table">
                                <thead class="thead-inverse">
                                    <tr>
                                        <th>Nome</th>
                                        <th>Data de Nascimento</th>
                                        <th>Email</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${listaPacientes}">
                                        <tr>
                                            <td>${item.paciente.nome} ${item.paciente.sobrenome}</td>
                                            <td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${item.paciente.dataNascimento}"/></td>
                                            <td>${item.login.email}</td>
                                            <td><a href="${pageContext.request.contextPath}/PacienteServlet?action=perfilPacienteMedico&id=${item.id}&idPac=${item.paciente.id}" class="btn btn-primary">Ver perfil</a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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