<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Dashboard - DigitalCare</title>

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
                            title: event.title + ' <a href="#" class="btn btn-sm btn-digital-green">Ver perfil</a>',
                            html: '<div class="left-text"><br><h3 class="left-text">Consulta</h3>' +
                                    '<p>Status: Confirmado</p>' +
                                    '<p>Horário: ' + event.start.toString() + '</p>' +
                                    '<p>Duração prevista: 30 min</p>' +
                                    '<br><h3>Perfil</h3>' +
                                    '<p>Última consulta: 30/05/2016</p>' +
                                    '<p>Usuário desde: 2005</p></div>' +
                                    '<br><a href="#" class="btn btn-digital-green">iniciar consulta</a> \n\
                                     <a href="#" class="btn btn-info">consulta concluída</a> \n\
                                     <a href="#" class="btn btn-danger">cancelar consulta</a>',
                            showCloseButton: true,
                            showConfirmButton: false,
                            width: 600,
                            padding: 50
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
                            id: '1',
                            title: 'Deputada Léia Organson',
                            start: '2017-09-14T09:30:00'
                        },
                        {
                            id: '2',
                            title: 'Anaquim Vader',
                            start: '2017-09-14T10:30:00',
                            end: '2017-08-21T16:30:00'
                        },
                        {
                            id: '3',
                            title: 'Darch Sidou',
                            start: '2017-09-14T11:30:00',
                        },
                        {
                            id: '4',
                            title: 'Ran Sollo',
                            start: '2017-09-14T12:30:00'
                        },
                        {
                            id: '5',
                            title: 'Chewie Bacon',
                            start: '2017-09-14T13:30:00',
                            end: '2017-08-21T16:30:00'
                        },
                        {
                            id: '6',
                            title: 'Lucas Skaiualquer',
                            start: '2017-09-14T14:30:00',
                        },
                        {
                            id: '7',
                            title: 'Prin Amigdala',
                            start: '2017-09-14T15:30:00'
                        },
                        {
                            id: '8',
                            title: 'Yodinha das Novinha',
                            start: '2017-09-14T16:30:00',
                            end: '2017-08-21T16:30:00'
                        },
                        {
                            id: '9',
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
