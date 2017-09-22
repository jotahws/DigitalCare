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
                            &nbsp
                        </div>
                        <div class="data-box col-md-5 data-box-white">
                            <h1>Buscar Nova Consulta</h1>
                            <form>
                                <div class="form-group row">
                                    <label for="tipoConsulta" class="col-sm-4 col-form-label">Tipo da consulta</label>
                                    <div class="col-sm-8" >
                                        <select id="tipoConsulta" name="sexo" class="col-md-10 custom-select">
                                            <option value="dermato">Dermatologia</option>
                                            <option value="endo">Endocrinologia</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="tipoConsulta" class="col-sm-4 col-form-label">Data preferecial</label>
                                    <div class="col-sm-8">
                                        <input type="date" class="form-control" id="data" placeholder="Data preferecial">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-12">
                                        <input type="text" class="form-control" id="clinica" placeholder="Clínica desejada">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-12">
                                        <input type="text" class="form-control" id="cidade" placeholder="Cidade">
                                    </div>
                                </div>
                                <div class="form-group row">

                                    <div class="col-sm-12">
                                        <button type="submit" class="form-control btn btn-digital-green">
                                            <i class="fa fa-fw fa-search "></i> Pesquisar Clínicas
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
                            <h1 class="">Próximas consultas</h1><br>
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
                eventClick: function () {
                    swal({
                        title: 'João das Neves',
                        html: 'aqui aparecerá o <b>estado</b> da consulta,<br> <b>perfil</b> do paciente, eticétera... ',
                        confirmButtonText: 'top!'
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
                        title: 'event1',
                        start: '2017-08-30T13:30:00'
                    },
                    {
                        title: 'event2',
                        start: '2017-08-30T13:30:00',
                        end: '2017-08-21T14:00:00'
                    },
                    {
                        title: 'event3',
                        start: '2017-08-23T12:00:00',
                        end: '2017-08-21T13:00:00'
                    },
                    {
                        id: '1',
                        title: 'Deputada Léia Organson',
                        start: '2017-09-14T09:30:00',
                        end: '2017-09-14T10:00:00'
                    },
                    {
                        id: '2',
                        title: 'Anaquim Vader',
                        start: '2017-09-14T10:30:00',
                        end: '2017-09-14T11:00:00'
                    },
                    {
                        id: '9',
                        title: 'Quai Gonna Jim',
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
        });
    </script>

</html>
