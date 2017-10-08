<%-- 
    Document   : index
    Created on : Aug 30, 2017, 5:14:24 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DigitalCare</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/carousel.css">
        <%@include file="/includes/head.jsp" %>
    </head>
    <body>
        <c:choose>
            <c:when test="${(sessionLogin.perfil == 1)}">
                <c:redirect url="/paciente-home.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil == 2)}">
                <c:redirect url="/dashboard.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil == 3)}">
                <c:redirect url="/dashboard-clinica.jsp"/>
            </c:when>
        </c:choose>
        <%@include file="/includes/header.jsp" %>

        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="first-slide" src="${pageContext.request.contextPath}/images/Doctor7.jpg" alt="Primeiro slide">
                    <div class="container">
                        <div class="carousel-caption d-none d-md-block text-left">
                            <h1>Seja bem vindo � DigitalCare,<br> uma maneira r�pida e f�cil de agendar sua consulta.</h1>
                            <p><a class="btn btn-lg btn-digital-green" href="${pageContext.request.contextPath}/cadastroPaciente.jsp" role="button">Cadastre-se agora</a></p>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="second-slide" src="${pageContext.request.contextPath}/images/Doctor2.jpg" alt="Segundo slide">
                    <div class="container">
                        <div class="carousel-caption d-none d-md-block">
                            <h1>Sua consulta em boas m�os.</h1>
                            <p>Todas as cl�nicas parceiras da DigitalCare s�o cadastradas e aprovadas, para voc� n�o precisar se preocupar com a proced�ncia do m�dico.</p><br><br><br>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="third-slide" src="${pageContext.request.contextPath}/images/Doctor8.jpg" alt="Terceiro slide">
                    <div class="container">
                        <div class="carousel-caption d-none d-md-block text-right">
                            <h1>Escolha o melhor plano para voc�.</h1>
                            <p>Com a DigitalCare voc� pode escolher se deseja realizar uma consulta particular ou por algum conv�nio. Tudo com apenas um clique.</p><br><br><br>
                        </div>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Anterior</span>
            </a>
            <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Pr�ximo</span>
            </a>
        </div>

        <div class="container marketing">

            <!-- Lista de features -->
            <div class="row featurette">
                <div class="col-md-7">
                    <h2 class="featurette-heading">N�o se prenda a uma cl�nica. <span class="text-muted">Liberte-se.</span></h2>
                    <p class="lead">A DigitalCare conta com uma infinidade de cl�nicas parceiras para que voc� possa escolher a que mais te agrada.</p>
                </div>
                <div class="col-md-5">
                    <img class="featurette-image img-fluid mx-auto" src="${pageContext.request.contextPath}/images/cage.png" alt="P�ssaro saindo da gaiola">
                </div>
            </div>

            <hr class="featurette-divider">

            <div class="row featurette">
                <div class="col-md-7 order-md-2">
                    <h2 class="featurette-heading">Escolha qual consulta voc� deseja fazer. <span class="text-muted">N�s faremos o resto.</span></h2>
                    <p class="lead">Voc� digita o seu tipo de consulta e n�s te daremos uma variedade de cl�nicas para que voc� possa escolher de acordo com sua disponibilidade de acesso e de tempo.</p>
                </div>
                <div class="col-md-5 order-md-1">
                    <img class="featurette-image img-fluid mx-auto" src="${pageContext.request.contextPath}/images/dedo-botao.png" alt="tecla escrita a palavra m�gica">
                </div>
            </div>

            <hr class="featurette-divider">

            <div class="row featurette">
                <div class="col-md-7">
                    <h2 class="featurette-heading">Agende quantas vezes quiser. <span class="text-muted">Cancele a hora que quiser.</span></h2>
                    <p class="lead">Voc� pode agendar de acordo com a sua disponibilidade. Se tiver algum compromisso, simplesmente entre na DigitalCare e cancele, sem precisar sair do lugar ou mesmo fazer liga��es.</p>
                </div>
                <div class="col-md-5">
                    <img class="featurette-image img-fluid mx-auto" src="${pageContext.request.contextPath}/images/calendar.png" alt="calend�rio com um dia circulado">
                </div>
            </div>

            <hr class="featurette-divider">

            <div class="row featurette">
                <div class="col-md-7 ">
                    <h1 class="">N�o perca tempo, cadastre-se agora mesmo!</h1>
                    <p><a class="btn btn-lg btn-digital-green" href="${pageContext.request.contextPath}/cadastroPaciente.jsp" role="button">Clique aqui</a></p>
                </div>
                <div class="vr"></div>
                <div class="text-right col-md-4">
                    <h2 class="text-muted">Deseja cadastrar sua cl�nica?</h2>
                    <p><a class="btn btn-lg btn-digital-yellow" href="${pageContext.request.contextPath}/cadastroClinica.jsp" role="button">Seja nosso parceiro!</a></p>
                </div>
            </div>


            <!-- /Fim das features -->

            <!-- FOOTER -->

        </div><!-- /.container -->

        <%@include file="/includes/footer.jsp" %>

    </body>

</html>
