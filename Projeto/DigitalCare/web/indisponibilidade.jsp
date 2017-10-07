<%-- 
    Document   : indisponibilidade
    Created on : Sep 15, 2017, 10:44:06 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <%@include file="/includes/head.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Marcar indisponibilidade - DigitalCare</title>

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
                            <h1 class="col-10">Marcar Indisponibilidade</h1>
                        </div>
                        <hr>
                        <div id="form" class="data-box data-box-yellow-light col-md-6">
                            <form>
                                <div class="form-group">
                                    <label for="data" class="col-form-label">Data</label>
                                    <input type="text" class="form-control data" id="data" placeholder="Ex. 12/02/2017">
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="de" class="col-form-label">De</label>
                                        <input type="text" class="form-control" id="de" placeholder="Ex. 13:00" >
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="ate" class="col-form-label">Até</label>
                                        <input type="text" class="form-control" id="ate" placeholder="Ex. 16:00">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input class="form-check-input" id="dia-inteiro" type="checkbox"> Dia Inteiro
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <input type="submit" class="btn btn-primary" value="Salvar">
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div style="" id="calendar"></div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <!--Calendario-->
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
                        });
                    });
                    if ($(window).width() > 1400) {
                        $('#form').addClass('col-lg-4');
                    }
                </script>
                <!--FIM Calendario-->
            </c:otherwise>
        </c:choose>
    </body>
</html>
