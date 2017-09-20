<%-- 
    Document   : index.jsp
    Created on : Sep 19, 2017, 2:49:08 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/carousel.css">
        <%@include file="/includes/head.jsp" %>
    </head>
    <body>
        <%@include file="/includes/header.jsp" %>
        <div class="container marketing">

            <!-- Lista de features -->
            <div class="row featurette">
                <div class="col-md-7">
                    <h1 class="featurette-heading">Paciente - Home </h1>
                </div>
                <div class="col-md-5">
                </div>
            </div>

            <hr class="featurette-divider">
            <!-- FOOTER -->

        </div><!-- /.container -->

        <%@include file="/includes/footer.jsp" %>

    </body>

</html>
