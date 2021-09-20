
<%@ page import="janus.Grupo" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Copiar Rubros
    </title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">
    <script src="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.ui.position.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.contextMenu.js')}" type="text/javascript"></script>
    <link href="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.contextMenu.css')}" rel="stylesheet" type="text/css"/>
</head>

<body>

<g:if test="${flash.message}">
    <div class="span12" style="height: 35px;margin-bottom: 10px;">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
            <a class="close" data-dismiss="alert" href="#">×</a>
            ${flash.message}
        </div>
    </div>
</g:if>

<div class="row-fluid" style="margin-left: 0px">

    <div class="span2">
        <a href="#" class="btn" id="regresar">
            <i class="icon-arrow-left"></i>
            Regresar
        </a>
    </div>

    <div class="span5" style="width: 550px">
        <b>Subpresupuesto de origen:</b>
        <g:select name="subpresupuestoOrg" from="${origen}" optionKey="id" optionValue="descripcion"
                  style="width: 300px;font-size: 10px; margin-left: 50px" id="subPres_desc"/>
    </div>
</div>

<div class="row-fluid">
    <div class="span2"></div>
    <div class="span5" style="width: 550px">
        <b>Subpresupuesto de destino:</b>
        <span id="divDestino"></span>

    </div>
    <div class="span4" style="width: 400px">

        <a href="#" class="btn  " id="copiar_todos">
            <i class="icon-copy"></i>
            Copiar <strong style="color: #67a153">Todos</strong>
        </a>
        <a href="#" class="btn  " id="copiar_sel">
            <i class="icon-copy"></i>
            Copiar rubros <strong style="color: #67a153">seleccionados</strong>
        </a>
    </div>

</div>

<table class="table table-bordered table-striped table-condensed table-hover">
    <thead>
    <tr>
        <th style="width: 10px;">
            *
        </th>
        <th style="width: 20px;">
            #
        </th>
        <th style="width: 200px;">
            Subpresupuesto
        </th>
        <th style="width: 80px;">
            Código
        </th>
        <th style="width: 400px;">
            Rubro
        </th>
        <th style="width: 60px" class="col_unidad">
            Unidad
        </th>
        <th style="width: 80px">
            Cantidad
        </th>
        <th class="col_precio" style="display: none;">Unitario</th>
        <th class="col_total" style="display: none;">C.Total</th>
    </tr>
    </thead>
</table>

<div id="detalle"></div>

<script type="text/javascript">

    cargarDestinos($("#subPres_desc option:selected").val());

    function cargarDestinos(origen){
        $.ajax({
            type : "POST",
            url : "${g.createLink(controller: 'volumenObra',action:'destino_ajax')}",
            data     : {
                obra: '${obra?.id}',
                origen: origen
            },
            success  : function (msg) {
                $("#divDestino").html(msg)
            }
        });
    }

    cargarTablaOrigen($("#subPres_desc option:selected").val());

    function cargarTablaOrigen(subpresupuesto){
        var interval = loading("detalle");
        $.ajax({
            type : "POST",
            url : "${g.createLink(controller: 'volumenObra',action:'tablaCopiarRubro')}",
            data     : {
                obra: '${obra?.id}',
                sub: subpresupuesto
            },
            success  : function (msg) {
                clearInterval(interval);
                $("#detalle").html(msg)
            }
        });
    }

    $("#subPres_desc").change(function(){
        var sub = $(this).val();
        cargarTablaOrigen(sub);
        cargarDestinos(sub);
    });

    function loading(div) {
        y = 0;
        return setInterval(function () {
            if (y == 30) {
                $("#detalle").html("<div class='tituloChevere' id='loading'>Cargando, Espere por favor</div>");
                y = 0
            }
            $("#loading").append(".");
            y++
        }, 500);
    }

</script>
</body>
</html>