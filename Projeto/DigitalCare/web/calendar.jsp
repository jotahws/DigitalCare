<%-- 
    Document   : calendar
    Created on : Sep 14, 2017, 11:33:46 AM
    Author     : JotaWind
--%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <%@include file="/includes/head.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Dashboard</title>

        <!-- Style customizado -->
        <link href="${pageContext.request.contextPath}/stylesheet/dash.css" rel="stylesheet">
    </head>

    <body class="fixed-nav sticky-footer" id="page-top">
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
                        })
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
                        list: 'List'
                    },
                    allDaySlot: false,
                    height: 'parent',
                    slotLabelFormat: "HH:mm",
                    defaultView: 'agendaWeek',
                    columnFormat: 'ddd DD/MM',
                    scrollTime: time,

                    events: [
                        {
                            title: 'event1',
                            start: '2017-08-30T13:30:00'
                        },
                        {
                            title: 'event2',
                            start: '2017-08-30T13:30:00',
                            end: '2017-08-21T16:30:00'
                        },
                        {
                            title: 'event3',
                            start: '2017-08-23T12:30:00',
                        }
                    ]
                });

            });
        </script>
        <!--FIM Calendario-->

        <!-- Navigation -->
        <%@include file="/includes/headerClinica.jsp" %>

        <div class="content-wrapper">
            <div class="container-fluid">
                <h1>Calendário</h1>
                <hr>
                <h2></h2>
                <div style="height: 600px" id="calendar"></div>
            </div>
        </div> 

        <%@include file="/includes/footer.jsp" %>

        <!-- JS customizado -->
        <script src="js/dash.js"></script>

</html>
