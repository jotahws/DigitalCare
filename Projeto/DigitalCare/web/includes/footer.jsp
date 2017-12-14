<%-- 
    Document   : footer
    Created on : Aug 30, 2017, 10:46:07 AM
    Author     : JotaWind
--%>

        <footer class="rodape" style="background-image: url('${pageContext.request.contextPath}/images/footer.png');">
            <div class="container">
                <p id="toTop" class="float-right"><a href="javascript:void(0)"><img src="${pageContext.request.contextPath}/images/arrow.png"></a></p>
                <img src="${pageContext.request.contextPath}/images/logo-med.png" style="width: 200px"/><br><br>
                <p>&copy; 2017 &middot; Universidade Federal do Paraná.</p>
                <a href="http://www.freepik.com">Images by Freepik</a>
            </div>
            <script>
                $("#toTop").click(function () {
                    $("html, body").animate({scrollTop: 0}, 500);
                 });
            </script>
        </footer>