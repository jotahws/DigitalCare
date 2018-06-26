<%-- 
    Document   : agendar-consulta
    Created on : Sep 20, 2017, 7:45:08 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
                            <c:choose>
                                <c:when test="${(param.status == 'semMedicos')}">
                                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Não há médicos para esse tipo de consulta.</strong>
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'erro-paciente')}">
                                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Não há nenhum paciente cadastrado com esse CPF.</strong>
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'consulta-marcada')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Sucesso!</strong> A consulta foi marcada.
                                    </div>
                                </c:when>
                            </c:choose>
                            <c:if test="${horarios == null}">
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
                                                        <input id="cpf" type='text' class='form-control cpf' required name='pacienteCPF'>
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
                                            <button id="pesquisarConsulta" type="submit" class="btn btn-digital-green">
                                                <i class="fa fa-fw fa-search"></i> Pesquisar Consultas
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </c:if>
                            <hr class="invisible-divider">
                            <c:if test="${horarios != null}">
                                <div class="row col-md-12 mb-3 justify-content-between">
                                    <h3>Paciente: ${paciente.nome} ${paciente.sobrenome}</h3>
                                    <a href="${pageContext.request.contextPath}/agendar-consulta.jsp" class="btn btn-secondary">
                                        <i class="fa fa-undo"></i> Pesquisar novamente
                                    </a>
                                </div>
                                <div class="row col-md-12">
                                    <ul class="nav nav-tabs w-100 nav-justified" id="myTab" role="tablist">
                                        <c:forEach begin="0" end="${horarios.size()-1}" var="i">
                                            <li class="nav-item">
                                                <a class="nav-link link-digital-green <c:if test="${i == 3}">active</c:if>" id="dia${i}" data-toggle="tab" href="#content${i}" role="tab" aria-controls="content${i}" aria-selected="true">
                                                    <fmt:formatDate pattern = "dd/MM/yyyy" value = "${horarios.get(i).dia}" />
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <div class="tab-content card no-top pb-4" id="myTabContent">
                                        <c:forEach begin="0" end="${horarios.size()-1}" var="i">
                                            <div class="tab-pane fade <c:if test="${i == 3}">show active</c:if>" id="content${i}" role="tabpanel" aria-labelledby="profile-tab">
                                                <div id="horarios${i}" data-children=".item${i}">
                                                    <c:set var="diaVazio" value="true"/>
                                                    <c:forEach items="${horarios.get(i).listaHorariosDisponiveis}" var="horarioVazio">
                                                        <c:if test="${horarioVazio.listaConsultasDisponiveis.size() > 0}">
                                                            <c:set var="diaVazio" value="false"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:choose>
                                                        <c:when test="${diaVazio == 'true'}">
                                                            <h3 class="mt-4 text-muted">Não há consultas disponíveis para este dia.</h3>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <h5 class="my-3 text-center">Selecione um horário</h5>
                                                            <div class="row text-center">
                                                                <c:forEach begin="0" end="${horarios.get(i).listaHorariosDisponiveis.size()-1}" var="k">
                                                                    <div class="item${i} col-md-2">
                                                                        <a data-toggle="collapse" data-parent="#horarios${i}" href="#hora${k}-${i}" aria-expanded="true" aria-controls="hora${k}-${i}">
                                                                            <fmt:formatDate pattern = "HH:mm" value = "${horarios.get(i).listaHorariosDisponiveis.get(k).horario}" />
                                                                        </a>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                            <c:forEach begin="0" end="${horarios.get(i).listaHorariosDisponiveis.size()-1}" var="k">
                                                                <div class="item${i}">
                                                                    <div id="hora${k}-${i}" class="collapse card-body" role="tabpanel">
                                                                        <hr class="invisible-divider">
                                                                        <h4><fmt:formatDate pattern = "HH:mm" value = "${horarios.get(i).listaHorariosDisponiveis.get(k).horario}" /></h4>
                                                                        <c:choose>
                                                                            <c:when test="${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.size() > 0}">
                                                                                <table id="tabela" class="table table-sm ">
                                                                                    <thead class="thead-inverse">
                                                                                        <tr>
                                                                                            <th>Clínica</th>
                                                                                            <th>Médico</th>
                                                                                            <th></th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <c:forEach begin="0" end="${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.size()-1}" var="j">
                                                                                            <tr>
                                                                                                <td>${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.get(j).clinica.nome}</td>
                                                                                                <td>${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.get(j).medico.nome} ${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.get(j).medico.sobrenome}</td>
                                                                                                <td>
                                                                                                    <div class="col-md-12 text-right">
                                                                                                        <a id="detalhe" onclick="Detalhe(${i}, ${k}, ${j})" class="clickable btn btn-sm btn-outline-secondary ">Detalhes</a>
                                                                                                    </div>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </c:forEach>
                                                                                    </tbody>
                                                                                </table>
                                                                            </c:when>
                                                                            <c:when test="${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.size() <= 0}">
                                                                                <h5 class="text-muted">Não há consultas disponíveis para esse horário</h5>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
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
                    
                    var horarios = '${horariosJSON}';
                    var paciente = '${pacienteJSON}'
                    horarios = $.parseJSON(horarios);
                    paciente = $.parseJSON(paciente);
                    function Detalhe(i, k, j) {
                        swal({
                            title: horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.nome,
                            html: '<div class="left-text"><h3 class="left-text">Consulta</h3>' +
                                    '<p>Data: ' + getFormattedDate(new Date(horarios[i].dia)) + ', ' + getFormattedHour(new Date(horarios[i].listaHorariosDisponiveis[k].horario)) + '</p>' +
                                    '<h3>Paciente</h3>' +
                                    '<p><strong>Nome: ' + paciente.nome + " " + paciente.sobrenome + '</strong></p>' +
                                    '<h3>Médico</h3>' +
                                    '<p>Nome: ' + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].medico.nome + ' ' +
                                    horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].medico.sobrenome + '</p>' +
                                    '<p>Preço particular: R$' + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].medico.precoConsulta + '</p>',
                            showCloseButton: true,
                            showConfirmButton: true,
                            showCancelButton: true,
                            confirmButtonColor: '#68c4af',
                            cancelButtonColor: '#d33',
                            cancelButtonText: 'Cancelar',
                            confirmButtonText: 'Marcar consulta',
                            width: 600,
                            padding: 30
                        }).then(function () {
                            window.location.href = "EstadoConsultaServlet?action=ClinicaMarcaConsulta&idClinicaEnd=" + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.id + 
                                    "&idMedico=" + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].medico.id + 
                                    "&datahora=" + DateToServlet(new Date(horarios[i].dia), new Date(horarios[i].listaHorariosDisponiveis[k].horario)) +
                                    "&idPaciente=" + paciente.id;
                        });
                    }

                    function getFormattedDate(date) {
                        var year = date.getFullYear();

                        var month = (1 + date.getMonth()).toString();
                        month = month.length > 1 ? month : '0' + month;

                        var day = date.getDate().toString();
                        day = day.length > 1 ? day : '0' + day;

                        return day + '/' + month + '/' + year;
                    }

                    function DateToServlet(date, hour) {
                        var year = date.getFullYear();

                        var month = (1 + date.getMonth()).toString();
                        month = month.length > 1 ? month : '0' + month;

                        var day = date.getDate().toString();
                        day = day.length > 1 ? day : '0' + day;

                        var h = hour.getHours();
                        h = (h < 10) ? ("0" + h) : h;

                        var m = hour.getMinutes();
                        m = (m < 10) ? ("0" + m) : m;

                        return year + '-' + month + '-' + day + " " + h + ':' + m + ":00";
                    }

                    function getFormattedHour(hour) {

                        var h = hour.getHours();
                        h = (h < 10) ? ("0" + h) : h;

                        var m = hour.getMinutes();
                        m = (m < 10) ? ("0" + m) : m;

                        return h + ':' + m;
                    }

                    function getFormattedPhone(number) {
                        return number.replace(/(\d{2})(\d{4})(\d{4})/, '($1)$2-$3');
                    }
                </script>

            </c:otherwise>
        </c:choose>
    </body>
</html>
