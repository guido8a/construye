<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/09/21
  Time: 9:57
--%>

<%@ page import="janus.Grupo" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Copiar Rubros de Obra
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

<div class="row-fluid">
    <div class="span2">
        <a href="#" class="btn" id="btnRegresarVol">
            <i class="icon-arrow-left"></i>
            Regresar
        </a>
    </div>
</div>


<div style="border-bottom: 1px solid black;padding-left: 50px;position: relative; margin-bottom: 10px">

    <p class="css-vertical-text">Obra</p>

    <div class="linea" style="height: 50px;"></div>

    <div class="row-fluid" style="margin-top: 10px">
        <div class="span2" style="width: 130px;">
            <g:hiddenField name="obra__id"/>
            Obra
            <input type="text" name="obra" class="span20 allCaps required input-small"
                   value="${''}" id="input_codigo" readonly="true"
                   maxlength="30" minlength="2">

            <p class="help-block ui-helper-hidden"></p>
        </div>

        <div class="span1" style="margin-top: 20px; width: 80px">
            <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar" id="buscar_codigo">
                <i class="icon-search"></i> Buscar
            </a>
        </div>

        <div class="span8" style="margin-left: 10px">
            Descripción
            <input type="text" name="nombre" class="span12" value="${''}" id="obradscr" readonly="true">
        </div>
    </div>
</div>


<div class="row-fluid hidden" id="divSubpresupuestos">

    <div class="span4" style="text-align: center">
        <b>Subpresupuesto de origen:</b>
        <span id="divOrigen"></span>

    </div>

    <div class="span4" style="text-align: center">
        <b>Subpresupuesto de destino:</b>
        <span>
            <g:select name="subpresupuestoDes" from="${destinos}" optionKey="id" optionValue="descripcion" style="width: 300px;font-size: 10px; 5px" id="subPres_destino"
                      noSelection="['' : ' - Seleccione un subpresupuesto - ']"/>
        </span>

    </div>

    <div class="span4" style="margin-top: 20px">
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

<table class="table table-bordered table-striped table-condensed table-hover hidden" id="tabla" style="margin-top: 10px">
    <thead>
    <tr>
        <th style="width: 5%;">
            *
        </th>
        <th style="width: 5%;">
            #
        </th>
        <th style="width: 20%;">
            Subpresupuesto
        </th>
        <th style="width: 7%;">
            Código
        </th>
        <th style="width: 50px;">
            Rubro
        </th>
        <th style="width: 5%" class="col_unidad">
            Unidad
        </th>
        <th style="width: 8%">
            Cantidad
        </th>
        %{--        <th class="col_precio" style="display: none;">Unitario</th>--}%
        %{--        <th class="col_total" style="display: none;">C.Total</th>--}%
    </tr>
    </thead>
</table>

<div id="detalle"></div>


<div id="buscarObra" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarPorObra" class="buscarPor" from="${[1: 'Obra', 2: 'Código']}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterioObra" id="criterio" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarObra" class="ordenar" from="${[1: 'Obra', 2: 'Código']}" style="width: 100%" optionKey="key"
                          optionValue="value"/>
            </div>

            <div class="span2" style="margin-left: 60px">
                <button class="btn btn-info" id="btn-obras"><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaObra" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>


<script type="text/javascript">

    $("#btnRegresarVol").click(function () {
        location.href = "${g.createLink(controller: 'volumenObra', action: 'volObra', id: obra?.id)}"
    });

    $("#buscar_codigo").click(function () {
        $("#buscarObra").dialog("open");
        $(".ui-dialog-titlebar-close").html("x");
        return false;
    });

    $("#buscarObra").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: false,
        width: 1000,
        height: 600,
        position: 'center',
        title: 'Obras'
    });

    $("#btn-obras").click(function () {
        buscarObras();
    });

    function buscarObras() {
        var buscarPor = $(".buscarPor").val();
        var criterio = $("#criterio").val();
        var ordenar = $(".ordenar").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'volumenObra', action:'listaObras')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar,
                obra: '${obra?.id}'
            },
            success: function (msg) {
                $("#divTablaObra").html(msg);
            }
        });
    }

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