<%-- 
    Document   : medicos
    Created on : Sep 20, 2017, 7:43:50 PM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Medicos - DigitalCare</title>
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
                        <div class="row">
                            <div class="col-md-8">
                                <h1>Lista de Médicos</h1>
                            </div>
                            <div class="col-md-4 text-right">
                                <a href="${pageContext.request.contextPath}/vincular-medico.jsp" class="btn btn-lg btn-digital-green">
                                    <i class="fa fa-fw fa-plus"></i>Adicionar Novo Médico
                                </a>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="container ">
                                <c:choose>
                                    <c:when test="${(param.status == 'desvincular-error')}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <strong>Ops! </strong> Ocorreu um erro ao desvincular o médico. Tente novamente.
                                        </div>
                                    </c:when>
                                    <c:when test="${(param.status == 'desvincular-ok')}">
                                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <strong>O médico foi desvinculado com sucesso!</strong> 
                                        </div>
                                    </c:when>
                                    <c:when test="${(param.status == 'vincula-erro')}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <strong>Ops! </strong> Ocorreu um erro ao adicionar o médico. Tente novamente.
                                        </div>
                                    </c:when>
                                    <c:when test="${(param.status == 'vincula-ok')}">
                                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <strong>O médico foi adicionado com sucesso!</strong> 
                                        </div>
                                    </c:when>
                                </c:choose> 
                                <c:forEach items="${listaEndClinica}" var="endereco">

                                    <div id="accordionLista" role="tablist">
                                        <div class="card">
                                            <div class="card-header" role="tab" id="TituloEnd${endereco.id}">
                                                <h5 class="mb-0">
                                                    <a class="collapsed link-digital-green" data-toggle="collapse" href="#collapse${endereco.id}" aria-expanded="false" aria-controls="collapse${endereco.id}">
                                                        ${endereco.nome}
                                                    </a>
                                                </h5>
                                            </div>
                                            <div id="collapse${endereco.id}" class="collapse  <c:if test="${listaEndClinica.get(0).id == endereco.id}">show</c:if>" role="tabpanel" aria-labelledby="TituloEnd${endereco.id}" data-parent="#accordion">
                                                <div class="card-body">
                                                    <h4 class="card-title">${endereco.endereco.rua}, ${endereco.endereco.numero} - ${endereco.endereco.bairro}, ${endereco.endereco.cidade.nome} (${endereco.endereco.cidade.estado.uf})</h4>
                                                    <table id="dataTable" class="dataTable table">
                                                        <thead class="thead-inverse">
                                                            <tr>
                                                                <th>Nome</th>
                                                                <th>CRM</th>
                                                                <th>Data de Nascimento</th>
                                                                <th>Telefone</th>
                                                                <th>E-mail</th>
                                                                <th></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="item" items="${listaMedicos}">
                                                                <c:if test="${endereco.id == item.listaClinicaEndereco.get(0).id}">
                                                                    <tr>
                                                                        <td>${item.nome} ${item.sobrenome}</td>
                                                                        <td>${item.numeroCrm} (${item.estadoCrm.uf})</td>
                                                                        <td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${item.dataNascimento}"/></td>
                                                                        <td>
                                                                            <c:if test="${item.telefone1 != null}">
                                                                                <c:set var="tel" value="${item.telefone1}"/>
                                                                                <c:out value="(${fn:substring(tel, 0, 2)})${fn:substring(tel, 2, 7)}-${fn:substring(tel, 7, fn:length(tel))}"/>
                                                                            </c:if>
                                                                        </td>
                                                                        <td>${item.login.email}</td>
                                                                        <td>
                                                                            <div class="col-md-12">
                                                                                <a href="${pageContext.request.contextPath}/ListaMedicoServlet?action=verPerfilMedico&id=${item.login.id}&clinicaEndereco=${item.listaClinicaEndereco.get(0).id}"
                                                                                   class="btn btn-outline-primary">Perfil</a>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </c:if>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr class="invisible-divider">
                                </c:forEach>

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










