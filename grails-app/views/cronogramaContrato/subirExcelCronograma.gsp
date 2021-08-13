<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/08/20
  Time: 13:16
--%>

<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/08/20
  Time: 15:43
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <title>Subir archivo excel</title>
</head>

<body>
<g:if test="${flash.message}">
    <div class="alert alert-error">
        ${flash.message}
    </div>
</g:if>

<g:uploadForm action="uploadFileCronograma" method="post" name="frmUploadCronograma" id="${contrato?.id}">
    <div id="list-grupo" class="span12" role="main" style="margin: 10px 0 0 0;">
        <div class="row-fluid" style="margin: 0 0 20px 0;">
            <div class="span9">
                El archivo debe contener al menos 8 columnas (los nombres de las columnas no son importantes):
                <table class="table table-bordered table-condensed">
                    <tr>
                        <th>
                            CODIGO
                        </th>
                        <th>
                            NUMERO
                        </th>
                        <th>
                            RUBRO
                        </th>
                        <th>
                            UNIDAD
                        </th>
                        <th>
                            CANTIDAD
                        </th>
                        <th>
                            P.UNITARIO
                        </th>
                        <th>
                            SUBTOTAL
                        </th>
                        <th>
                            PERIODO 1
                        </th>
                        <th>
                            PERIODO 2
                        </th>
                        <th>
                            PERIODO 3
                        </th>
                        <th>
                            ...
                        </th>
                    </tr>
                </table>

                El rubro es ubicado por el número de orden<br/>
                Los valores detallados en cada periodo se subirán al cronograma para el rubro y period correspondiente
               <br/>
            </div>
        </div>

        <div class="row-fluid" style="margin-left: 0px">
            <div class="span6">
                <div class="span2"><b>Archivo:</b></div>
                <input type="file" class="required" id="file" name="file"/>
            </div>
        </div>
    </div>

    <div class="row-fluid" style="margin-left: 0px">
        <div class="span4">
            <a href="#" class="btn btn-success" id="btnSubmit">Subir</a>
        </div>
    </div>
</g:uploadForm>

<script type="text/javascript">
    $(function () {
        $("#btnSubmit").click(function () {
            if ($("#frmUploadCronograma").valid()) {
                $(this).replaceWith(spinner);
                $("#frmUploadCronograma").submit();
            }
        });
    });
</script>
</body>
</html>