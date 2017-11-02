<%-- 
    Document   : dashboardClinica
    Created on : Sep 20, 2017, 3:33:36 PM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                                    <p>Paciente(s) em espera</p>
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
                                    <p>Paciente(s) marcado(s)</p>
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
                                    <p>Paciente(s) cancelado(s)</p>
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
                                    <p>Paciente(s) concluído(s)</p>
                                </div>
                            </div>
                        </div>

                        <hr>
                        <div class="row dash-row">
                            <h2>Consultas em andamento</h2>
                            <div class="col-md-12">
                                <table class="table">
                                    <thead class="thead-inverse">
                                        <tr>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>Username</th>
                                        </tr>
                                    </thead>
                                </table>
                                <div class="tabela-dash">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td>Mark</td>
                                                <td>Otto</td>
                                                <td>@mdo</td>
                                            </tr>
                                            <tr>
                                                <td>Jacob</td>
                                                <td>Thornton</td>
                                                <td>@fat</td>
                                            </tr>
                                            <tr>
                                                <td>Larry</td>
                                                <td>the Bird</td>
                                                <td>@twitter</td>
                                            </tr>
                                            <tr>
                                                <td>Mark</td>
                                                <td>Otto</td>
                                                <td>@mdo</td>
                                            </tr>
                                            <tr>
                                                <td>Jacob</td>
                                                <td>Thornton</td>
                                                <td>@fat</td>
                                            </tr>
                                            <tr>
                                                <td>Larry</td>
                                                <td>the Bird</td>
                                                <td>@twitter</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row dash-row">
                            <h2>Próximos pacientes</h2>
                            <div class="col-md-12">
                                <table class="table">
                                    <thead class="thead-inverse">
                                        <tr>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>Username</th>
                                        </tr>
                                    </thead>
                                </table>
                                <div class="tabela-dash">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td>Mark</td>
                                                <td>Otto</td>
                                                <td>@mdo</td>
                                            </tr>
                                            <tr>
                                                <td>Jacob</td>
                                                <td>Thornton</td>
                                                <td>@fat</td>
                                            </tr>
                                            <tr>
                                                <td>Larry</td>
                                                <td>the Bird</td>
                                                <td>@twitter</td>
                                            </tr>
                                            <tr>
                                                <td>Mark</td>
                                                <td>Otto</td>
                                                <td>@mdo</td>
                                            </tr>
                                            <tr>
                                                <td>Jacob</td>
                                                <td>Thornton</td>
                                                <td>@fat</td>
                                            </tr>
                                            <tr>
                                                <td>Larry</td>
                                                <td>the Bird</td>
                                                <td>@twitter</td>
                                            </tr>
                                            <tr>
                                                <td>Mark</td>
                                                <td>Otto</td>
                                                <td>@mdo</td>
                                            </tr>
                                            <tr>
                                                <td>Jacob</td>
                                                <td>Thornton</td>
                                                <td>@fat</td>
                                            </tr>
                                            <tr>
                                                <td>Larry</td>
                                                <td>the Bird</td>
                                                <td>@twitter</td>
                                            </tr>
                                        </tbody>
                                    </table>
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
