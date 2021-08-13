<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/08/20
  Time: 16:23
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Carga de archivo</title>
</head>

<body>
<div class="well">
    <g:link class="btn btn-primary" controller="cronogramaContrato" action="editarVocr" id="${contrato?.id}">Regresar</g:link>
    <elm:poneHtml textoHtml="${flash.message}"/>
%{--    <g:link class="btn btn-primary" controller="composicion" action="tabla" id="${obra}">Regresar</g:link>--}%
</div>
</body>
</html>