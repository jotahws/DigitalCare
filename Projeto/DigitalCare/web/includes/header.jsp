        <%-- 
            Document   : header
            Created on : Aug 30, 2017, 10:45:57 AM
            Author     : JotaWind
        --%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/images/logo-peq-branco.png"></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="${pageContext.request.contextPath}">Home</a>
                        </li>
                    </ul>
                    <c:choose>
                        <c:when test="${sessionLogin.perfil != 0}">
                            <ul class="navbar-nav ml-auto">
                                <c:choose>
                                    <c:when test="${sessionLogin.perfil == 1}">
                                        <li class="nav-item active" >
                                            <a class="nav-link" href="${pageContext.request.contextPath}/PacienteServlet?action=meuPerfil">Perfil</a>
                                        </li>
                                    </c:when>
                                </c:choose>
                                <li class="nav-item">
                                    <a href="${pageContext.request.contextPath}/LoginServlet?action=logout" class="nav-link">
                                        <i class="fa fa-fw fa-sign-out"></i>
                                        Logout
                                    </a>
                                </li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <ul class="navbar-nav navbar-right ">
                                <li class="nav-item">
                                    <a class="btn-digital-yellow nav-link btn" id="header-btn" href="${pageContext.request.contextPath}/login.jsp">Entrar</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/cadastroPaciente.jsp">Cadastrar</a>
                                </li>
                            </ul>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
        </nav>
