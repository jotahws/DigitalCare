<%-- 
    Document   : header
    Created on : Aug 30, 2017, 10:45:57 AM
    Author     : JotaWind
--%>

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
                    <ul class="navbar-nav navbar-right ">
                        <li class="nav-item">
                            <a class="btn-digital-yellow nav-link btn" id="header-btn" href="#">Entrar</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Cadastrar</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>