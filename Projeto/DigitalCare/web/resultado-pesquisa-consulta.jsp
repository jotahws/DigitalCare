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
                            <h1>Consultas de ~Dermatologia~</h1>
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
                            <table id="tabela" class="table">
                                <thead class="thead-inverse">
                                    <tr>
                                        <th >Clínica</th>
                                        <th >Data</th>
                                        <th>Doutor</th>
                                        <th>Cidade</th>
                                        <th>Plano de saúde</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>DADO</td>
                                        <td>03/06/2017</td>
                                        <td>DADO</td>
                                        <td>DADO</td>
                                        <td>DADO</td>
                                        <td>
                                            <div class="col-md-12">
                                                <a href="${pageContext.request.contextPath}/ListaMedicoServlet?action=verPerfilMedico&id=${item.login.id}" class="btn btn-outline-primary">Perfil</a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <%@include file="/includes/footer.jsp" %>
            </c:otherwise>
        </c:choose>
    </body>
</html>
