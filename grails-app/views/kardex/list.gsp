<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Kardex</title>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">

    <style type="text/css">

    .alinear {
        text-align: center !important;
    }
    </style>

</head>

<body>

<g:if test="${flash.message}">
    <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
        <a class="close" data-dismiss="alert" href="#">×</a>
        ${flash.message}
    </div>
</g:if>

<div id="busqueda" style="overflow: hidden">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Grupo</div>

            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
                <div class="span2">
                    <g:select name="buscarGrupo" class="buscarGrupo"
                              from="['1': 'Materiales', '3': 'Equipos']"
                              style="width: 100%" optionKey="key" optionValue="value"/>
                </div>

                <div class="span2"><g:select name="buscarPor" class="buscarPor" from="${[1: 'Nombre', 2: 'Código']}"
                                             style="width: 100%" optionKey="key"
                                             optionValue="value"/>
                </div>

                <div class="span2">
                    <g:textField name="criterio" class="criterio" style="width: 80%"/>
                </div>

                <div class="span2">
                    <g:select name="ordenar" class="ordenar" from="${[1: 'Nombre', 2: 'Código']}"
                              style="width: 100%" optionKey="key"
                              optionValue="value"/>
                </div>

                <div class="span4" style="margin-left: 20px">
                    <button class="btn btn-info" id="btnConsultar"><i
                            class="icon-check"></i> Consultar
                    </button>
                    <button class="btn btn-info" id="btnLimpiar"><i
                            class="fa fa-paint-brush"></i> Limpiar
                    </button>

                </div>
        </div>

        <div id="divTabla">
        </div>
</div>

<div>
    <strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retornacomo máximo 100
</div>


<div class="modal hide fade" id="modal-showProveedor" style="width: 600px;">
    <div class="modal-header" id="modalHeaderShow">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitleShow"></h3>
    </div>

    <div class="modal-body" id="modalBodyShow">
    </div>

    <div class="modal-footer" id="modalFooterShow">
    </div>
</div>

<script type="text/javascript">

    $("#btnLimpiar").click(function () {
        $("#buscarPor").val(1);
        $(".criterio").val('');
        $("#buscarGrupo").val(1);
        cargarTabla();
    });

    $("#btnConsultar").click(function () {
        cargarTabla();
    });

    cargarTabla();

    function cargarTabla() {
        var buscarPor = $("#buscarPor").val();
        var criterio = $(".criterio").val();
        var ordenar = $("#ordenar").val();
        var grupo = $("#buscarGrupo option:selected").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'kardex', action:'tabla_ajax')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar,
                grupo: grupo
            },
            success: function (msg) {
                $("#divTabla").html(msg);
            }
        });
    }

    $(".criterio").keyup(function (ev) {
        if (ev.keyCode === 13) {
            cargarTabla();
        }
    });

</script>

</body>
</html>