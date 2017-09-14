<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Dashboard</title>

        <%@include file="/includes/head.jsp" %>
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
                $('#resumo-dia').fullCalendar({
                    locale: 'pt-br',
                    editable: false,
                    eventClick: function (event) {
                        swal({
                            title: event.title,
                            html: 'aqui aparecerá o <b>estado</b> da consulta,<br> <b>perfil</b> do paciente, eticétera... ',
                            confirmButtonText: 'top!'
                        })
                    },
                    header: {
                        left: 'title',
                        center: '',
                        right: ''
                    },
                    listDayFormat: 'dddd',
                    listDayAltFormat: 'DD [de] MMMM [de] YYYY',
                    titleFormat: "[Resumo para hoje]",
                    timeFormat: 'H(:mm)',
                    allDaySlot: false,
                    height: 350,
                    slotLabelFormat: "HH:mm",
                    defaultView: 'listDay',
                    columnFormat: 'ddd DD/MM',
                    scrollTime: time,
                    events: [
                        {
                            title: 'Deputada Léia',
                            start: '2017-09-14T09:30:00'
                        },
                        {
                            title: 'Anaquim Vader',
                            start: '2017-09-14T10:30:00',
                            end: '2017-08-21T16:30:00'
                        },
                        {
                            title: 'Darth Mau',
                            start: '2017-09-14T11:30:00',
                        },
                        {
                            title: 'Ran Sollo',
                            start: '2017-09-14T12:30:00'
                        },
                        {
                            title: 'Chewie Bacon',
                            start: '2017-09-14T13:30:00',
                            end: '2017-08-21T16:30:00'
                        },
                        {
                            title: 'Lucas Skaiualquer',
                            start: '2017-09-14T14:30:00',
                        },
                        {
                            title: 'Prin Amigdala',
                            start: '2017-09-14T15:30:00'
                        },
                        {
                            title: 'Yodinha das Novinha',
                            start: '2017-09-14T16:30:00',
                            end: '2017-08-21T16:30:00'
                        },
                        {
                            title: 'Quai Gonna Jim',
                            start: '2017-09-14T17:30:00',
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
                <h1>Dashboard</h1>
                <hr>
                <div style="" class="table-striped " id="resumo-dia"></div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="data-box data-box-dark">
                            <h2>10</h2>
                            <p>Texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto </p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="data-box data-box-light">
                            <h2>10</h2>
                            <p>Texto texto texto texto texto texto texto texto texto </p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="data-box data-box-dark">
                            <h2>10</h2>
                            <p>Texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto </p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="data-box data-box-light">
                            <h2>10</h2>
                            <p>Texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto </p>
                        </div>
                    </div>
                </div>
            </div>
        </div> 

        <%@include file="/includes/footer.jsp" %>

        <!-- JS customizado -->
        <script src="js/dash.js"></script>

</html>
