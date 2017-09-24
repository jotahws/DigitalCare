<%-- 
    Document   : headerClinica
    Created on : Sep 13, 2017, 2:21:50 PM
    Author     : JotaWind
--%>
<!--request.getAttribute("javax.servlet.forward.request_uri")-->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <a class="navbar-brand" href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/images/logo-peq-branco.png"></a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
        <!--Itens da barra lateral-->
        <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
            <c:choose>
                <c:when test="${sessionLogin.perfil == 2}">
                    <li class="nav-item active" data-toggle="tooltip" data-placement="right" title="Dashboard">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard.jsp">
                            <i class="fa fa-fw fa-tachometer" aria-hidden="true"></i>
                            <span class="nav-link-text">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="pacientes">
                        <a class="nav-link" href="${pageContext.request.contextPath}/pacientes.jsp">
                            <i class="fa fa-fw fa-users"></i>
                            <span class="nav-link-text">Pacientes</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
                        <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseComponents" data-parent="#exampleAccordion">
                            <i class="fa fa-fw fa-calendar"></i>
                            <span class="nav-link-text">Calend�rio</span>
                        </a>
                        <ul class="sidenav-second-level collapse" id="collapseComponents">
                            <li>
                                <a href="${pageContext.request.contextPath}/calendario.jsp">Calend�rio Detalhado</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/indisponibilidade.jsp">Marcar Indisponibilidade</a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                        <a class="nav-link" href="${pageContext.request.contextPath}/configuracoes-medico.jsp">
                            <i class="fa fa-fw fa-wrench"></i>
                            <span class="nav-link-text">Configura��es</span>
                        </a>
                    </li>
                </c:when>
                <c:when test="${sessionLogin.perfil == 3}">
                    <li class="nav-item active" data-toggle="tooltip" data-placement="right" title="Dashboard">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard-clinica.jsp">
                            <i class="fa fa-fw fa-tachometer" aria-hidden="true"></i>
                            <span class="nav-link-text">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts">
                        <a class="nav-link" href="${pageContext.request.contextPath}/medicos.jsp">
                            <i class="fa fa-fw fa-user-md"></i>
                            <span class="nav-link-text">M�dicos</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
                        <a class="nav-link" href="${pageContext.request.contextPath}/calendario-clinica.jsp">
                            <i class="fa fa-fw fa-calendar-o"></i>
                            <span class="nav-link-text">Calend�rio</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                        <a class="nav-link" href="${pageContext.request.contextPath}/agendar-consulta.jsp">
                            <i class="fa fa-fw fa-calendar-plus-o"></i>
                            <span class="nav-link-text">Agendar Consulta</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                        <a class="nav-link" href="${pageContext.request.contextPath}/configuracoes-clinica.jsp">
                            <i class="fa fa-fw fa-wrench"></i>
                            <span class="nav-link-text">Configura��es</span>
                        </a>
                    </li>
                </c:when>
            </c:choose>
        </ul>
        <!--FIM Itens da barra lateral-->

        <!--notificacoes e logout-->
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle mr-lg-2" href="#" id="alertsDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-fw fa-bell"></i>
                    <span class="d-lg-none">Alerts
                        <span class="badge badge-pill badge-warning">Novas Notifica��es</span>
                    </span>
                    <span class="new-indicator text-warning d-none d-lg-block">
                        <i class="fa fa-fw fa-circle"></i>
                        <span class="number"></span>
                    </span>
                </a>
                <div class="dropdown-menu" aria-labelledby="alertsDropdown">
                    <h6 class="dropdown-header">Alertas:</h6>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">
                        <span class="text-success">
                            <strong>
                                <i class="fa fa-long-arrow-up"></i>
                                Status Update</strong>
                        </span>
                        <span class="small float-right text-muted">11:21 AM</span>
                        <div class="dropdown-message small">This is an automated server response message. All systems are online.</div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item small" href="#">
                        View all alerts
                    </a>
                </div>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/LoginServlet?action=logout" class="nav-link" data-toggle="modal" data-target="#exampleModal">
                    <i class="fa fa-fw fa-sign-out"></i>
                    Logout
                </a>
            </li>
        </ul>
    </div>
</nav>