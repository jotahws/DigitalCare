<%-- 
    Document   : calendar
    Created on : Sep 14, 2017, 11:33:46 AM
    Author     : JotaWind
--%>

<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <%@include file="/includes/head.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Calendário - DigitalCare</title>

        <!-- Style customizado -->
        <link href="${pageContext.request.contextPath}/stylesheet/dash.css" rel="stylesheet">
    </head>

    <body class="fixed-nav sticky-footer" id="page-top">


        <!-- Navigation -->
        <%@include file="/includes/headerClinica.jsp" %>

        <div class="content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <h1 class="col-9">Calendário</h1>
                    <a href="${pageContext.request.contextPath}/indisponibilidade.jsp" class=" btn-lg col-md-3 text-right"><i class="fa fa-fw fa-clock-o"></i>Marcar indisponibilidade</a>
                </div>
                <hr>
                <div class="row">

                    <div class="col-md-3">
                        <div class="data-box-sm data-box data-box-light ">
                            <h2>2</h2>
                            <p>Paciente(s) em espera</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="data-box bg-warning-light data-box-sm">
                            <h2>10</h2>
                            <p>Paciente(s) Restante(s)</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="data-box bg-danger-light data-box-sm">
                            <h2>1</h2>
                            <p>Paciente(s) Cancelado(s)</p>
                        </div>
                    </div>
                    <div class="col-md-3 ">
                        <a href="" class="btn-data-box-row btn btn-digital-green"><i class="fa fa-2x pull-right fa-arrow-circle-o-right"></i>Chamar Próximo Paciente</a>
                    </div>
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
                    defaultView: 'agendaWeek',
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
                            id: '3',
                            title: 'Darch Sidou',
                            start: '2017-09-14T11:30:00',
                            end: '2017-09-14T12:00:00'
                        },
                        {
                            id: '4',
                            title: 'Ran Sollo',
                            start: '2017-09-14T12:30:00',
                            end: '2017-09-14T13:00:00'
                        },
                        {
                            id: '5',
                            title: 'Chewie Bacon',
                            start: '2017-09-14T13:30:00',
                            end: '2017-09-14T14:00:00'
                        },
                        {
                            id: '6',
                            title: 'Lucas Skaiualquer',
                            start: '2017-09-14T14:30:00',
                            end: '2017-09-14T15:00:00'
                        },
                        {
                            id: '7',
                            title: 'Prin Amigdala',
                            start: '2017-09-14T15:30:00',
                            end: '2017-09-14T16:00:00'
                        },
                        {
                            id: '8',
                            title: 'Yodinha das Novinha',
                            start: '2017-09-14T16:30:00',
                            end: '2017-09-14T17:00:00'
                        },
                        {
                            id: '9',
                            title: 'Quai Gonna Jim',
                            start: '2017-09-14T17:30:00',
                            end: '2017-09-14T18:00:00'
                        }
                    ]
                });
                if ($(window).width() < 992) {
                    $('#calendar').fullCalendar('changeView', 'agendaDay');
                }
            });
        </script>
        <!--FIM Calendario-->
    </body>
</html>
