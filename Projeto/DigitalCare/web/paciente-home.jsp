<%-- 
    Document   : index.jsp
    Created on : Sep 19, 2017, 2:49:08 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
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
                <div class="agendamento">
                    <div class="container" style="padding-bottom: 50px">
                        <div>
                            &nbsp;
                        </div>
                        <div class="data-box col-md-5 data-box-white">
                        <c:choose>
                            <c:when test="${(param.status == 'semMedicos')}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <strong>Opa! </strong> Não há médicos disponíveis para essa especialidade.
                                </div>
                            </c:when>
                        </c:choose>
                            <h1>Buscar Nova Consulta</h1>
                            <form action="${pageContext.request.contextPath}/ConsultaServlet?action=BuscaConsultas" method="POST">
                                <div class="form-group row">
                                    <label for="tipoConsulta" class="col-sm-4 col-form-label ">Especialidade<span style="color:red;">*</span></label>
                                    <div class="col-sm-8" >
                                        <input id="tipoConsulta"
                                               name="tipoConsulta"
                                               type='text'
                                               placeholder='Tipo da consulta'
                                               class='flexdatalist form-control'
                                               data-min-length='0'
                                               data-search-in='nome'
                                               data-visible-properties='nome'
                                               data-text-property='{nome}'
                                               data-value-property='id'
                                               data-selection-required='true'
                                               required>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="data" class="col-sm-4 col-form-label">Data preferecial</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="data" class="data form-control" id="data" >
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="clinica" class="col-sm-4 col-form-label">Clínica desejada</label>
                                    <div class="col-sm-8" >
                                        <input id="clinica"
                                               name="clinica"
                                               type='text'
                                               placeholder='Clínica desejada'
                                               class='flexdatalist form-control'
                                               data-min-length='0'
                                               data-search-in='nomeFantasia'
                                               data-visible-properties='nomeFantasia'
                                               data-text-property='{nomeFantasia}'
                                               data-value-property='id'
                                               data-selection-required='true'
                                               noResultsText='Sem resultados para "{keyword}"'>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="cidade" class="col-sm-4 col-form-label">Cidade</label>
                                    <div class="col-sm-8" >
                                        <input id="cidade" type='text' autocomplete="off"
                                               placeholder='Cidade'
                                               class='flexdatalist form-control'
                                               data-min-length='3'
                                               name='cidade'
                                               data-search-in='nome'
                                               data-visible-properties='["nome"]'
                                               data-value-property='id'
                                               data-selection-required='true'>

                                        <datalist id="listaCidades"></datalist>

                                        <small>(<span style="color:red;">*</span>)Obrigatório</small>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-12">
                                        <button type="submit" class="form-control btn btn-digital-green">
                                            <i class="fa fa-fw fa-search "></i> Pesquisar Consultas
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="featurette-divider"></div>
                    <div class="row">
                        <div class="col-md-12">
                            <div id="somediv"></div>

                            <h1 class="">Suas próximas consultas</h1><br>
                            <div style="" id="calendar"></div>

                        </div>
                    </div>
                </div>
                <%@include file="/includes/footer.jsp" %>
            </c:otherwise>
        </c:choose>
    </body>
    <script>
        new Date($.now());
        var dt = new Date();
        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
        $('#calendar').fullCalendar({
        locale: 'pt-br',
                editable: false,
                eventClick: function (event) {
                swal({
                title: event.nome + ' ' + event.sobrenome,
                        html: '<div class="left-text"><br><h3 class="left-text">Consulta</h3>' +
                        '<p>Status: Confirmado</p>' +
                        '<p>Horário: ' + event.horario + '</p>' +
                        '<p>Duração prevista: 30 min</p>' +
                        '<p><b>Local: ' + event.local + '</b></p>' +
                        '<p><b>Médico: Dr(a). ' + event.medico + '</b></p></div>' +
                        '<div class="text-right"><br><a href="#" class="btn btn-sm btn-outline-danger">cancelar consulta</a></div>',
                        showCloseButton: true,
                        showConfirmButton: false,
                        allowEnterKey: false,
                        width: 600,
                        padding: 50
                });
                },
                header: {
                left: 'prev,next today myCustomButton',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay'
                },
                timeFormat: 'H(:mm)',
                buttonText: {
                today: 'Hoje',
                        month: 'Mês',
                        week: 'Semana',
                        day: 'Dia',
                        list: 'Lista'
                },
                allDaySlot: false,
                slotLabelFormat: "HH:mm",
                defaultView: 'month',
                columnFormat: 'ddd DD/MM',
                scrollTime: time,
                height: 600,
                eventTextColor: '#fff',
                events: [
        <c:if test="${consultas.size() > 0}">
            <c:forEach begin="0" end="${consultas.size()-1}" var="i" >
                {
                id: '${i}',
                        title: '${consultas.get(i).paciente.nome}',
                        medico: '${consultas.get(i).medico.nome} ${consultas.get(i).medico.sobrenome}',
                                            nome: '${consultas.get(i).paciente.nome}',
                                            sobrenome: '${consultas.get(i).paciente.sobrenome}',
                                            sexo: '${consultas.get(i).paciente.sexo}',
                                            status: '${consultas.get(i).status}',
                                            local: '${consultas.get(i).clinicaEndereco.endereco.rua}, ${consultas.get(i).clinicaEndereco.endereco.numero} - ${consultas.get(i).clinicaEndereco.endereco.bairro}',
                                                                nascimento: '<fmt:formatDate pattern = "dd/MM/yyyy" value = "${consultas.get(i).paciente.dataNascimento}" />',
                                                                horario: '<fmt:formatDate pattern = "HH:mm" value = "${consultas.get(i).dataHora}" />',
                                                                start: '<fmt:formatDate pattern = "yyyy-MM-dd" value = "${consultas.get(i).dataHora}" />T<fmt:formatDate pattern = "HH:mm:ss" value = "${consultas.get(i).dataHora}" />'
                                                                            },
            </c:forEach>
        </c:if>
                                                                            ]
                                                                    });
                                                                    $(document).ready(function () {

                                                                    listaNovaConsulta();
                                                                    function listaNovaConsulta() {
                                                                    $.post(
                                                                            "ConsultaServlet",
                                                                    {action: 'ListaTiposConsulta'}, //meaasge you want to send
                                                                            function (result) {
                                                                            $('#tipoConsulta').flexdatalist('data', result);
                                                                            });
                                                                    $.post(
                                                                            "ConsultaServlet",
                                                                    {action: 'ListaClinicas'}, //meaasge you want to send
                                                                            function (result) {
                                                                            $('#clinica').flexdatalist('data', result);
                                                                            });
                                                                    }

                                                                    function buscaCidades(nome) {
                                                                    $.post(
                                                                            "ConsultaServlet",
                                                                    {action: 'ListaCidades', nome: nome},
                                                                            function (result) {
                                                                            $('#cidade').flexdatalist('data', result);
                                                                            });
                                                                    }

                                                                    $("#cidade-flexdatalist").on("keyup", function (e) {
                                                                    if ($(this).val().length > 2 && $(this).val().length < 6) {
                                                                    $('#listaCidades').empty();
                                                                    buscaCidades($(this).val());
                                                                    }
                                                                    });
                                                                    if ($(window).width() < 1200) {
                                                                    if ($(window).width() < 992) {
                                                                    $('.agendamento .data-box').addClass('col-md-8');
                                                                    $('.agendamento .data-box').removeClass('col-md-5');
                                                                    } else {
                                                                    $('.agendamento .data-box').addClass('col-md-6');
                                                                    $('.agendamento .data-box').removeClass('col-md-5');
                                                                    }
                                                                    }
                                                                    });
    </script>
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_IoScyyrkE8QdU231FPFR926DrLybJUE&callback=initMap">
    </script>

</html>
