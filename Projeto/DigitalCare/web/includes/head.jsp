<%-- 
    Document   : head
    Created on : Aug 30, 2017, 10:46:46 AM
    Author     : JotaWind
--%>

        <jsp:useBean scope="session" id="sessionLogin" class="beans.Login"/>
        <!--Arrumando responsividade-->
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <!--Full Calendar-->
        <link rel='stylesheet' href='${pageContext.request.contextPath}/components/fullcalendar/fullcalendar.css' />
        <script src='${pageContext.request.contextPath}/components/fullcalendar/lib/jquery.min.js'></script>
        <script src='${pageContext.request.contextPath}/components/fullcalendar/lib/moment.min.js'></script>
        <script src='${pageContext.request.contextPath}/components/fullcalendar/locale/pt-br.js'></script>
        <script src='${pageContext.request.contextPath}/components/fullcalendar/fullcalendar.js'></script>
        <!--Sweet Alert-->
        <script src="${pageContext.request.contextPath}/components/sweetalert2/dist/sweetalert2.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/components/sweetalert2/dist/sweetalert2.css">
        <!--Masks-->
        <script src="${pageContext.request.contextPath}/components/maskedinput/jquery.maskedinput.js"></script>
        <script src="${pageContext.request.contextPath}/components/maskedinput/jquery.maskMoney.js"></script>
        <!--POPPER-->
        <script src="${pageContext.request.contextPath}/components/popper.js/dist/umd/popper.min.js" ></script>
        <!--Bootstrap-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/components/bootstrap/dist/css/bootstrap.min.css" >
        <script src="${pageContext.request.contextPath}/components/bootstrap/dist/js/bootstrap.min.js" ></script>
        <script src="${pageContext.request.contextPath}/components/bootstrap/js/dist/util.js" ></script>
        <script src="${pageContext.request.contextPath}/components/bootstrap/js/dist/tab.js" ></script>
        <!--FlexDatalist-->
        <script src="${pageContext.request.contextPath}/components/jquery-flexdatalist-2.2.1/jquery.flexdatalist.min.js" ></script>
        <link href="${pageContext.request.contextPath}/components/jquery-flexdatalist-2.2.1/jquery.flexdatalist.min.css" rel="stylesheet" type="text/css">
        <!--Font Awesome-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/components/font-awesome/css/font-awesome.css" >
        <!--Customizacao-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/style.css" >
        <script src="${pageContext.request.contextPath}/js/customjs.js"></script>
        <!--Icone Aba-->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/miniatura.png" type="image/x-png"/>
        <!--DataTable-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/components/DataTables/datatables.min.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/components/DataTables/datatables.min.js"></script>
