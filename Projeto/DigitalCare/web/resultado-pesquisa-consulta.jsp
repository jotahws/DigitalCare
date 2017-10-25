<%-- 
    Document   : resultado-pesquisa-consulta
    Created on : Oct 11, 2017, 8:00:25 PM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta - DigitalCare</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/carousel.css">
        <%@include file="/includes/head.jsp" %>
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionLogin.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil != 1)}">
                <div class="container" style="margin-top: 50px">
                    <%@include file="/includes/header.jsp" %>
                    <h1>Acesso Negado.</h1>
                    <h2>Apenas pacientes podem acessar essa página</h2>
                </div>
            </c:when>
            <c:otherwise>
                <%@include file="/includes/header.jsp" %>
                <div class="container paciente">
                    <div class="row">
                        <div class="col-md-12">
                            <h1>Consultas de ~Cardiologia~</h1>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="container ">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="filtro-lateral">
                                <div class="text-center">
                                    <h6>Filtrar resultados</h6><hr>
                                </div>
                                <div>
                                    <form>
                                        <div class="row">
                                            <div id="checks" class="form-group col-md-12">
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        Apenas meu plano de saúde
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        Consultas particulares
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        Apeas minha cidade
                                                    </label>
                                                </div><hr>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        Clínica 1
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        Clínica 2
                                                    </label>
                                                </div><hr class="invisible-divider">
                                                <div class="form-check">
                                                    <button type="submit" class="form-control btn btn-digital-green">
                                                        <i class="fa fa-fw fa-filter "></i> Filtrar
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link link-digital-green active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">02/07/2017</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link link-digital-green " id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">03/07/2017</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link link-digital-green " id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">04/07/2017</a>
                                </li>
                            </ul>
                            <div class="tab-content" id="myTabContent">
                                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                    <table id="tabela" class="table table-sm">
                                        <thead class="thead-default">
                                            <tr>
                                                <th>Clínica</th>
                                                <th>Data</th>
                                                <th>Doutor</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>DADO</td>
                                                <td>03/06/2017 13:30</td>
                                                <td>DADO</td>
                                                <td>
                                                    <div class="col-md-12 text-right">
                                                        <a id="detalhe" class="clickable btn btn-sm btn-outline-secondary ">Detalhes</a>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>DADO</td>
                                                <td>03/06/2017 13:30</td>
                                                <td>DADO</td>
                                                <td>
                                                    <div class="col-md-12 text-right">
                                                        <a id="detalhe" class="clickable btn btn-sm btn-outline-secondary ">Detalhes</a>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>DADO</td>
                                                <td>03/06/2017 13:30</td>
                                                <td>DADO</td>
                                                <td>
                                                    <div class="col-md-12 text-right">
                                                        <a id="detalhe" class="clickable btn btn-sm btn-outline-secondary ">Detalhes</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">...</div>
                                <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">...</div>
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="/includes/footer.jsp" %>
            </c:otherwise>
        </c:choose>
    </body>
    <script>
        $(document).ready(function () {
            $('#detalhe').click(function () {
                swal({
                    title: 'Cardiologia',
                    html: '<div class="left-text"><br><h3 class="left-text">Consulta</h3>' +
                            '<p>Status: Confirmado</p>' +
                            '<p>Horário: </p>' +
                            '<p>Duração prevista: 30 min</p>' +
                            '<p><b>Local: Clínica Lucano</b></p>' +
                            '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d10095.611312493658!2d-49.28693809014179!3d-25.45570653704176!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x4eb0012a30701491!2sCl%C3%ADnica+Lucano!5e0!3m2!1spt-BR!2sbr!4v1506433178013" width="500" height="250" frameborder="0" style="border:0" allowfullscreen="false"></iframe>' +
                            '<br><br><a href="#" class="btn btn-digital-green">Marcar Consulta</a>',
                    showCloseButton: true,
                    showConfirmButton: false,
                    width: 600,
                    padding: 50
                });
            });
        });
    </script>
</html>
