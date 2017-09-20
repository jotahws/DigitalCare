<%-- 
    Document   : consultaAtual
    Created on : Sep 16, 2017, 11:52:53 AM
    Author     : JotaWind
--%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <%@include file="/includes/head.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Consulta atual - DigitalCare</title>

        <!-- Style customizado -->
        <link href="${pageContext.request.contextPath}/stylesheet/dash.css" rel="stylesheet">
    </head>

    <body class="fixed-nav sticky-footer" id="page-top">


        <!-- Navigation -->
        <%@include file="/includes/headerDash.jsp" %>

        <div class="content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <h1 class="col-9">Consulta em andamento</h1>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-4">
                        <a class="btn col-12"><i class="fa fa-fw fa-file-text-o"></i> Receita Médica</a>
                        <a class="btn col-12"><i class="fa fa-fw fa-stethoscope"></i> Atestado Médico</a>
                        <a class="btn col-12"><i class="fa fa-fw fa-files-o"></i> Solicitar Exame</a>
                    </div>
                    <div class="col-md-6">
                        <h3>Prontuário<a><i class="fa fa-fw fa-question-circle-o"></i></a></h3>
                        <form class="form">
                            <textarea class=""></textarea>
                        </form>
                    </div>
                </div>
            </div>
        </div> 

        <%@include file="/includes/footer.jsp" %>

        <!-- JS customizado -->
        <script src="js/dash.js"></script>
    </body>
</html>