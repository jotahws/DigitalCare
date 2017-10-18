<%-- 
    Document   : index.jsp
    Created on : Sep 19, 2017, 2:49:08 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                    <div class="container">
                        <div>
                            &nbsp;
                        </div>
                        <div class="data-box col-md-5 data-box-white">
                            <h1>Buscar Nova Consulta</h1>
                            <form action="${pageContext.request.contextPath}/ConsultaServlet?action=BuscaConsultas" method="POST">
                                <div class="form-group row">
                                    <label for="tipoConsulta" class="col-sm-4 col-form-label ">Tipo da consulta<span style="color:red;">*</span></label>
                                    <div class="col-sm-8" >
                                        <input id="tipoConsulta"
                                               name="tipoConsulta"
                                               type='text'
                                               placeholder='Tipo da consulta'
                                               class='flexdatalist form-control'
                                               data-min-length='0'
                                               list='tiposConsulta'
                                               data-selection-required='true'
                                               required>
                                        <datalist id="tiposConsulta">
                                        </datalist>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="data" class="col-sm-4 col-form-label">Data preferecial</label>
                                    <div class="col-sm-8">
                                        <input type="date" name="data" class="data form-control" id="data" >
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
                                               list='listaClinicas'
                                               data-selection-required='true'>

                                        <datalist id="listaClinicas"></datalist>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="cidade" class="col-sm-4 col-form-label">Cidade</label>
                                    <div class="col-sm-8" >
                                        <input id="cidade" type='text' autocomplete="off"
                                               placeholder='Cidade'
                                               class='flexdatalist form-control'
                                               data-min-length='1'
                                               list='listaCidades'
                                               name='cidade'
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
        $(document).ready(function () {
            new Date($.now());
            var dt = new Date();
            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();

            $('#calendar').fullCalendar({
                locale: 'pt-br',
                editable: false,
                eventClick: function (event) {
                    swal({
                        title: event.title,
                        html: '<div class="left-text"><br><h3 class="left-text">Consulta</h3>' +
                                '<p>Status: Confirmado</p>' +
                                '<p>Horário: ' + event.start.toString() + '</p>' +
                                '<p>Duração prevista: 30 min</p>' +
                                '<p><b>Local: Clínica Lucano</b></p>' +
                                '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d10095.611312493658!2d-49.28693809014179!3d-25.45570653704176!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x4eb0012a30701491!2sCl%C3%ADnica+Lucano!5e0!3m2!1spt-BR!2sbr!4v1506433178013" width="500" height="250" frameborder="0" style="border:0" allowfullscreen="false"></iframe>' +
                                '<br><br><a href="#" class="btn-sm btn-digital-green">OK!</a> \n\
                                             <a href="#" class="btn-sm btn-danger">cancelar consulta</a>',
                        showCloseButton: true,
                        showConfirmButton: false,
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
                events: [
                    {
                        title: 'Dermatologia',
                        start: '2017-08-30T13:30:00'
                    },
                    {
                        title: 'Endocrinologia',
                        start: '2017-08-30T13:30:00',
                        end: '2017-08-21T14:00:00'
                    },
                    {
                        title: 'Geriatria',
                        start: '2017-08-23T12:00:00',
                        end: '2017-08-21T13:00:00'
                    },
                    {
                        id: '1',
                        title: 'Dermatologia',
                        start: '2017-09-14T09:30:00',
                        end: '2017-09-14T10:00:00'
                    },
                    {
                        id: '2',
                        title: 'Consulta X',
                        start: '2017-09-14T10:30:00',
                        end: '2017-09-14T11:00:00'
                    },
                    {
                        id: '9',
                        title: 'Dermatologia',
                        start: '2017-09-14T17:30:00',
                        end: '2017-09-14T18:00:00'
                    }
                ]
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

            listaNovaConsulta();

            function listaNovaConsulta() {
                $.post(
                        "ConsultaServlet",
                        {action: 'ListaTiposConsulta'}, //meaasge you want to send
                        function (result) {
                            $.each(result, function (index, tipo) {
                                $("<option>").appendTo($("#tiposConsulta")).append(tipo.nome).val(tipo.id);
                            });
                        });
                $.post(
                        "ConsultaServlet",
                        {action: 'ListaClinicas'}, //meaasge you want to send
                        function (result) {
                            $.each(result, function (index, clinica) {
                                $("<option>").appendTo($("#listaClinicas")).append(clinica.nomeFantasia).val(clinica.id);
                            });
                        });
            }

            function buscaCidades(nome) {
                $.post(
                        "ConsultaServlet",
                        {action: 'ListaCidades', nome: nome}, //meaasge you want to send
                        function (result) {
                            $.each(result, function (index, cidade) {
                                $("<option>").appendTo($("#listaCidades")).append(cidade.nome).val(cidade.id);
                            });
                        });
            }

            $("#cidade-flexdatalist").on("keyup", function (e) {
                if ($(this).val().length > 2 && $(this).val().length < 6) {
                    //if ($(this).val().length < 6) {
                        $('#listaCidades').empty();
                    //}
                    buscaCidades($(this).val());
                }
            });
        });
    </script>

</html>
