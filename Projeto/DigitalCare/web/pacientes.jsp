<%-- 
    Document   : pacientes
    Created on : Sep 16, 2017, 10:46:13 AM
    Author     : JotaWind
--%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <%@include file="/includes/head.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Pacientes - DigitalCare</title>

        <!-- Style customizado -->
        <link href="${pageContext.request.contextPath}/stylesheet/dash.css" rel="stylesheet">
    </head>

    <body class="fixed-nav sticky-footer" id="page-top">


        <!-- Navigation -->
        <%@include file="/includes/headerClinica.jsp" %>

        <div class="content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <h1 class="col-9">Pacientes</h1>
                </div>
                <hr>
                <div class="row">
                    <table class="table">
                        <thead class="thead-inverse">
                            <tr>
                                <th>#</th>
                                <th>Nome</th>
                                <th>Idade</th>
                                <th>Email</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td>Mark Zukerzinho</td>
                                <td>38</td>
                                <td>marcos@gmail.com</td>
                                <td><a href="" class="btn btn-primary">Ver perfil</a></td>
                            </tr>
                            <tr>
                                <th scope="row">2</th>
                                <td>Jacob Vampirinho</td>
                                <td>105</td>
                                <td>jakobson@gmail.com</td>
                                <td><a href="" class="btn btn-primary">Ver perfil</a></td>
                            </tr>
                            <tr>
                                <th scope="row">3</th>
                                <td>Larry Passarinho</td>
                                <td>17</td>
                                <td>larry@yahoo.com</td>
                                <td><a href="" class="btn btn-primary">Ver perfil</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div> 

        <%@include file="/includes/footer.jsp" %>

        <!-- JS customizado -->
        <script src="js/dash.js"></script>
    </body>
</html>