<%-- 
    Document   : index
    Created on : Aug 26, 2017, 11:39:39 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DigitalCare</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
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
                        list: 'Lista'
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
        <div style="height: 600px" id="calendar"></div>
    </body>
</html>
