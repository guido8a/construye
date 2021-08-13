<%@ page import="janus.Grupo" %>

<%
    def reportesServ = grailsApplication.classLoader.loadClass('janus.utilitarios.reportesService').newInstance()
%>

<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Obras Ingresadas
    </title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">
    <script src="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.ui.position.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.contextMenu.js')}" type="text/javascript"></script>
    <link href="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.contextMenu.css')}" rel="stylesheet" type="text/css"/>

<style>
    .letra{
        font-size: 10px;
    }
</style>

</head>

<body>

<g:if test="${flash.message}">
    <div class="span12" style="height: 35px;margin-bottom: 10px;">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
            <a class="close" data-dismiss="alert" href="#">×</a>
            <elm:poneHtml textoHtml="${flash.message}"/>
        </div>
    </div>
</g:if>

%{--<div id="detalle"></div>--}%

%{--<div class="row-fluid">--}%
%{--    <div class="span12">--}%
%{--        <a href="#" class="btn" id="regresar">--}%
%{--            <i class="icon-arrow-left"></i>--}%
%{--            Regresar--}%
%{--        </a>--}%
%{--    </div>--}%
%{--</div>--}%

<div class="row-fluid">
    <div class="span12">
        <a href="#" class="btn" id="regresar">
            <i class="icon-arrow-left"></i>
            Regresar
        </a>
        <b>Buscar Por:</b>
        <elm:select name="buscador" from = "${reportesServ.obrasPresupuestadas()}" value="${params.buscador}"
                    optionKey="campo" optionValue="nombre" optionClass="operador" id="buscador_con" style="width: 200px" />
        <b>Operación:</b>
        <span id="selOpt"></span>
        <b style="margin-left: 20px">Criterio: </b>
        <g:textField name="criterio" style="width: 160px; margin-right: 10px" value="${params.criterio ?: ''}" id="criterio_con"/>
        <a href="#" class="btn" id="buscar">
            <i class="icon-search"></i>
            Buscar
        </a>
        <a href="#" class="btn" id="imprimir" >
            <i class="icon-print"></i>
            Imprimir
        </a>
        <a href="#" class="btn" id="excel" >
            <i class="icon-print"></i>
            Excel
        </a>
    </div>
</div>

<div style="margin-top: 15px; min-height: 300px" class="vertical-container">
    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr>
            <th style="width: 10%;">
                Código
            </th>
            <th style="width: 25%;">
                Nombre
            </th>
            <th style="width: 13%;">
                Tipo
            </th>
            <th style="width: 8%">
                Fecha Reg
            </th>
            <th style="width: 21%">
                Cantón-Parroquia-Comunidad
            </th>
            <th style="width: 9%">
                Valor
            </th>
            <th style="width: 16%">
                Elaborado
            </th>
            <th style="width: 11%">
                Doc.Referencia
            </th>
            <th style="width: 9%">
                Estado
            </th>
            <th style="width: 1%">
            </th>
        </tr>
        </thead>
    </table>
    <div id="detalle">
    </div>
</div>


<script type="text/javascript">

    function loading(div) {
        y = 0;
        $("#" + div).html("<div class='tituloChevere' id='loading'>Cargando, Espere por favor</div>");
        var interval = setInterval(function () {
            if (y == 30) {
                $("#detalle").html("<div class='tituloChevere' id='loading'>Cargando, Espere por favor</div>");
                y = 0
            }
            $("#loading").append(".");
            y++
        }, 100);
        return interval
    }
    function cargarTabla() {
        var interval = loading("detalle");
        var datos = "";
        datos = "si=${"si"}&buscador=" + $("#buscador_reg1").val() + "&estado=" + $("#estado_reg1").val()
        $.ajax({type : "POST", url : "${g.createLink(controller: 'reportes4',action:'tablaRegistradas')}",
            data     : datos,
            success  : function (msg) {
                clearInterval(interval);
                $("#detalle").html(msg)
            }
        });
    }

    $(function () {
        cargarTabla();
    });
</script>
</body>
</html>

