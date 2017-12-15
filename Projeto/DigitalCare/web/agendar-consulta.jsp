<%-- 
    Document   : agendar-consulta
    Created on : Sep 20, 2017, 7:45:08 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Agendar Consulta - DigitalCare</title>
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
                        <h1>Agendar Consulta</h1>
                        <hr>
                        <div class="container ">
                            <form action="${pageContext.request.contextPath}/ConsultaServlet?action=ClinicaBuscaConsultas" method="POST">
                                <div class="card ">
                                    <div class="card-header text-center">
                                        Digite os dados para pesquisar a consulta
                                    </div>
                                    <div class="card-body">
                                        <div class="col-md-12 row">
                                            <div class="form-group col-md-4">
                                                <label for="tipoConsulta" class="col-form-label">Tipo da consulta<span style="color:red;">*</span></label>
                                                <div class="" >
                                                    <input id="tipoConsulta" name="tipoConsulta" type='text' placeholder='Tipo da consulta'class='form-control' required>
                                                    
                                                    <datalist id="tiposConsulta">
                                                    </datalist>
                                                    <small style="color:red;">Obrigatório</small>
                                                </div>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="paciente" class=" col-form-label">CPF do Paciente<span style="color:red;">*</span></label>
                                                <div class="" >
                                                    <input id="cpf" type='text' class='form-control cpf ' required name='paciente'>
                                                    <small style="color:red;">Obrigatório</small>
                                                </div>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="data" class="col-form-label">Data preferecial</label>
                                                <div class="">
                                                    <input type="text" name="data" class="data form-control" id="data" >
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer text-center">
                                        <button type="submit" class="btn btn-digital-green">
                                            <i class="fa fa-fw fa-search"></i> Pesquisar Consultas
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <hr class="invisible-divider">
                        <div class="row">
                            <table id="tabela" class="table">
                                <thead class="thead-inverse">
                                    <tr>
                                        <th>Endereço</th>
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
                                                <a id="detalhe" class="clickable btn btn-outline-secondary ">Detalhes</a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <!--<input id="tipoConsulta"
                name="tipoConsulta"
                type='text'
                placeholder='Tipo da consulta'
                class='flexdatalist form-control'
                data-min-length='0'
                list='tiposConsulta'
                data-selection-required='true'
                required>-->
                <script src="js/dash.js"></script>
                <script>
                    $(document).ready(function () {
                        listaNovaConsulta();
                        $('#tipoConsulta').flexdatalist({
                            minLength: 0,
                            noResultsText: 'Sem resultados para "{keyword}"',
                            multiple: false,
                            focusFirstResult: true,
                            selectionRequired: true,
                            textProperty: '{nome}',
                            visibleProperties: ['nome'],
                            searchIn: ['nome'],
                            valueProperty: 'id',
                            data: ''
                        });
                        function listaNovaConsulta() {
                            $.ajax({
                                url: 'ConsultaServlet',
                                type: 'GET',
                                dataType: 'json',
                                data: {
                                    action: 'ListaTiposConsulta'
                                },
                                success: function (result) {
                                    $('#tipoConsulta').flexdatalist('data', result);
                                }
                            });
                        }
                    });
                </script>

            </c:otherwise>
        </c:choose>
    </body>
</html>
